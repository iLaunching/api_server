"""
Protocol Category Model
Lookup table for grouping and filtering protocols in the UI
"""

from sqlalchemy import Column, String, Boolean, Integer, Text, DateTime
from datetime import datetime

from config.database import Base


class ProtocolCategory(Base):
    """
    Protocol Category - Used to group and filter protocols in the UI

    Features:
    - name / description for display
    - color for UI chip/badge rendering
    - icon_name / icon_prefix for FontAwesome icons
    - sort_order for display ordering
    """
    __tablename__ = 'tbl_protocol_categories'

    # Identity
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(Text, nullable=False, unique=True)
    description = Column(Text)

    # UI styling
    color = Column(String)        # hex color e.g. '#7F77F1'
    icon_name = Column(String)    # FontAwesome icon name e.g. 'fa-robot'
    icon_prefix = Column(String, default='fas')

    # Ordering & status
    sort_order = Column(Integer, default=0)
    is_active = Column(Boolean, default=True)

    # Timestamps
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow)

    def __repr__(self):
        return f"<ProtocolCategory(name={self.name})>"
