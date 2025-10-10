"""
Chat endpoints for direct LLM interaction.
"""

import os
import httpx
from datetime import datetime
from typing import Dict, Any, List
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel, Field
import structlog

from auth.middleware import get_current_session

logger = structlog.get_logger()
router = APIRouter()

# Get LLM Gateway URL from environment
LLM_GATEWAY_URL = os.getenv("LLM_GATEWAY_URL", "https://ilaunching-llm-server-production.up.railway.app")

class ChatMessage(BaseModel):
    """Chat message schema"""
    role: str = Field(..., description="Message role: user, assistant, or system")
    content: str = Field(..., description="Message content")

class ChatRequest(BaseModel):
    """Chat request schema"""
    messages: List[ChatMessage] = Field(..., description="Conversation messages")
    model: str = Field(default="gpt-4o-mini", description="AI model to use")
    max_tokens: int = Field(default=1000, ge=1, le=4096, description="Maximum tokens to generate")
    temperature: float = Field(default=0.7, ge=0.0, le=2.0, description="Response creativity (0=focused, 2=creative)")
    task_type: str = Field(default="general", description="Task type for smart model selection")

class ChatResponse(BaseModel):
    """Chat response schema"""
    content: str = Field(..., description="AI response content")
    model_used: str = Field(..., description="Actual model used")
    tokens_used: int = Field(..., description="Tokens consumed")
    cost_usd: float = Field(..., description="Cost in USD")
    response_time_ms: int = Field(..., description="Response time in milliseconds")
    timestamp: str = Field(..., description="Response timestamp")

@router.post("/chat", response_model=ChatResponse)
async def chat_with_ai(
    request: ChatRequest,
    session_id: str = Depends(get_current_session)
):
    """
    Chat with AI models through the LLM Gateway.
    
    Supports 12 different AI models across 4 providers:
    - OpenAI: gpt-4o, gpt-4o-mini, gpt-4-turbo
    - Anthropic: claude-3-5-sonnet-20241022, claude-3-haiku-20240307, claude-3-5-haiku-20241022
    - Google: gemini-1.5-pro, gemini-1.5-flash, gemini-1.5-flash-8b
    - DeepSeek: deepseek-chat, deepseek-coder
    """
    
    logger.info(
        "Chat request received",
        session_id=session_id,
        model=request.model,
        task_type=request.task_type,
        message_count=len(request.messages)
    )
    
    try:
        # Prepare request for LLM Gateway
        gateway_request = {
            "messages": [{"role": msg.role, "content": msg.content} for msg in request.messages],
            "model": request.model,
            "max_tokens": request.max_tokens,
            "temperature": request.temperature,
            "stream": False,
            "cache_ttl": 3600,
            "user_id": session_id
        }
        
        # Add task_type for smart model selection if model not specified
        if request.model == "auto" or request.task_type != "general":
            gateway_url = f"{LLM_GATEWAY_URL}/generate?task_type={request.task_type}"
        else:
            gateway_url = f"{LLM_GATEWAY_URL}/generate"
        
        # Call LLM Gateway
        async with httpx.AsyncClient(timeout=60.0) as client:
            response = await client.post(
                gateway_url,
                json=gateway_request,
                headers={"Content-Type": "application/json"}
            )
            
            if response.status_code != 200:
                logger.error(
                    "LLM Gateway error",
                    status_code=response.status_code,
                    response=response.text
                )
                raise HTTPException(
                    status_code=503,
                    detail=f"LLM Gateway error: {response.status_code}"
                )
            
            gateway_response = response.json()
            
            # Log successful chat
            logger.info(
                "Chat completed",
                session_id=session_id,
                model_used=gateway_response.get("model_used"),
                tokens=gateway_response.get("tokens_used"),
                cost=gateway_response.get("cost_usd"),
                response_time=gateway_response.get("response_time_ms")
            )
            
            return ChatResponse(
                content=gateway_response["content"],
                model_used=gateway_response["model_used"],
                tokens_used=gateway_response["tokens_used"],
                cost_usd=gateway_response["cost_usd"],
                response_time_ms=gateway_response["response_time_ms"],
                timestamp=gateway_response["timestamp"]
            )
            
    except httpx.TimeoutException:
        logger.error("LLM Gateway timeout", session_id=session_id)
        raise HTTPException(
            status_code=504,
            detail="LLM Gateway request timed out"
        )
    except Exception as e:
        logger.error("Chat error", session_id=session_id, error=str(e))
        raise HTTPException(
            status_code=500,
            detail=f"Chat error: {str(e)}"
        )

@router.get("/models")
async def list_available_models():
    """
    Get list of available AI models from LLM Gateway.
    """
    
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(f"{LLM_GATEWAY_URL}/models")
            
            if response.status_code == 200:
                return response.json()
            else:
                raise HTTPException(
                    status_code=503,
                    detail="Could not fetch models from LLM Gateway"
                )
                
    except Exception as e:
        logger.error("Error fetching models", error=str(e))
        raise HTTPException(
            status_code=500,
            detail=f"Models fetch error: {str(e)}"
        )

@router.get("/models/recommend/{task_type}")
async def get_model_recommendation(task_type: str):
    """
    Get model recommendation for specific task type.
    
    Valid task types: coding, analysis, creative, summarization, 
    translation, qa, general, budget, premium
    """
    
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(f"{LLM_GATEWAY_URL}/models/recommend/{task_type}")
            
            if response.status_code == 200:
                return response.json()
            else:
                raise HTTPException(
                    status_code=400,
                    detail=f"Invalid task type: {task_type}"
                )
                
    except Exception as e:
        logger.error("Error getting recommendation", task_type=task_type, error=str(e))
        raise HTTPException(
            status_code=500,
            detail=f"Recommendation error: {str(e)}"
        )