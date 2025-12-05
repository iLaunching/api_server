"""
Models package - imports all models to ensure they're registered with SQLAlchemy
"""

# Import all models to ensure they're registered with SQLAlchemy Base.metadata
# This is crucial for foreign key relationships to work correctly
from models.user import UserProfile
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
    ThemeConfig,
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
]