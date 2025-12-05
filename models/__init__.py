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

# No dynamic relationship configuration needed
# UserNavigation has one-way relationship to UserProfile
# Access navigation by querying: UserNavigation.get_by_user_profile_id()

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