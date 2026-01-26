"""
Node Template Model (Tier C)
Node library templates defining available node types per context
"""

from sqlalchemy import Column, String, Float, Boolean, Text
from sqlalchemy.dialects.postgresql import UUID, JSONB, ARRAY
from datetime import datetime
import uuid

from config.database import Base

class NodeTemplate(Base):
    """
    Node Template - Node library definitions
    
    Features:
    - Context-specific node availability
    - Visual defaults (shape, color, size)
    - Port configuration templates
    - Category grouping for UI
    """
    __tablename__ = 'tbl_node_templates'
    
    # ============================================================================
    # IDENTITY
    # ============================================================================
    template_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    template_name = Column(String(255), nullable=False)
    node_type = Column(String(50), nullable=False, unique=True)
    
    # ============================================================================
    # CONTEXT COMPATIBILITY
    # Example: ['CAMPAIGN', 'WORKFLOW']
    # ============================================================================
    allowed_context_types = Column(ARRAY(String(50)), default=[], nullable=False)
    
    # ============================================================================
    # VISUAL DEFAULTS
    # ============================================================================
    default_width = Column(Float, default=200)
    default_height = Column(Float, default=150)
    default_color = Column(String(20), default='#3b82f6')
    shape_type = Column(String(50), default='rectangle')  # 'circle', 'rectangle', 'hexagon'
    icon = Column(String(10))  # Emoji or icon identifier
    
    # ============================================================================
    # PORT CONFIGURATION TEMPLATE
    # Example: {"inputs": [{"id": "input-1", "dataType": "any", "label": "Input"}],
    #           "outputs": [{"id": "output", "dataType": "any", "label": "Output"}]}
    # ============================================================================
    port_template = Column(
        JSONB,
        default={'inputs': [], 'outputs': []},
        nullable=False
    )
    
    # ============================================================================
    # CUSTOM RENDERER (optional)
    # Example: 'SmartMatrixNodeRenderer', 'EmailNodeRenderer'
    # ============================================================================
    renderer_class = Column(String(100))
    
    # ============================================================================
    # METADATA
    # ============================================================================
    description = Column(Text)
    category = Column(String(50), index=True)  # 'communication', 'logic', 'data', 'ai'
    is_active = Column(Boolean, default=True, index=True)
    created_at = Column(Text, default=lambda: datetime.utcnow().isoformat())
    
    def __repr__(self):
        return f"<NodeTemplate(type={self.node_type}, name={self.template_name}, category={self.category})>"
