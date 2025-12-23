"""
SQLAlchemy AccountDeletion Model
Defines the database model for tracking account deletion requests.
"""

from datetime import datetime, timedelta
from sqlalchemy import Column, String, DateTime, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
import uuid

from config.database import Base


class AccountDeletion(Base):
    """Account deletion queue model"""
    __tablename__ = "account_deletions"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False, index=True)
    request_date = Column(DateTime(timezone=True), nullable=False, default=datetime.utcnow)
    execution_date = Column(DateTime(timezone=True), nullable=False)
    status = Column(String(50), nullable=False, default="pending")  # pending, completed, cancelled
    
    # Relationship
    user = relationship("User", foreign_keys=[user_id])
    
    def __repr__(self):
        return f"<AccountDeletion(id={self.id}, user_id={self.user_id}, status={self.status})>"
    
    def to_dict(self):
        """Convert account deletion to dictionary"""
        return {
            "id": str(self.id),
            "user_id": str(self.user_id),
            "request_date": self.request_date.isoformat() if self.request_date else None,
            "execution_date": self.execution_date.isoformat() if self.execution_date else None,
            "status": self.status,
        }
    
    @staticmethod
    def calculate_execution_date(request_date: datetime = None) -> datetime:
        """Calculate execution date (30 days from request)"""
        if request_date is None:
            request_date = datetime.utcnow()
        return request_date + timedelta(days=30)
