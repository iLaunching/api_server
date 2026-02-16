from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from config.database import get_db
from models.chat_history import ChatHistory
from auth.middleware import get_current_session
import structlog

logger = structlog.get_logger()

router = APIRouter(tags=["chat"])

@router.get("/chat/node/{node_id}")
async def get_chat_history_by_node(
    node_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: dict = Depends(get_current_session)
):
    """
    Get chat history for a specific node (Sovereign Speed optimization).
    Uses a covering query to fetch only necessary fields.
    """
    try:
        # Optimized query selecting only needed fields
        # This allows avoiding full row retrieval if we only need the JSON
        query = select(
            ChatHistory.document_json,
            ChatHistory.last_updated,
            ChatHistory.chat_id
        ).where(ChatHistory.node_id == node_id)
        
        result = await db.execute(query)
        row = result.first()
        
        if not row:
            # Return empty structure if no chat exists, rather than 404
            # This allows the frontend to initialize a new chat easily
            return {
                "document_json": None,
                "last_updated": None,
                "chat_id": None
            }
            
        return {
            "document_json": row.document_json,
            "last_updated": row.last_updated,
            "chat_id": row.chat_id
        }
        
    except Exception as e:
        logger.error("Failed to fetch chat history", node_id=node_id, error=str(e))
        raise HTTPException(status_code=500, detail="Internal server error")
