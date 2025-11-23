"""
SQLAlchemy User Models
Defines database models for users, sessions, and authentication.
"""

from datetime import datetime
from typing import Optional
from sqlalchemy import Column, String, Boolean, DateTime, ForeignKey, Text, Integer
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
import uuid

Base = declarative_base()

class User(Base):
    """User account model"""
    __tablename__ = "users"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String(255), unique=True, nullable=False, index=True)
    password_hash = Column(String(255), nullable=False)
    name = Column(String(255))
    role = Column(String(50), default="user")
    subscription_tier = Column(String(50), default="free")
    email_verified = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow)
    last_login = Column(DateTime(timezone=True))
    
    # Relationships
    sessions = relationship("Session", back_populates="user", cascade="all, delete-orphan")
    profile = relationship("UserProfile", back_populates="user", uselist=False, cascade="all, delete-orphan")
    
    def __repr__(self):
        return f"<User(id={self.id}, email={self.email}, role={self.role})>"
    
    def to_dict(self, include_sensitive=False):
        """Convert user to dictionary (exclude password by default)"""
        data = {
            "id": str(self.id),
            "email": self.email,
            "name": self.name,
            "role": self.role,
            "subscription_tier": self.subscription_tier,
            "email_verified": self.email_verified,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "last_login": self.last_login.isoformat() if self.last_login else None,
        }
        
        if include_sensitive:
            data["password_hash"] = self.password_hash
        
        return data


class Session(Base):
    """User session model for refresh tokens"""
    __tablename__ = "sessions"
    
    session_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    refresh_token_hash = Column(String(255), nullable=False)
    device_info = Column(JSONB, default={})
    ip_address = Column(String(45))
    user_agent = Column(Text)
    expires_at = Column(DateTime(timezone=True), nullable=False, index=True)
    revoked = Column(Boolean, default=False, index=True)
    revoked_at = Column(DateTime(timezone=True))
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    last_accessed = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    # Relationships
    user = relationship("User", back_populates="sessions")
    
    def __repr__(self):
        return f"<Session(session_id={self.session_id}, user_id={self.user_id}, revoked={self.revoked})>"
    
    def to_dict(self):
        """Convert session to dictionary"""
        return {
            "session_id": str(self.session_id),
            "user_id": str(self.user_id),
            "device_info": self.device_info,
            "ip_address": self.ip_address,
            "expires_at": self.expires_at.isoformat() if self.expires_at else None,
            "revoked": self.revoked,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "last_accessed": self.last_accessed.isoformat() if self.last_accessed else None,
        }


class UserProfile(Base):
    """Extended user profile information"""
    __tablename__ = "user_profiles"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, unique=True)
    phone = Column(String(20))
    avatar_url = Column(Text)
    bio = Column(Text)
    timezone = Column(String(50), default="UTC")
    language = Column(String(10), default="en")
    preferences = Column(JSONB, default={})
    selected_theme = Column(String(50), default="sun")  # User's selected appearance theme
    onboarding_completed = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = relationship("User", back_populates="profile")
    
    def __repr__(self):
        return f"<UserProfile(id={self.id}, user_id={self.user_id})>"
    
    def to_dict(self):
        """Convert profile to dictionary"""
        return {
            "id": str(self.id),
            "user_id": str(self.user_id),
            "phone": self.phone,
            "avatar_url": self.avatar_url,
            "bio": self.bio,
            "timezone": self.timezone,
            "language": self.language,
            "preferences": self.preferences,
            "selected_theme": self.selected_theme,
            "onboarding_completed": self.onboarding_completed,
        }


