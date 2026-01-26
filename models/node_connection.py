"""
Node Connection Model (Tier C)
Connections (links) between node ports with Bezier curve rendering support
"""

from sqlalchemy import Column, String, Integer, Boolean, ForeignKey, UniqueConstraint
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.orm import relationship
from datetime import datetime
import uuid

from config.database import Base

class NodeConnection(Base):
    """
    Node Connection - Links between node ports
    
    Features:
    - Bezier curve metadata (calculated client-side)
    - Pulse animation support
    - Connection status tracking
    - Cascade delete when nodes are removed
    """
    __tablename__ = 'tbl_node_connections'
    
    # ============================================================================
    # IDENTITY
    # ============================================================================
    connection_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    
    # ============================================================================
    # SOURCE (Output Port)
    # ============================================================================
    source_node_id = Column(
        UUID(as_uuid=True),
        ForeignKey('tbl_canvas_nodes.node_id', ondelete='CASCADE'),
        nullable=False,
        index=True
    )
    source_port_id = Column(String(50), nullable=False)
    
    # ============================================================================
    # TARGET (Input Port)
    # ============================================================================
    target_node_id = Column(
        UUID(as_uuid=True),
        ForeignKey('tbl_canvas_nodes.node_id', ondelete='CASCADE'),
        nullable=False,
        index=True
    )
    target_port_id = Column(String(50), nullable=False)
    
    # ============================================================================
    # VISUAL & ANIMATION
    # ============================================================================
    color = Column(String(20), default='#3b82f6')
    animated = Column(Boolean, default=True)
    pulse_speed = Column(Integer, default=200)  # ms per pulse cycle
    
    # ============================================================================
    # CONNECTION STATE
    # status: 'idle', 'active', 'error'
    # ============================================================================
    status = Column(String(20), default='idle')
    
    # ============================================================================
    # BEZIER CURVE METADATA (Optional - for analytics/debugging)
    # Calculated client-side, stored for analytics
    # ============================================================================
    curve_metadata = Column(
        JSONB,
        default={
            'control_offset': None,
            'path_length': None,
            'last_calculated': None
        },
        nullable=False
    )
    
    # ============================================================================
    # TRACEABILITY
    # ============================================================================
    created_at = Column(Text, default=lambda: datetime.utcnow().isoformat())
    updated_at = Column(Text, default=lambda: datetime.utcnow().isoformat(), onupdate=lambda: datetime.utcnow().isoformat())
    
    # ============================================================================
    # CONSTRAINTS
    # Ensure unique connections (no duplicate links)
    # ============================================================================
    __table_args__ = (
        UniqueConstraint(
            'source_node_id', 'source_port_id', 
            'target_node_id', 'target_port_id',
            name='uq_connection'
        ),
    )
    
    # ============================================================================
    # RELATIONSHIPS
    # ============================================================================
    source_node = relationship(
        "CanvasNode",
        foreign_keys=[source_node_id],
        back_populates="outgoing_connections"
    )
    
    target_node = relationship(
        "CanvasNode",
        foreign_keys=[target_node_id],
        back_populates="incoming_connections"
    )
    
    def __repr__(self):
        return f"<NodeConnection(id={self.connection_id}, {self.source_port_id} → {self.target_port_id})>"
