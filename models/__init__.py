"""
Models package - imports all models to ensure they're registered with SQLAlchemy
"""

# Import all models to ensure they're registered with SQLAlchemy Base.metadata
# This is crucial for foreign key relationships to work correctly
from models.user import UserProfile, ThemeConfig
from models.database_models import (
    SmartHub,
    SmartMatrix,
    AnalysisJob,
    AnalysisResult,
    DataCache,
    LLMUsage,
    WorkerHealth,
    OptionSet,
    OptionValue,
)
from models.user_navigation import UserNavigation

# Configure relationships AFTER all models are imported
from sqlalchemy.orm import relationship

# Add navigation relationship to UserProfile
UserProfile.navigation = relationship(
    "UserNavigation", 
    back_populates="user_profile", 
    uselist=False, 
    foreign_keys=lambda: [UserNavigation.user_profile_id]
)

# Update UserNavigation relationship to include back_populates
UserNavigation.user_profile = relationship(
    "UserProfile", 
    back_populates="navigation", 
    foreign_keys=lambda: [UserNavigation.user_profile_id]
)

__all__ = [
    'UserProfile',
    'ThemeConfig',
    'SmartHub',
    'SmartMatrix',
    'AnalysisJob',
    'AnalysisResult',
    'DataCache',
    'LLMUsage',
    'WorkerHealth',
    'OptionSet',
    'OptionValue',
    'UserNavigation',
]