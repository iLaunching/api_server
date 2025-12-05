"""
Models package - imports all models to ensure they're registered with SQLAlchemy
"""

# Import all models to ensure they're registered with SQLAlchemy Base.metadata
# This is crucial for foreign key relationships to work correctly
from models.user import UserProfile, ThemeConfig
from models.user_navigation import UserNavigation
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
from models.user_navigation import UserNavigation  # Import after UserProfile

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