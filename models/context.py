"""
SQLAlchemy model for Context (Tier B - Context Layer)
Containers that inherit DNA from Manifest and represent logical groupings.
"""

import uuid
from datetime import datetime
from typing import Optional, Dict, Any
from sqlalchemy import Column, String, Boolean, ForeignKey, DateTime, Text, func
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.orm import relationship
from geoalchemy2 import Geometry

from config.database import Base

class Context(Base):
    """
    Tier B: Context Layer
    
    Logical containers that organize nodes and inherit "intent" from the Manifest.
    Examples: Campaigns, Projects, Workflows, Goals.
    
    Attributes:
        context_id: UUID Primary Key
        manifest_id: Foreign Key to tbl_manifest
        context_name: Display name (e.g. "Marketing Q1")
        context_type: Type of context (CAMPAIGN, GENESIS, etc.)
        boundary_polygon: Spatial boundary on the canvas (SRID 0)
        inherited_intent: Intent string auto-populated from Manifest via DB trigger
        local_variables: Context-specific configuration
    """
    __tablename__ = "tbl_contexts"
    
    # Primary key
    context_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    
    # Relationships
    smart_matrix_id = Column(
        UUID(as_uuid=True), 
        ForeignKey("smart_matrices.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )
    
    # Basic Metadata
    context_name = Column(String(255), nullable=False)
    context_type = Column(String(50), nullable=False, index=True) 
    
    # Spatial Data (SRID 0 = Cartesian 2D Plane)
    boundary_polygon = Column(Geometry('POLYGON', srid=0))
    # boundary_polygon = Column(Text, nullable=True) # Fallback from GEOMETRY due to missing PostGIS in dev
    
    # DNA Handshake
    inherited_intent = Column(Text, nullable=True) # Populated by DB trigger
    
    # Configuration
    local_variables = Column(JSONB, default={}, nullable=True)
    is_active = Column(Boolean, default=True)

    # Master Context Fields (The Soul & DNA)
    is_master_context = Column(Boolean, default=False)
    master_dna_payload = Column(JSONB, default={})
    sync_heartbeat = Column(DateTime(timezone=True), server_default=func.now())
    
    # Timestamps
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    
    # SQLAlchemy Relationships
    smart_matrix = relationship("SmartMatrix", foreign_keys="[Context.smart_matrix_id]", backref="contexts")
    
    # Phase 3: Canvas Nodes relationship
    canvas_nodes = relationship("CanvasNode", back_populates="context", cascade="all, delete-orphan")


    def __repr__(self):
        return f"<Context(id={self.context_id}, name='{self.context_name}', type='{self.context_type}')>"
