"""
Streaming Content Routes - Tiptap Editor Streaming

Handles intelligent content streaming for the Tiptap editor:
- Receives content (text/HTML/markdown)
- Processes and chunks intelligently
- Streams chunks via WebSocket with optimal timing
- Transforms HTML/markdown for Tiptap compatibility

This mimics Tiptap's premium streamContent extension behavior.
"""

from fastapi import APIRouter, WebSocket, WebSocketDisconnect, HTTPException
from pydantic import BaseModel, Field
from typing import Optional, Literal
import asyncio
import structlog
from datetime import datetime

logger = structlog.get_logger()

router = APIRouter(prefix="/streaming", tags=["streaming"])


class StreamRequest(BaseModel):
    """Request to stream content"""
    content: str = Field(..., description="Content to stream (text, HTML, or markdown)")
    content_type: Literal["text", "html", "markdown"] = Field(default="text", description="Type of content")
    speed: Literal["slow", "normal", "fast", "superfast", "adaptive"] = Field(default="normal", description="Streaming speed preset")
    chunk_by: Literal["character", "word", "sentence"] = Field(default="word", description="How to chunk content")


@router.websocket("/ws/{session_id}")
async def stream_content_websocket(websocket: WebSocket, session_id: str):
    """
    WebSocket endpoint for streaming content to Tiptap editor.
    
    Flow:
    1. Client connects and sends StreamRequest
    2. Server processes content (sanitize, chunk, transform)
    3. Server streams chunks at optimal rate
    4. Client receives chunks and displays in editor
    """
    await websocket.accept()
    logger.info("Streaming WebSocket connected", session_id=session_id)
    
    try:
        # Send connection confirmation
        await websocket.send_json({
            "type": "connected",
            "session_id": session_id,
            "timestamp": datetime.utcnow().isoformat()
        })
        
        # Wait for streaming request
        while True:
            data = await websocket.receive_json()
            
            if data.get("type") == "stream_request":
                # Extract request data
                content = data.get("content", "")
                content_type = data.get("content_type", "text")
                speed = data.get("speed", "normal")
                chunk_by = data.get("chunk_by", "word")
                
                logger.info(
                    "Stream request received",
                    session_id=session_id,
                    content_length=len(content),
                    content_type=content_type,
                    speed=speed,
                    chunk_by=chunk_by
                )
                
                # Process and stream content
                await process_and_stream(
                    websocket=websocket,
                    content=content,
                    content_type=content_type,
                    speed=speed,
                    chunk_by=chunk_by
                )
                
            elif data.get("type") == "ping":
                await websocket.send_json({
                    "type": "pong",
                    "timestamp": datetime.utcnow().isoformat()
                })
                
    except WebSocketDisconnect:
        logger.info("Streaming WebSocket disconnected", session_id=session_id)
    except Exception as e:
        logger.error("Streaming WebSocket error", session_id=session_id, error=str(e))
        try:
            await websocket.send_json({
                "type": "error",
                "message": str(e)
            })
        except:
            pass


async def process_and_stream(
    websocket: WebSocket,
    content: str,
    content_type: str,
    speed: str,
    chunk_by: str
):
    """
    Process content and stream chunks to client.
    
    This is where the magic happens:
    1. Sanitize HTML (if applicable)
    2. Transform markdown to HTML (if applicable)
    3. Chunk content intelligently
    4. Stream at optimal rate
    """
    try:
        # TODO: Phase 2.2 - Add content processing
        # For now, simple implementation
        
        # Determine delay based on speed preset
        speed_delays = {
            "slow": 0.3,
            "normal": 0.1,
            "fast": 0.05,
            "superfast": 0.03,
            "adaptive": 0.1  # Will calculate based on content
        }
        delay = speed_delays.get(speed, 0.1)
        
        # Simple chunking for now (will enhance in Phase 2.2)
        if chunk_by == "word":
            chunks = content.split()
            chunks = [chunk + " " for chunk in chunks]  # Add space back
        elif chunk_by == "character":
            chunks = list(content)
        elif chunk_by == "sentence":
            # Simple sentence splitting (will enhance later)
            chunks = content.replace(". ", ".|").split("|")
            chunks = [chunk.strip() + " " if not chunk.endswith(".") else chunk + " " for chunk in chunks]
        else:
            chunks = [content]
        
        # Send stream start event
        await websocket.send_json({
            "type": "stream_start",
            "total_chunks": len(chunks),
            "content_type": content_type,
            "timestamp": datetime.utcnow().isoformat()
        })
        
        # Stream chunks
        for i, chunk in enumerate(chunks):
            await websocket.send_json({
                "type": "chunk",
                "data": chunk,
                "index": i,
                "total": len(chunks),
                "timestamp": datetime.utcnow().isoformat()
            })
            
            # Delay between chunks
            await asyncio.sleep(delay)
        
        # Send stream complete event
        await websocket.send_json({
            "type": "stream_complete",
            "total_chunks": len(chunks),
            "timestamp": datetime.utcnow().isoformat()
        })
        
        logger.info("Stream completed", total_chunks=len(chunks))
        
    except Exception as e:
        logger.error("Stream processing error", error=str(e))
        await websocket.send_json({
            "type": "error",
            "message": f"Streaming error: {str(e)}"
        })
