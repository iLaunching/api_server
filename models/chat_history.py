"""
SQLAlchemy model for Chat History (Tier C)
Stores the conversation state and document structure for context-aware chats.
"""

import uuid
from datetime import datetime
from sqlalchemy import Column, String, Boolean, ForeignKey, DateTime, func, Index
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.orm import relationship

from config.database import Base

class ChatHistory(Base):
    """
    Chat History Model
    
    Stores the Tiptap JSON document and metadata for a specific chat context.
    Linked 1:1 with Context and Node (The 1:1:1 Triangle).
    """
    __tablename__ = "tbl_chat_history"
    
    # Primary Key
    chat_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    
    # The 1:1:1 Triangle
    context_id = Column(
        UUID(as_uuid=True), 
        ForeignKey("tbl_contexts.context_id", ondelete="CASCADE"),
        unique=True,
        nullable=False,
        index=True
    )
    
    node_id = Column(
        UUID(as_uuid=True), 
        ForeignKey("tbl_canvas_nodes.node_id", ondelete="CASCADE"),
        unique=True,
        nullable=True,
        index=True
    )
    
    # Flags
    is_master_chat = Column(Boolean, default=False, nullable=False)
    
    # The Document (TipTap JSON)
    document_json = Column(JSONB, default={"type": "doc", "content": []}, nullable=False)
    
    # Metadata
    last_updated = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    
    # Relationships
    context = relationship("Context", backref="chat_history")
    node = relationship("CanvasNode", backref="chat_history")

    def __repr__(self):
        return f"<ChatHistory(id={self.chat_id}, context={self.context_id})>"