class LoginAttempt(Base):
    """Login attempt tracking for security"""
    __tablename__ = "login_attempts"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String(255), nullable=False, index=True)
    ip_address = Column(String(45), nullable=False, index=True)
    success = Column(Boolean, nullable=False)
    failure_reason = Column(String(100))
    user_agent = Column(Text)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow, index=True)
    
    def __repr__(self):
        return f"<LoginAttempt(email={self.email}, success={self.success}, ip={self.ip_address})>"
    
    def to_dict(self):
        """Convert login attempt to dictionary"""
        return {
            "id": str(self.id),
            "email": self.email,
            "ip_address": self.ip_address,
            "success": self.success,
            "failure_reason": self.failure_reason,
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }


class PasswordResetToken(Base):
    """Password reset token model"""
    __tablename__ = "password_reset_tokens"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    token_hash = Column(String(255), nullable=False)
    expires_at = Column(DateTime(timezone=True), nullable=False, index=True)
    used = Column(Boolean, default=False)
    used_at = Column(DateTime(timezone=True))
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    def __repr__(self):
        return f"<PasswordResetToken(user_id={self.user_id}, used={self.used})>"


class EmailVerificationToken(Base):
    """Email verification token model"""
    __tablename__ = "email_verification_tokens"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    token_hash = Column(String(255), nullable=False)
    expires_at = Column(DateTime(timezone=True), nullable=False, index=True)
    used = Column(Boolean, default=False)
    used_at = Column(DateTime(timezone=True))
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    def __repr__(self):
        return f"<EmailVerificationToken(user_id={self.user_id}, used={self.used})>"


class OptionSet(Base):
    """Configuration option sets for static data management"""
    __tablename__ = "option_sets"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), unique=True, nullable=False, index=True)
    description = Column(Text)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    # Relationships
    option_values = relationship("OptionValue", back_populates="option_set", cascade="all, delete-orphan")
    
    def __repr__(self):
        return f"<OptionSet(id={self.id}, name={self.name})>"
    
    def to_dict(self):
        """Convert option set to dictionary"""
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }


class OptionValue(Base):
    """Individual option values within option sets"""
    __tablename__ = "option_values"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    option_set_id = Column(Integer, ForeignKey("option_sets.id", ondelete="CASCADE"), nullable=False, index=True)
    value_name = Column(String(100), nullable=False)
    display_name = Column(String(200))
    sort_order = Column(Integer, default=0)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    # Relationships
    option_set = relationship("OptionSet", back_populates="option_values")
    theme_config = relationship("ThemeConfig", back_populates="option_value", uselist=False, cascade="all, delete-orphan")
    
    def __repr__(self):
        return f"<OptionValue(id={self.id}, value_name={self.value_name})>"
    
    def to_dict(self):
        """Convert option value to dictionary"""
        return {
            "id": self.id,
            "option_set_id": self.option_set_id,
            "value_name": self.value_name,
            "display_name": self.display_name,
            "sort_order": self.sort_order,
            "is_active": self.is_active,
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }


class ThemeConfig(Base):
    """Theme configuration attributes for appearance option values"""
    __tablename__ = "theme_configs"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    option_value_id = Column(Integer, ForeignKey("option_values.id", ondelete="CASCADE"), nullable=False, unique=True)
    name = Column(String(100), nullable=False)  # Theme display name
    text_color = Column(String(7), nullable=False)  # Hex color code
    background_color = Column(String(7), nullable=False)  # Hex color code
    menu_color = Column(String(7), nullable=False)  # Hex color code
    border_line_color = Column(String(7), nullable=False)  # Hex color code
    metadata = Column(JSONB, default={})  # Additional theme properties
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    
    # Relationships
    option_value = relationship("OptionValue", back_populates="theme_config")
    
    def __repr__(self):
        return f"<ThemeConfig(id={self.id}, name={self.name})>"
    
    def to_dict(self):
        """Convert theme config to dictionary"""
        return {
            "id": self.id,
            "option_value_id": self.option_value_id,
            "name": self.name,
            "text_color": self.text_color,
            "background_color": self.background_color,
            "menu_color": self.menu_color,
            "border_line_color": self.border_line_color,
            "metadata": self.metadata,
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }
