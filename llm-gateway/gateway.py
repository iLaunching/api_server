"""
LLM Gateway - Intelligent routing and caching for AI models

This service handles:
- OpenAI GPT integration  
- Claude (Anthropic) integration
- Response caching with Redis
- Fallback logic between models
- Cost tracking and optimization
- Rate limit handling
"""

import os
import asyncio
import json
import hashlib
from datetime import datetime, timedelta
from typing import Dict, List, Optional, AsyncGenerator
from contextlib import asynccontextmanager

import openai
import anthropic
import google.generativeai as genai
import httpx
import redis.asyncio as redis
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import structlog

# Configure logging
structlog.configure(
    processors=[
        structlog.stdlib.filter_by_level,
        structlog.stdlib.add_logger_name,
        structlog.stdlib.add_log_level,
        structlog.stdlib.PositionalArgumentsFormatter(),
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.JSONRenderer()
    ],
    context_class=dict,
    logger_factory=structlog.stdlib.LoggerFactory(),
    cache_logger_on_first_use=True,
)

logger = structlog.get_logger()

# Global connections
redis_client: Optional[redis.Redis] = None

# Models configuration
MODEL_CONFIG = {
    # OpenAI Models
    "gpt-4o": {
        "provider": "openai",
        "max_tokens": 4096,
        "cost_per_1k_tokens": 0.03,
        "rate_limit_rpm": 5000,
        "tier": "premium"
    },
    "gpt-4o-mini": {
        "provider": "openai", 
        "max_tokens": 16384,
        "cost_per_1k_tokens": 0.00015,
        "rate_limit_rpm": 10000,
        "tier": "standard"
    },
    "gpt-4-turbo": {
        "provider": "openai",
        "max_tokens": 4096,
        "cost_per_1k_tokens": 0.01,
        "rate_limit_rpm": 5000,
        "tier": "premium"
    },
    
    # Anthropic Models  
    "claude-3-5-sonnet-20241022": {
        "provider": "anthropic",
        "max_tokens": 4096,
        "cost_per_1k_tokens": 0.015,
        "rate_limit_rpm": 1000,
        "tier": "premium"
    },
    "claude-3-haiku-20240307": {
        "provider": "anthropic",
        "max_tokens": 4096, 
        "cost_per_1k_tokens": 0.00025,
        "rate_limit_rpm": 2000,
        "tier": "budget"
    },
    "claude-3-5-haiku-20241022": {
        "provider": "anthropic",
        "max_tokens": 8192,
        "cost_per_1k_tokens": 0.001,
        "rate_limit_rpm": 2000,
        "tier": "standard"
    },
    
    # Google Gemini Models
    "gemini-1.5-pro": {
        "provider": "google",
        "max_tokens": 8192,
        "cost_per_1k_tokens": 0.0035,
        "rate_limit_rpm": 2000,
        "tier": "standard"
    },
    "gemini-1.5-flash": {
        "provider": "google",
        "max_tokens": 8192,
        "cost_per_1k_tokens": 0.000075,
        "rate_limit_rpm": 15000,
        "tier": "budget"
    },
    "gemini-1.5-flash-8b": {
        "provider": "google",
        "max_tokens": 8192,
        "cost_per_1k_tokens": 0.0000375,
        "rate_limit_rpm": 20000,
        "tier": "ultra-budget"
    },
    
    # DeepSeek Models
    "deepseek-chat": {
        "provider": "deepseek",
        "max_tokens": 4096,
        "cost_per_1k_tokens": 0.00014,
        "rate_limit_rpm": 5000,
        "tier": "budget"
    },
    "deepseek-coder": {
        "provider": "deepseek",
        "max_tokens": 4096,
        "cost_per_1k_tokens": 0.00014,
        "rate_limit_rpm": 5000,
        "tier": "budget"
    }
}

class LLMRequest(BaseModel):
    """LLM request schema"""
    messages: List[Dict[str, str]]
    model: str = Field(default="gpt-4o-mini", description="LLM model to use")
    max_tokens: Optional[int] = Field(default=1000, le=4096)
    temperature: Optional[float] = Field(default=0.7, ge=0.0, le=2.0)
    stream: bool = Field(default=False, description="Enable streaming response")
    cache_ttl: Optional[int] = Field(default=3600, description="Cache TTL in seconds")
    user_id: Optional[str] = Field(default=None, description="User ID for tracking")

class LLMResponse(BaseModel):
    """LLM response schema"""
    model_config = {"protected_namespaces": ()}
    
    content: str
    model_used: str
    tokens_used: int
    cost_usd: float
    cached: bool
    response_time_ms: int
    timestamp: str

# Startup and shutdown
@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan management"""
    global redis_client
    
    # Startup
    try:
        # Initialize Redis connection
        redis_url = os.getenv("REDIS_URL", "redis://localhost:6379")
        redis_client = redis.from_url(redis_url, decode_responses=True)
        await redis_client.ping()
        logger.info("LLM Gateway started", redis_connected=True)
        
        # Initialize OpenAI client
        openai.api_key = os.getenv("OPENAI_API_KEY")
        if not openai.api_key:
            logger.warning("OPENAI_API_KEY not set")
            
        # Initialize Anthropic client  
        anthropic_key = os.getenv("ANTHROPIC_API_KEY")
        if not anthropic_key:
            logger.warning("ANTHROPIC_API_KEY not set")
            
        # Initialize Google Gemini
        google_key = os.getenv("GOOGLE_API_KEY")
        if google_key:
            try:
                import google.generativeai as genai
                genai.configure(api_key=google_key)
                logger.info("Google Gemini initialized")
            except ImportError:
                logger.warning("Google Generative AI library not installed")
        else:
            logger.warning("GOOGLE_API_KEY not set")
            
        # DeepSeek uses OpenAI-compatible API
        deepseek_key = os.getenv("DEEPSEEK_API_KEY")
        if not deepseek_key:
            logger.warning("DEEPSEEK_API_KEY not set")
            
        yield
        
    except Exception as e:
        logger.error("Failed to start LLM Gateway", error=str(e))
        raise
    finally:
        # Shutdown
        if redis_client:
            await redis_client.close()
        logger.info("LLM Gateway stopped")

# FastAPI app
app = FastAPI(
    title="LLM Gateway",
    description="Intelligent routing and caching for AI models",
    version="1.0.0",
    lifespan=lifespan
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Utility functions
def generate_cache_key(request: LLMRequest) -> str:
    """Generate cache key for request"""
    cache_data = {
        "messages": request.messages,
        "model": request.model,
        "max_tokens": request.max_tokens,
        "temperature": request.temperature
    }
    cache_string = json.dumps(cache_data, sort_keys=True)
    return f"llm_cache:{hashlib.md5(cache_string.encode()).hexdigest()}"

def select_optimal_model(request: LLMRequest, task_type: str = "general") -> str:
    """Select optimal model based on task type and requirements"""
    
    # If model is explicitly specified and available, use it
    if request.model and request.model in MODEL_CONFIG:
        return request.model
    
    # Smart model selection based on task type
    task_models = {
        "coding": ["deepseek-coder", "gpt-4o", "claude-3-5-sonnet-20241022"],
        "analysis": ["claude-3-5-sonnet-20241022", "gpt-4o", "gemini-1.5-pro"],
        "creative": ["claude-3-5-sonnet-20241022", "gpt-4o", "gemini-1.5-pro"],
        "summarization": ["claude-3-5-haiku-20241022", "gpt-4o-mini", "gemini-1.5-flash"],
        "translation": ["gpt-4o", "claude-3-5-sonnet-20241022", "gemini-1.5-pro"],
        "qa": ["gpt-4o-mini", "gemini-1.5-flash", "claude-3-haiku-20240307"],
        "general": ["gpt-4o-mini", "gemini-1.5-flash", "claude-3-5-haiku-20241022"],
        "budget": ["gemini-1.5-flash-8b", "deepseek-chat", "claude-3-haiku-20240307"],
        "premium": ["claude-3-5-sonnet-20241022", "gpt-4o", "gemini-1.5-pro"]
    }
    
    # Get preferred models for task
    preferred_models = task_models.get(task_type, task_models["general"])
    
    # Find first available model (based on API keys)
    provider_status = {
        "openai": bool(os.getenv("OPENAI_API_KEY")),
        "anthropic": bool(os.getenv("ANTHROPIC_API_KEY")), 
        "google": bool(os.getenv("GOOGLE_API_KEY")),
        "deepseek": bool(os.getenv("DEEPSEEK_API_KEY"))
    }
    
    for model_name in preferred_models:
        if model_name in MODEL_CONFIG:
            provider = MODEL_CONFIG[model_name]["provider"]
            if provider_status.get(provider, False):
                return model_name
    
    # Fallback to any available model
    for model_name, config in MODEL_CONFIG.items():
        provider = config["provider"]
        if provider_status.get(provider, False):
            return model_name
    
    # If no models available, return default (will fail gracefully)
    return "gpt-4o-mini"

async def get_cached_response(cache_key: str) -> Optional[Dict]:
    """Get cached response if available"""
    try:
        if redis_client:
            cached = await redis_client.get(cache_key)
            if cached:
                return json.loads(cached)
    except Exception as e:
        logger.warning("Cache read failed", error=str(e))
    return None

async def cache_response(cache_key: str, response: Dict, ttl: int):
    """Cache response"""
    try:
        if redis_client:
            await redis_client.setex(
                cache_key, 
                ttl, 
                json.dumps(response)
            )
    except Exception as e:
        logger.warning("Cache write failed", error=str(e))

async def call_openai(request: LLMRequest) -> Dict:
    """Call OpenAI API"""
    try:
        client = openai.AsyncOpenAI(api_key=os.getenv("OPENAI_API_KEY"))
        
        start_time = datetime.now()
        
        if request.stream:
            # Streaming response
            stream = await client.chat.completions.create(
                model=request.model,
                messages=request.messages,
                max_tokens=request.max_tokens,
                temperature=request.temperature,
                stream=True
            )
            return {"stream": stream, "start_time": start_time}
        else:
            # Regular response
            response = await client.chat.completions.create(
                model=request.model,
                messages=request.messages,
                max_tokens=request.max_tokens,
                temperature=request.temperature
            )
            
            end_time = datetime.now()
            response_time_ms = int((end_time - start_time).total_seconds() * 1000)
            
            return {
                "content": response.choices[0].message.content,
                "tokens_used": response.usage.total_tokens,
                "response_time_ms": response_time_ms
            }
            
    except Exception as e:
        logger.error("OpenAI API call failed", error=str(e))
        raise HTTPException(status_code=503, detail=f"OpenAI API error: {str(e)}")

async def call_anthropic(request: LLMRequest) -> Dict:
    """Call Anthropic API"""
    try:
        client = anthropic.AsyncAnthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))
        
        # Convert messages format for Claude
        system_message = ""
        user_messages = []
        for msg in request.messages:
            if msg["role"] == "system":
                system_message = msg["content"]
            else:
                user_messages.append(msg)
        
        start_time = datetime.now()
        
        if request.stream:
            # Streaming response
            stream = await client.messages.create(
                model=request.model,
                max_tokens=request.max_tokens,
                temperature=request.temperature,
                system=system_message,
                messages=user_messages,
                stream=True
            )
            return {"stream": stream, "start_time": start_time}
        else:
            # Regular response
            response = await client.messages.create(
                model=request.model,
                max_tokens=request.max_tokens,
                temperature=request.temperature,
                system=system_message,
                messages=user_messages
            )
            
            end_time = datetime.now()
            response_time_ms = int((end_time - start_time).total_seconds() * 1000)
            
            return {
                "content": response.content[0].text,
                "tokens_used": response.usage.input_tokens + response.usage.output_tokens,
                "response_time_ms": response_time_ms
            }
            
    except Exception as e:
        logger.error("Anthropic API call failed", error=str(e))
        raise HTTPException(status_code=503, detail=f"Anthropic API error: {str(e)}")

async def call_google(request: LLMRequest) -> Dict:
    """Call Google Gemini API"""
    try:
        import google.generativeai as genai
        
        # Configure the model
        model = genai.GenerativeModel(request.model)
        
        # Convert messages to Gemini format
        prompt_parts = []
        for msg in request.messages:
            if msg["role"] == "system":
                prompt_parts.append(f"System: {msg['content']}")
            elif msg["role"] == "user":
                prompt_parts.append(f"User: {msg['content']}")
            elif msg["role"] == "assistant":
                prompt_parts.append(f"Assistant: {msg['content']}")
        
        prompt = "\n\n".join(prompt_parts)
        
        start_time = datetime.now()
        
        if request.stream:
            # Streaming response
            response = model.generate_content(
                prompt,
                generation_config=genai.types.GenerationConfig(
                    max_output_tokens=request.max_tokens,
                    temperature=request.temperature,
                ),
                stream=True
            )
            return {"stream": response, "start_time": start_time}
        else:
            # Regular response
            response = model.generate_content(
                prompt,
                generation_config=genai.types.GenerationConfig(
                    max_output_tokens=request.max_tokens,
                    temperature=request.temperature,
                )
            )
            
            end_time = datetime.now()
            response_time_ms = int((end_time - start_time).total_seconds() * 1000)
            
            # Estimate token usage (Gemini doesn't always provide exact counts)
            estimated_tokens = len(response.text.split()) * 1.3  # Rough estimation
            
            return {
                "content": response.text,
                "tokens_used": int(estimated_tokens),
                "response_time_ms": response_time_ms
            }
            
    except ImportError:
        logger.error("Google Generative AI library not installed")
        raise HTTPException(status_code=503, detail="Google Generative AI library not available")
    except Exception as e:
        logger.error("Google API call failed", error=str(e))
        raise HTTPException(status_code=503, detail=f"Google API error: {str(e)}")

async def call_deepseek(request: LLMRequest) -> Dict:
    """Call DeepSeek API (OpenAI-compatible)"""
    try:
        # DeepSeek uses OpenAI-compatible API
        client = openai.AsyncOpenAI(
            api_key=os.getenv("DEEPSEEK_API_KEY"),
            base_url="https://api.deepseek.com"
        )
        
        start_time = datetime.now()
        
        if request.stream:
            # Streaming response
            stream = await client.chat.completions.create(
                model=request.model,
                messages=request.messages,
                max_tokens=request.max_tokens,
                temperature=request.temperature,
                stream=True
            )
            return {"stream": stream, "start_time": start_time}
        else:
            # Regular response
            response = await client.chat.completions.create(
                model=request.model,
                messages=request.messages,
                max_tokens=request.max_tokens,
                temperature=request.temperature
            )
            
            end_time = datetime.now()
            response_time_ms = int((end_time - start_time).total_seconds() * 1000)
            
            return {
                "content": response.choices[0].message.content,
                "tokens_used": response.usage.total_tokens,
                "response_time_ms": response_time_ms
            }
            
    except Exception as e:
        logger.error("DeepSeek API call failed", error=str(e))
        raise HTTPException(status_code=503, detail=f"DeepSeek API error: {str(e)}")

# API Routes
@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "LLM Gateway API",
        "version": "1.0.0",
        "models": list(MODEL_CONFIG.keys()),
        "health": "/health"
    }

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    health_status = {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "service": "llm-gateway",
        "version": "1.0.0"
    }
    
    # Check Redis connection
    try:
        if redis_client:
            await redis_client.ping()
            health_status["redis"] = {"status": "healthy", "message": "Connected"}
        else:
            health_status["redis"] = {"status": "not_configured", "message": "Redis not configured"}
    except Exception as e:
        health_status["redis"] = {"status": "unhealthy", "message": str(e)}
        health_status["status"] = "degraded"
    
    # Check API keys
    health_status["providers"] = {
        "openai": {"configured": bool(os.getenv("OPENAI_API_KEY"))},
        "anthropic": {"configured": bool(os.getenv("ANTHROPIC_API_KEY"))},
        "google": {"configured": bool(os.getenv("GOOGLE_API_KEY"))},
        "deepseek": {"configured": bool(os.getenv("DEEPSEEK_API_KEY"))}
    }
    
    # Count available models
    available_models = [
        model for model, config in MODEL_CONFIG.items()
        if health_status["providers"][config["provider"]]["configured"]
    ]
    health_status["available_models"] = len(available_models)
    health_status["total_models"] = len(MODEL_CONFIG)
    
    return health_status

@app.get("/models")
async def list_models():
    """List available models grouped by provider and tier"""
    
    # Group models by provider
    by_provider = {}
    by_tier = {"ultra-budget": [], "budget": [], "standard": [], "premium": []}
    
    for model_name, config in MODEL_CONFIG.items():
        provider = config["provider"]
        tier = config.get("tier", "standard")
        
        if provider not in by_provider:
            by_provider[provider] = []
        
        model_info = {
            "name": model_name,
            "cost_per_1k_tokens": config["cost_per_1k_tokens"],
            "max_tokens": config["max_tokens"],
            "tier": tier
        }
        
        by_provider[provider].append(model_info)
        by_tier[tier].append(model_info)
    
    # Recommend models by use case
    recommendations = {
        "cheapest": "gemini-1.5-flash-8b",      # $0.0000375/1K
        "fastest": "gemini-1.5-flash",          # High rate limit
        "balanced": "gpt-4o-mini",              # Good quality/cost ratio
        "premium": "claude-3-5-sonnet-20241022", # Best quality
        "coding": "deepseek-coder",             # Specialized for code
        "general": "gpt-4o-mini"                # Default choice
    }
    
    return {
        "models_by_provider": by_provider,
        "models_by_tier": by_tier,
        "recommendations": recommendations,
        "total_models": len(MODEL_CONFIG),
        "default": "gpt-4o-mini"
    }

@app.get("/models/recommend/{task_type}")
async def recommend_model(task_type: str):
    """Recommend optimal model for specific task type"""
    
    valid_tasks = ["coding", "analysis", "creative", "summarization", "translation", "qa", "general", "budget", "premium"]
    
    if task_type not in valid_tasks:
        raise HTTPException(
            status_code=400,
            detail=f"Invalid task type. Valid types: {valid_tasks}"
        )
    
    # Create dummy request to use selection logic
    dummy_request = LLMRequest(
        messages=[{"role": "user", "content": "test"}],
        model=""
    )
    
    recommended_model = select_optimal_model(dummy_request, task_type)
    model_config = MODEL_CONFIG.get(recommended_model, {})
    
    return {
        "task_type": task_type,
        "recommended_model": recommended_model,
        "provider": model_config.get("provider"),
        "cost_per_1k_tokens": model_config.get("cost_per_1k_tokens"),
        "tier": model_config.get("tier"),
        "reasoning": f"Optimized for {task_type} tasks with best balance of quality, speed, and cost"
    }

@app.post("/generate", response_model=LLMResponse)
async def generate_completion(request: LLMRequest, task_type: str = "general"):
    """Generate LLM completion with smart model selection"""
    
    # Auto-select model if not specified or invalid
    if not request.model or request.model not in MODEL_CONFIG:
        request.model = select_optimal_model(request, task_type)
        logger.info("Auto-selected model", model=request.model, task_type=task_type)
    
    # Validate final model selection
    if request.model not in MODEL_CONFIG:
        raise HTTPException(
            status_code=503, 
            detail=f"No available models for provider. Configure API keys for: {list(set(config['provider'] for config in MODEL_CONFIG.values()))}"
        )
    
    model_config = MODEL_CONFIG[request.model]
    
    # Check cache (non-streaming only)
    cached_response = None
    if not request.stream and request.cache_ttl > 0:
        cache_key = generate_cache_key(request)
        cached_response = await get_cached_response(cache_key)
        
        if cached_response:
            logger.info("Cache hit", model=request.model, cache_key=cache_key[:16])
            return LLMResponse(**cached_response, cached=True)
    
    # Call appropriate provider
    try:
        provider = model_config["provider"]
        if provider == "openai":
            result = await call_openai(request)
        elif provider == "anthropic":
            result = await call_anthropic(request)
        elif provider == "google":
            result = await call_google(request)
        elif provider == "deepseek":
            result = await call_deepseek(request)
        else:
            raise HTTPException(status_code=500, detail=f"Unsupported provider: {provider}")
        
        # Calculate cost
        cost_usd = (result["tokens_used"] / 1000) * model_config["cost_per_1k_tokens"]
        
        # Prepare response
        response_data = {
            "content": result["content"],
            "model_used": request.model,
            "tokens_used": result["tokens_used"],
            "cost_usd": round(cost_usd, 6),
            "cached": False,
            "response_time_ms": result["response_time_ms"],
            "timestamp": datetime.utcnow().isoformat()
        }
        
        # Cache response (non-streaming only)
        if not request.stream and request.cache_ttl > 0:
            await cache_response(cache_key, response_data, request.cache_ttl)
        
        logger.info(
            "LLM completion generated",
            model=request.model,
            tokens=result["tokens_used"],
            cost=cost_usd,
            response_time=result["response_time_ms"]
        )
        
        return LLMResponse(**response_data)
        
    except Exception as e:
        logger.error("LLM generation failed", error=str(e), model=request.model)
        raise

if __name__ == "__main__":
    import uvicorn
    
    port = int(os.getenv("PORT", 8001))
    host = os.getenv("HOST", "0.0.0.0")
    
    uvicorn.run(
        "gateway:app",
        host=host,
        port=port,
        reload=False,
        log_level="info"
    )