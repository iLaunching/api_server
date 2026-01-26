"""
Canvas Node Model (Tier C)
Individual nodes on the spatial canvas with dynamic port rotation support
"""

from sqlalchemy import Column, String, Float, Integer, Boolean, Text, ForeignKey
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.orm import relationship
from datetime import datetime
import uuid

from config.database import Base

class CanvasNode(Base):
    """
    Canvas Node - Individual nodes on the spatial canvas
    
    Features:
    - Dynamic port rotation (SmartMatrixNode compatible)
    - Master Bridge capability for DNA synthesis
    - Visual state management
    - Execution tracking
    """
    __tablename__ = 'tbl_canvas_nodes'
    
    # ============================================================================
    # BASE IDENTITY & NAMING
    # ============================================================================
    node_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    context_id = Column(
        UUID(as_uuid=True), 
        ForeignKey('tbl_contexts.context_id', ondelete='CASCADE'), 
        nullable=False,
        index=True
    )
    node_name = Column(String(255), nullable=False)
    node_description = Column(Text)
    node_type = Column(String(50), nullable=False, index=True)
    
    # ============================================================================
    # SPATIAL DATA (World Coordinates)
    # ============================================================================
    pos_x = Column(Float, nullable=False, index=True)
    pos_y = Column(Float, nullable=False, index=True)
    width = Column(Float, default=200)
    height = Column(Float, default=150)
    
    # ============================================================================
    # VISUAL PROPERTIES
    # ============================================================================
    color = Column(String(20), default='#3b82f6')
    background_color = Column(String(20))
    text_color = Column(String(20))
    
    # ============================================================================
    # PORT CONFIGURATION
    # Stores port definitions with metadata
    # Example: {"inputs": [{"id": "input-1", "dataType": "any", "label": "Input"}], 
    #           "outputs": [{"id": "output", "dataType": "any", "label": "Output"}]}
    # ============================================================================
    port_config = Column(
        JSONB, 
        default={'inputs': [], 'outputs': []},
        nullable=False
    )
    
    # ============================================================================
    # THE "SOVEREIGN" TOGGLE (Master Bridge)
    # ============================================================================
    is_master_bridge = Column(Boolean, default=False, index=True)
    
    # ============================================================================
    # MULTI-SOURCE INPUT (The Semantic Vacuum)
    # Tracks IDs of nodes/contexts feeding into this node
    # ============================================================================
    bridge_inputs = Column(
        JSONB,
        default={
            'source_node_ids': [], 
            'source_context_ids': [],
            'last_synthesis_at': None
        },
        nullable=False
    )
    
    # ============================================================================
    # DYNAMIC CAPABILITIES (Logic Forge Output)
    # ============================================================================
    node_dna_overrides = Column(JSONB, default={}, nullable=False)
    
    # ============================================================================
    # OPERATIONAL & VISUAL STATES
    # operational_status: 'IDLE', 'SENSING', 'SYNTHESIZING', 'STABLE', 'CONFLICT'
    # visual_state: 'IDLE', 'RUNNING', 'SUCCESS', 'ERROR'
    # ============================================================================
    operational_status = Column(String(20), default='IDLE')
    visual_state = Column(String(20), default='IDLE')
    is_selected = Column(Boolean, default=False)
    is_hovered = Column(Boolean, default=False)
    
    # ============================================================================
    # EXECUTION METADATA
    # ============================================================================
    execution_count = Column(Integer, default=0)
    last_execution_time = Column(Text)  # ISO 8601 timestamp string
    error_message = Column(Text)
    
    # ============================================================================
    # CUSTOM METADATA (for node-specific config)
    # ============================================================================
    metadata = Column(JSONB, default={}, nullable=False)
    
    # ============================================================================
    # TRACEABILITY
    # ============================================================================
    reference_data_id = Column(UUID(as_uuid=True))
    created_at = Column(Text, default=lambda: datetime.utcnow().isoformat())
    updated_at = Column(Text, default=lambda: datetime.utcnow().isoformat(), onupdate=lambda: datetime.utcnow().isoformat())
    
    # ============================================================================
    # RELATIONSHIPS
    # ============================================================================
    context = relationship("Context", back_populates="canvas_nodes")
    
    outgoing_connections = relationship(
        "NodeConnection",
        foreign_keys="NodeConnection.source_node_id",
        back_populates="source_node",
        cascade="all, delete-orphan"
    )
    
    incoming_connections = relationship(
        "NodeConnection",
        foreign_keys="NodeConnection.target_node_id",
        back_populates="target_node",
        cascade="all, delete-orphan"
    )
    
    def __repr__(self):
        return f"<CanvasNode(id={self.node_id}, type={self.node_type}, name={self.node_name})>"
