"""
Node Definition Model
Represents the Node Definition Library - DNA catalog for spawnable nodes
"""

from pydantic import BaseModel, Field
from typing import Optional, Dict, Any, List
from datetime import datetime
from uuid import UUID


class NodeDefinitionBase(BaseModel):
    """Base schema for node definitions"""
    category: str = Field(..., description="Business phase: GENESIS, CAMPAIGN, or VALIDATION")
    display_name: str = Field(..., max_length=100, description="Human-readable name for the node")
    description: Optional[str] = Field(None, description="Detailed purpose for user and AI")
    icon_name: Optional[str] = Field(None, max_length=50, description="Lucide/FontAwesome icon key")
    node_type: Optional[str] = Field(None, max_length=50, description="Type: action, trigger, logic, validation")
    default_config: Dict[str, Any] = Field(
        default_factory=lambda: {
            "base_prompt": "",
            "required_inputs": [],
            "loop_logic": "fixed"
        },
        description="Base DNA configuration copied to node_dna_overrides"
    )
    is_active: bool = Field(default=True, description="Whether this definition is available")


class NodeDefinitionCreate(NodeDefinitionBase):
    """Schema for creating a new node definition"""
    pass


class NodeDefinitionUpdate(BaseModel):
    """Schema for updating an existing node definition"""
    category: Optional[str] = None
    display_name: Optional[str] = None
    description: Optional[str] = None
    icon_name: Optional[str] = None
    node_type: Optional[str] = None
    default_config: Optional[Dict[str, Any]] = None
    is_active: Optional[bool] = None


class NodeDefinition(NodeDefinitionBase):
    """Complete node definition with database fields"""
    def_id: UUID = Field(..., description="Unique identifier for this definition")
    created_at: datetime = Field(..., description="When this definition was created")
    
    class Config:
        from_attributes = True


class NodeDefinitionList(BaseModel):
    """Response schema for listing node definitions"""
    definitions: List[NodeDefinition]
    total: int
    category_filter: Optional[str] = None


class CreateNodeFromDefinition(BaseModel):
    """Schema for creating a canvas node from a definition"""
    def_id: UUID = Field(..., description="ID of the node definition to use")
    context_id: UUID = Field(..., description="Canvas context to create the node in")
    position: Dict[str, float] = Field(
        default_factory=lambda: {"x": 400, "y": 300},
        description="Position on canvas"
    )
    custom_overrides: Optional[Dict[str, Any]] = Field(
        default=None,
        description="Optional additional config to merge with default_config"
    )
