"""
Business AI Advisor - API Server

FastAPI-based server for AI-powered business analysis, streaming, and theme management.
Authentication handled by separate AUTH-API service.

Version 2.0.1 - JWT Authentication Integration
"""

import os
import uuid
import asyncio
import json
from datetime import datetime
from typing import Dict, List, Optional
from contextlib import asynccontextmanager

from fastapi import FastAPI, WebSocket, WebSocketDisconnect, HTTPException, Depends, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, StreamingResponse
import structlog
import redis.asyncio as redis
from pydantic import BaseModel, Field

# Import our modules
from models.schemas import AnalysisRequest, AnalysisResponse, JobStatus
from auth.middleware import get_current_session
from routes.analysis import router as analysis_router
from routes.status import router as status_router
from routes.streaming import router as streaming_router
from routes.appearance import router as appearance_router
from routes.onboarding import router as onboarding_router
from routes.smart_hub import router as smart_hub_router
from services.option_sets_cache import option_sets_cache
from config.database import init_database, init_redis, close_database, check_database_health, check_redis_health

# Configure structured logging
structlog.configure(
    processors=[
        structlog.stdlib.filter_by_level,
        structlog.stdlib.add_logger_name,
        structlog.stdlib.add_log_level,
        structlog.stdlib.PositionalArgumentsFormatter(),
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.StackInfoRenderer(),
        structlog.processors.format_exc_info,
        structlog.processors.UnicodeDecoder(),
        structlog.processors.JSONRenderer()
    ],
    context_class=dict,
    logger_factory=structlog.stdlib.LoggerFactory(),
    cache_logger_on_first_use=True,
)

logger = structlog.get_logger()

