"""
SQLAlchemy User Models
Defines database models for users, sessions, and authentication.
"""

from datetime import datetime
from typing import Optional
from sqlalchemy import Column, String, Boolean, DateTime, ForeignKey, Text, Integer
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.orm import relationship, foreign
import uuid

from config.database import Base

class User(Base):
    """User account model"""
    __tablename__ = "users"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String(255), unique=True, nullable=False, index=True)
    password_hash = Column(String(255), nullable=True)  # Nullable for OAuth users
    first_name = Column(String(255))
    last_name = Column(String(255))
    oauth_provider = Column(String(50))
    oauth_provider_id = Column(String(255))
    role = Column(String(50), default="user")
    membership = Column(String(50), default="Individual")  # Individual or Enterprise
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
        # Construct full name from first_name and last_name
        name = None
        if self.first_name and self.last_name:
            name = f"{self.first_name} {self.last_name}"
        elif self.first_name:
            name = self.first_name
        elif self.last_name:
            name = self.last_name
            
        data = {
            "id": str(self.id),
            "email": self.email,
            "first_name": self.first_name,
            "last_name": self.last_name,
            "name": name,  # Computed field for backwards compatibility
            "role": self.role,
            "membership": self.membership,
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
    onboarding_completed = Column(Boolean, default=False)
    
    # Account type (foreign key to option_values)
    account_type_id = Column(Integer, ForeignKey("option_values.id", ondelete="SET NULL"), nullable=True, index=True)
    
    # Appearance theme (foreign key to option_values for 'appearance' option set)
    appearance_id = Column(Integer, ForeignKey("option_values.id", ondelete="SET NULL"), nullable=True, index=True, default=6)
    
    # iTheme (foreign key to option_values for 'itheme' option set)
    itheme_id = Column(Integer, ForeignKey("option_values.id", ondelete="SET NULL"), nullable=True, index=True, default=10)
    
    # Avatar color (foreign key to option_values for 'smarthub_color_scheme' option set)
    avatar_color_id = Column(Integer, ForeignKey("option_values.id", ondelete="SET NULL"), nullable=True, index=True)
    
    # Profile icon (foreign key to option_values for 'icon_library' option set)
    profile_icon_id = Column(Integer, ForeignKey("option_values.id", ondelete="SET NULL"), nullable=True, index=True)
    
    # Avatar display option (24=default/initials, 25=image, 26=icon)
    avatar_display_option_value_id = Column(Integer, nullable=True, index=True, default=24)
    
    # Navigation (one-to-one with user_navigation table)
    user_navigation_id = Column(UUID(as_uuid=True), nullable=True, unique=True, index=True)
    
    created_at = Column(DateTime(timezone=True), default=datetime.utcnow)
    updated_at = Column(DateTime(timezone=True), default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = relationship("User", back_populates="profile")
    navigation = relationship(
        "UserNavigation",
        primaryjoin="UserProfile.id == foreign(UserNavigation.user_profile_id)",
        uselist=False,
        viewonly=True
    )
    account_type = relationship("OptionValue", foreign_keys=[account_type_id])
    appearance = relationship("OptionValue", foreign_keys=[appearance_id])
    itheme = relationship("OptionValue", foreign_keys=[itheme_id])
    avatar_color = relationship("OptionValue", foreign_keys=[avatar_color_id])
    profile_icon = relationship("OptionValue", foreign_keys=[profile_icon_id])
    
    # Smart Hubs - one-to-many relationship through user_id
    smart_hubs = relationship(
        "SmartHub",
        primaryjoin="foreign(SmartHub.owner_id) == UserProfile.user_id",
        viewonly=True
    )
    
    def __repr__(self):
        return f"<UserProfile(id={self.id}, user_id={self.user_id})>"
    
    def to_dict(self):
        """Convert profile to dictionary"""
        account_type_data = None
        if self.account_type:
            account_type_data = {
                "id": self.account_type.id,
                "value_name": self.account_type.value_name,
                "display_name": self.account_type.display_name
            }
        
        appearance_data = None
        if self.appearance:
            appearance_data = {
                "id": self.appearance.id,
                "value_name": self.appearance.value_name,
                "display_name": self.appearance.display_name
            }
        
        itheme_data = None
        if self.itheme:
            itheme_data = {
                "id": self.itheme.id,
                "value_name": self.itheme.value_name,
                "display_name": self.itheme.display_name
            }
        
        return {
            "id": str(self.id),
            "user_id": str(self.user_id),
            "phone": self.phone,
            "avatar_url": self.avatar_url,
            "bio": self.bio,
            "timezone": self.timezone,
            "language": self.language,
            "preferences": self.preferences,
            "onboarding_completed": self.onboarding_completed,
            "user_navigation_id": str(self.user_navigation_id) if self.user_navigation_id else None,
            "account_type_id": self.account_type_id,
            "account_type": account_type_data,
            "appearance_id": self.appearance_id,
            "appearance": appearance_data,
            "itheme_id": self.itheme_id,
            "itheme": itheme_data,
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

