"""
Models package - imports all models to ensure they're registered with SQLAlchemy
"""

# Import all models to ensure they're registered with SQLAlchemy Base.metadata
# This is crucial for foreign key relationships to work correctly
from models.user import UserProfile, DnaProfile
from models.database_models import (
    SmartHub,
    SmartMatrix,
    UserNavigation,
    AnalysisJob,
    AnalysisResult,
    DataCache,
    LLMUsage,
    WorkerHealth,
    OptionSet,
    OptionValue,
)
from models.context import Context
from models.canvas_node import CanvasNode
from models.matrix_protocol import MatrixProtocol
from models.chat_history import ChatHistory

__all__ = [
    'UserProfile',
    'DnaProfile',
    'ThemeConfig',
    'SmartHub',
    'SmartMatrix',
    'UserNavigation',
    'AnalysisJob',
    'AnalysisResult',
    'DataCache',
    'LLMUsage',
    'WorkerHealth',
    'OptionSet',
    'OptionValue',
    'Context',
    'CanvasNode',
    'MatrixProtocol',
    'ChatHistory',
]