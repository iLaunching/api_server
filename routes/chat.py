"""
Chat endpoints for real-time AI conversations.
"""

import uuid
import asyncio
from datetime import datetime
from typing import Dict, Any, List
from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
import structlog
import httpx

from models.schemas import StreamMessage
from auth.middleware import get_current_session
from pydantic import BaseModel

logger = structlog.get_logger()
router = APIRouter()

class ChatRequest(BaseModel):
    """Chat request schema"""
    message: str
    model: str = "gpt-4o-mini"  # Default model
    conversation_id: str = None
    stream: bool = True  # Enable streaming by default

class ChatResponse(BaseModel):
    """Chat response schema"""
    response: str
    model_used: str
    conversation_id: str
    timestamp: str
    cost_usd: float
    websocket_url: str

# LLM Gateway URL (should match your deployed gateway)
LLM_GATEWAY_URL = "https://ilaunching-llm-server-production.up.railway.app"

@router.post("/chat")
async def send_chat_message(
    request: ChatRequest,
    background_tasks: BackgroundTasks,
    session_id: str = Depends(get_current_session)
):
    """
    Send chat message to AI and get response.
    
    This endpoint handles chat messages from the Bubble editor and
    coordinates with the LLM Gateway for AI responses.
    """
    
    # Generate conversation ID if not provided
    conversation_id = request.conversation_id or str(uuid.uuid4())
    
    logger.info(
        "Chat message received",
        session_id=session_id,
        conversation_id=conversation_id,
        model=request.model,
        message_length=len(request.message)
    )
    
    try:
        # For now, return mock data while testing
        # TODO: Replace with actual LLM Gateway call
        mock_response = generate_mock_chat_response(request.message, request.model)
        
        # If streaming is enabled, send via WebSocket
        if request.stream:
            # Add background task to stream response
            background_tasks.add_task(
                stream_chat_response, 
                session_id, 
                conversation_id, 
                mock_response
            )
            
            return ChatResponse(
                response="Streaming response initiated...",
                model_used=request.model,
                conversation_id=conversation_id,
                timestamp=datetime.utcnow().isoformat(),
                cost_usd=0.001,  # Mock cost
                websocket_url=f"/ws/{session_id}"
            )
        else:
            # Return direct response
            return ChatResponse(
                response=mock_response,
                model_used=request.model,
                conversation_id=conversation_id,
                timestamp=datetime.utcnow().isoformat(),
                cost_usd=0.001,  # Mock cost
                websocket_url=f"/ws/{session_id}"
            )
            
    except Exception as e:
        logger.error("Chat failed", error=str(e), session_id=session_id)
        raise HTTPException(status_code=500, detail=f"Chat failed: {str(e)}")

async def stream_chat_response(session_id: str, conversation_id: str, response_text: str):
    """
    Stream chat response via WebSocket in chunks
    """
    try:
        # Import here to avoid circular imports
        from main import send_to_websocket
        
        # Split response into chunks for streaming effect
        chunks = response_text.split('. ')
        total_chunks = len(chunks)
        
        for i, chunk in enumerate(chunks):
            # Add period back except for last chunk
            if i < len(chunks) - 1:
                chunk += ". "
            
            # Send chunk via WebSocket
            await send_to_websocket(session_id, {
                "type": "chat_chunk",
                "conversation_id": conversation_id,
                "chunk": chunk,
                "chunk_number": i + 1,
                "total_chunks": total_chunks,
                "complete": i == len(chunks) - 1,
                "timestamp": datetime.utcnow().isoformat()
            })
            
            # Small delay for streaming effect
            await asyncio.sleep(0.5)
            
        logger.info("Chat streaming completed", session_id=session_id, conversation_id=conversation_id)
        
    except Exception as e:
        logger.error("Chat streaming failed", error=str(e), session_id=session_id)

def generate_mock_chat_response(message: str, model: str) -> str:
    """
    Generate mock AI response for testing
    TODO: Replace with actual LLM Gateway integration
    """
    
    # Determine response based on message content
    message_lower = message.lower()
    
    if any(word in message_lower for word in ['hello', 'hi', 'hey']):
        return f"Hello! I'm an AI assistant powered by {model}. I'm here to help with business analysis, strategy questions, and general inquiries. What would you like to know?"
    
    elif any(word in message_lower for word in ['business', 'strategy', 'analysis']):
        return f"Great question about business strategy! Based on my analysis using {model}, I'd recommend focusing on three key areas: market positioning, competitive differentiation, and customer acquisition. Would you like me to dive deeper into any of these areas?"
    
    elif any(word in message_lower for word in ['help', 'what can you do']):
        return f"I can help you with:\n\n🔍 **Business Analysis** - Market research, competitor analysis, industry insights\n📊 **Strategic Planning** - Growth strategies, market entry, business models\n💡 **Problem Solving** - Creative solutions, process optimization\n📈 **Data Insights** - Trend analysis, performance metrics\n\nWhat specific area interests you most?"
    
    elif any(word in message_lower for word in ['code', 'programming', 'developer']):
        return f"I can definitely help with coding and development questions! Using {model}, I can assist with:\n\n• Code review and optimization\n• Architecture recommendations\n• Debugging assistance\n• Best practices\n• Technology selection\n\nWhat programming challenge are you working on?"
    
    elif any(word in message_lower for word in ['price', 'cost', 'pricing']):
        return f"For pricing strategy analysis using {model}, I consider factors like:\n\n💰 Market positioning\n📊 Competitive benchmarking\n🎯 Value proposition\n📈 Demand elasticity\n💡 Psychological pricing\n\nCurrent model cost: ~$0.001 per response. What pricing challenge are you facing?"
    
    else:
        return f"That's an interesting question! Using {model} to analyze your query, I can provide insights on various aspects. Could you give me a bit more context about what you're looking for? I'm here to help with business strategy, analysis, problem-solving, and more."

async def call_llm_gateway(message: str, model: str) -> str:
    """
    Call the actual LLM Gateway for real AI responses
    TODO: Implement this to replace mock responses
    """
    try:
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{LLM_GATEWAY_URL}/generate",
                json={
                    "messages": [{"role": "user", "content": message}],
                    "model": model,
                    "max_tokens": 500
                },
                timeout=30.0
            )
            
            if response.status_code == 200:
                result = response.json()
                return result.get("content", "No response from AI")
            else:
                logger.error("LLM Gateway error", status=response.status_code, response=response.text)
                return "Sorry, I'm having trouble connecting to the AI service right now."
                
    except Exception as e:
        logger.error("LLM Gateway call failed", error=str(e))
        return "I'm currently experiencing technical difficulties. Please try again in a moment."