# Global variables for connections
redis_client: Optional[redis.Redis] = None
websocket_connections: Dict[str, WebSocket] = {}

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifecycle management"""
    global redis_client
    
    # Startup
    logger.info("Starting API server...")
    
    # Initialize Database
    try:
        await init_database()
        logger.info("Database initialized successfully")
    except Exception as e:
        logger.error("Failed to initialize database", error=str(e))
        # Don't fail startup - continue without database for development
    
    # Initialize Redis connection
    try:
        redis_client = await init_redis()
        logger.info("Redis initialized successfully")
    except Exception as e:
        logger.error("Failed to connect to Redis", error=str(e))
        redis_client = None
        # Don't fail startup - continue without Redis for development
    
    # Initialize Appearance Cache
    try:
        await option_sets_cache.load_cache()
        logger.info("Appearance cache initialized successfully")
    except Exception as e:
        logger.error("Failed to initialize appearance cache", error=str(e))
        # Don't fail startup - continue without cache for development
    
    yield
    
    # Shutdown
    logger.info("Shutting down API server...")
    await close_database()

# Create FastAPI app
app = FastAPI(
    title="Business AI Advisor API",
    description="AI-powered business analysis, streaming, and theme management. Auth handled by AUTH-API.",
    version="2.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan
)

# CORS middleware - allow frontend access
# Default to allow all origins for development
allowed_origins_str = os.getenv("ALLOWED_ORIGINS", "*")
if allowed_origins_str == "*":
    allowed_origins = ["*"]
else:
    allowed_origins = [origin.strip() for origin in allowed_origins_str.split(",")]

logger.info("CORS configuration", allowed_origins=allowed_origins, credentials=True)

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"],
    allow_headers=["*"],
    expose_headers=["*"],
)

# Include routers - Business Logic: Analysis + Status + WebSocket streaming + Appearance + Onboarding + Smart Hub
app.include_router(analysis_router, prefix="/api/v1", tags=["analysis"])
app.include_router(status_router, prefix="/api/v1", tags=["status"])
app.include_router(streaming_router, prefix="/api/v1", tags=["streaming"])
app.include_router(appearance_router, prefix="/api/v1", tags=["appearance"])
app.include_router(smart_hub_router, prefix="/api/v1", tags=["smart-hub"])
app.include_router(onboarding_router)  # Prefix already in router definition

@app.get("/health")
async def health_check():
    """Health check endpoint for load balancer and monitoring"""
    health_status = {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "service": "api-server",
        "version": "1.0.0",
        "instance_id": os.getenv("INSTANCE_ID", "main"),
        "load_balancer_ready": True
    }
    
    # Check Database connection
    try:
        db_health = await check_database_health()
        health_status["database"] = db_health
        if db_health["status"] != "healthy":
            health_status["status"] = "degraded"
    except Exception as e:
        health_status["database"] = {"status": "error", "message": str(e)}
        health_status["status"] = "degraded"
    
    # Check Redis connection  
    try:
        redis_health = await check_redis_health()
        health_status["redis"] = redis_health
        if redis_health["status"] != "healthy":
            health_status["status"] = "degraded"
    except Exception as e:
        health_status["redis"] = {"status": "error", "message": str(e)}
        health_status["status"] = "degraded"
    
    # Check active WebSocket connections
    health_status["websocket_connections"] = len(websocket_connections)
    
    logger.info("Health check", **health_status)
    
    # Return 200 OK even if degraded - Railway healthcheck requires 2xx/3xx
    # The status field will indicate actual health
    return health_status

@app.get("/")
async def root():
    """Root endpoint with API information"""
    return {
        "message": "Business AI Advisor API",
        "version": "1.0.1",
        "docs": "/docs",
        "health": "/health",
        "websocket": "/ws/{session_id}",
        "stream": "/stream/{session_id}"  # SSE fallback
    }

@app.post("/")
async def handle_query(request: Request):
    """Handle POST queries from Editor - Quick mock response for testing"""
    try:
        body = await request.json()
        message = body.get("message", "No message")
        
        # Simple mock response
        mock_response = {
            "status": "success",
            "response": f"✅ Connected! I received your message: '{message}'. This is mock data from the API server. The connection is working perfectly!",
            "timestamp": datetime.utcnow().isoformat(),
            "server": "Business AI Advisor API v1.0.1",
            "mock": True,
            "message_length": len(message)
        }
        
        logger.info("Query received", message=message[:100])
        return mock_response
        
    except Exception as e:
        logger.error("Query failed", error=str(e))
        return {
            "status": "error", 
            "response": f"Connection successful but query failed: {str(e)}",
            "timestamp": datetime.utcnow().isoformat(),
            "mock": True
        }

@app.websocket("/ws/{session_id}")
async def websocket_endpoint(websocket: WebSocket, session_id: str):
    """
    WebSocket endpoint for real-time streaming to Bubble frontend.
    
    This endpoint maintains a persistent connection with the Bubble app
    and streams analysis results in real-time as they become available.
    """
    # WebSocket CORS: Check Origin header
    allowed_origins = os.getenv("ALLOWED_ORIGINS", "https://aibuildd-v1.bubbleapps.io").split(",")
    origin = websocket.headers.get("origin")
    if origin and origin not in allowed_origins:
        logger.warning("WebSocket connection blocked by CORS", origin=origin)
        await websocket.close(code=4403)
        return

    await websocket.accept()
    websocket_connections[session_id] = websocket

    logger.info("WebSocket connected", session_id=session_id, origin=origin)

    try:
        # Send initial connection confirmation
        await websocket.send_json({
            "type": "connection",
            "status": "connected",
            "session_id": session_id,
            "timestamp": datetime.utcnow().isoformat()
        })

        # Keep connection alive and handle incoming messages
        while True:
            try:
                # Wait for messages from client
                data = await websocket.receive_json()

                # Handle different message types
                if data.get("type") == "ping":
                    await websocket.send_json({
                        "type": "pong",
                        "timestamp": datetime.utcnow().isoformat()
                    })

                elif data.get("type") == "subscribe":
                    # Subscribe to job updates
                    job_id = data.get("job_id")
                    if job_id and redis_client:
                        await redis_client.set(f"websocket:{job_id}", session_id)
                        await websocket.send_json({
                            "type": "subscribed",
                            "job_id": job_id
                        })
                
            except WebSocketDisconnect:
                break
            except Exception as e:
                logger.error("WebSocket error", session_id=session_id, error=str(e))
                await websocket.send_json({
                    "type": "error",
                    "message": f"Error: {str(e)}"
                })
                
    except WebSocketDisconnect:
        pass
    finally:
        # Clean up connection
        if session_id in websocket_connections:
            del websocket_connections[session_id]
        logger.info("WebSocket disconnected", session_id=session_id)

@app.get("/stream/{session_id}")
async def stream_endpoint(session_id: str, request: Request):
    """
    Server-Sent Events (SSE) endpoint as WebSocket fallback.
    
    This provides streaming capabilities for browsers that have WebSocket CORS issues.
    """
    
    # Check origin for CORS
    origin = request.headers.get("origin")
    allowed_origins = os.getenv("ALLOWED_ORIGINS", "https://aibuildd-v1.bubbleapps.io").split(",")
    
    async def event_stream():
        try:
            # Send initial connection event
            yield f"data: {json.dumps({'type': 'connection', 'status': 'connected', 'session_id': session_id, 'timestamp': datetime.utcnow().isoformat()})}\n\n"
            
            # Keep connection alive and send periodic updates
            while True:
                # Check if there are any messages for this session
                # In a real implementation, you'd check Redis or a message queue
                
                # Send heartbeat every 30 seconds
                await asyncio.sleep(30)
                yield f"data: {json.dumps({'type': 'heartbeat', 'timestamp': datetime.utcnow().isoformat()})}\n\n"
                
        except Exception as e:
            logger.error("SSE stream error", session_id=session_id, error=str(e))
            yield f"data: {json.dumps({'type': 'error', 'message': str(e)})}\n\n"
    
    headers = {
        "Content-Type": "text/event-stream",
        "Cache-Control": "no-cache",
        "Connection": "keep-alive",
        "Access-Control-Allow-Origin": origin if origin in allowed_origins else "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "GET, OPTIONS"
    }
    
    return StreamingResponse(event_stream(), media_type="text/event-stream", headers=headers)

async def send_to_websocket(session_id: str, data: dict):
    """Send data to a specific WebSocket connection"""
    if session_id in websocket_connections:
        try:
            websocket = websocket_connections[session_id]
            await websocket.send_json(data)
            logger.debug("Sent to WebSocket", session_id=session_id, data_type=data.get("type"))
        except Exception as e:
            logger.error("Failed to send to WebSocket", session_id=session_id, error=str(e))
            # Remove broken connection
            if session_id in websocket_connections:
                del websocket_connections[session_id]

@app.exception_handler(HTTPException)
async def http_exception_handler(request, exc):
    """Custom HTTP exception handler"""
    logger.error("HTTP exception", status_code=exc.status_code, detail=exc.detail)
    return JSONResponse(
        status_code=exc.status_code,
        content={"error": exc.detail, "timestamp": datetime.utcnow().isoformat()}
    )

@app.exception_handler(Exception)
async def general_exception_handler(request, exc):
    """General exception handler for unexpected errors"""
    logger.error("Unexpected error", error=str(exc), type=type(exc).__name__)
    return JSONResponse(
        status_code=500,
        content={
            "error": "Internal server error",
            "timestamp": datetime.utcnow().isoformat()
        }
    )

if __name__ == "__main__":
    import uvicorn
    
    port = int(os.getenv("PORT", 8000))
    host = os.getenv("HOST", "0.0.0.0")
    
    uvicorn.run(
        "main:app",
        host=host,
        port=port,
        reload=True,
        log_level="info"
    )