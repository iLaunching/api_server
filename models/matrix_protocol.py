"""
Matrix Protocol Model
Defines the "Start of Life" protocols for different matrix phases
"""

from sqlalchemy import Column, String, Boolean, Text, DateTime
from sqlalchemy.dialects.postgresql import UUID, JSONB
from datetime import datetime
import uuid

from config.database import Base


class MatrixProtocol(Base):
    """
    Matrix Protocol - Defines phase-specific instructions and frameworks
    
    Features:
    - Protocol key (GENESIS, CAMPAIGN, VALIDATION)
    - Initial AI instructions for the phase
    - Context framework blueprint
    - Success criteria and OKRs
    """
    __tablename__ = 'tbl_matrix_protocols'
    
    # ============================================================================
    # IDENTITY
    # ============================================================================
    protocol_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    protocol_key = Column(String(50), nullable=False, unique=True, index=True)
    
    # ============================================================================
    # PROTOCOL CONTENT
    # ============================================================================
    initial_instructions = Column(Text)  # The "Start of Life" prompt for the AI
    context_framework = Column(JSONB, default={})  # Blueprint for Master Context
    success_criteria = Column(JSONB, default={})  # Initial OKRs
    
    # ============================================================================
    # METADATA
    # ============================================================================
    is_active = Column(Boolean, default=True, index=True)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # ============================================================================
    # UI STYLING
    # ============================================================================
    background_color = Column(String)
    border_color = Column(String)
    display_name = Column(String(100))
    display_description = Column(Text)
    short_description = Column(Text)
    
    def __repr__(self):
        return f"<MatrixProtocol(key={self.protocol_key}, active={self.is_active})>"
