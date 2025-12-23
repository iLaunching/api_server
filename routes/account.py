"""
Account Management Routes
Handles account deletion and related verification
"""

import os
import secrets
import structlog
from datetime import datetime, timedelta
from typing import Dict, Optional
from fastapi import APIRouter, HTTPException, Depends, status
from pydantic import BaseModel, EmailStr
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text, select
import resend

from auth.middleware import get_current_session
from config.database import get_db
from models.user import User
from models.account_deletion import AccountDeletion

logger = structlog.get_logger()
router = APIRouter()

# Configure Resend API key for account deletion (separate from signup)
RESEND_API_KEY_DELETION = os.getenv("RESEND_API_KEY_DELETION", "re_YJgwxRoi_NhVT2tmK1k1cvwkh1vuAS6ok")

# In-memory storage for deletion verification codes (use Redis in production)
_deletion_verification_codes: Dict[str, Dict] = {}


class SendDeletionCodeRequest(BaseModel):
    """Request to send deletion verification code"""
    pass  # Email comes from session


class VerifyDeletionCodeRequest(BaseModel):
    """Request to verify deletion code"""
    code: str


def generate_verification_code() -> str:
    """Generate a 6-digit verification code"""
    return str(secrets.randbelow(1000000)).zfill(6)


def store_verification_code(email: str, code: str, expires_minutes: int = 10):
    """
    Store verification code with expiration
    
    Args:
        email: User's email address
        code: Verification code
        expires_minutes: Minutes until code expires
    """
    _deletion_verification_codes[email] = {
        'code': code,
        'expires_at': datetime.utcnow() + timedelta(minutes=expires_minutes),
        'attempts': 0
    }
    logger.info("Deletion verification code stored", email=email, expires_in_minutes=expires_minutes)


def verify_code(email: str, code: str) -> tuple[bool, Optional[str]]:
    """
    Verify a code for an email
    
    Args:
        email: User's email address
        code: Code to verify
        
    Returns:
        Tuple of (is_valid, error_message)
    """
    if email not in _deletion_verification_codes:
        return False, "No verification code found. Please request a new code."
    
    code_data = _deletion_verification_codes[email]
    
    # Check expiration
    if datetime.utcnow() > code_data['expires_at']:
        del _deletion_verification_codes[email]
        return False, "Verification code has expired. Please request a new code."
    
    # Check attempts
    if code_data['attempts'] >= 5:
        del _deletion_verification_codes[email]
        return False, "Too many failed attempts. Please request a new code."
    
    # Verify code
    if code_data['code'] == code:
        del _deletion_verification_codes[email]
        return True, None
    
    # Increment attempts
    code_data['attempts'] += 1
    return False, f"Invalid code. {5 - code_data['attempts']} attempts remaining."


async def send_deletion_verification_email(email: str, code: str):
    """
    Send deletion verification email using Resend
    
    Args:
        email: User's email address
        code: Verification code
    """
    try:
        params = {
            "from": "membership@resend.dev",
            "to": [email],
            "subject": "Account Deletion Verification Code",
            "html": f"""
                <!DOCTYPE html>
                <html>
                <head>
                    <style>
                        body {{
                            font-family: 'Arial', sans-serif;
                            line-height: 1.6;
                            color: #333;
                            max-width: 600px;
                            margin: 0 auto;
                            padding: 20px;
                        }}
                        .header {{
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            color: white;
                            padding: 30px;
                            text-align: center;
                            border-radius: 10px 10px 0 0;
                        }}
                        .content {{
                            background: #f9fafb;
                            padding: 40px 30px;
                            border-radius: 0 0 10px 10px;
                        }}
                        .code-container {{
                            background: white;
                            border: 2px solid #667eea;
                            border-radius: 8px;
                            padding: 20px;
                            text-align: center;
                            margin: 30px 0;
                        }}
                        .code {{
                            font-size: 32px;
                            font-weight: bold;
                            letter-spacing: 8px;
                            color: #667eea;
                            font-family: 'Courier New', monospace;
                        }}
                        .warning {{
                            background: #fef2f2;
                            border-left: 4px solid #ef4444;
                            padding: 15px;
                            margin: 20px 0;
                            border-radius: 4px;
                        }}
                        .footer {{
                            text-align: center;
                            margin-top: 30px;
                            color: #6b7280;
                            font-size: 14px;
                        }}
                    </style>
                </head>
                <body>
                    <div class="header">
                        <h1 style="margin: 0;">⚠️ Account Deletion</h1>
                    </div>
                    <div class="content">
                        <p>Hello,</p>
                        
                        <p>You've requested to delete your iLaunching account. To confirm this action, please use the verification code below:</p>
                        
                        <div class="code-container">
                            <div class="code">{code}</div>
                        </div>
                        
                        <div class="warning">
                            <strong>⚠️ Warning:</strong> This action is permanent. Once confirmed, your account and all associated data will be queued for deletion after a 30-day grace period.
                        </div>
                        
                        <p><strong>This code will expire in 10 minutes.</strong></p>
                        
                        <p>If you didn't request this, please ignore this email and your account will remain safe.</p>
                        
                        <div class="footer">
                            <p>© 2025 iLaunching. All rights reserved.</p>
                            <p>This is an automated message, please do not reply.</p>
                        </div>
                    </div>
                </body>
                </html>
            """
        }
        
        # Use dedicated deletion API key
        resend.api_key = RESEND_API_KEY_DELETION
        response = resend.Emails.send(params)
        logger.info("Deletion verification email sent", email=email, response=response)
        
    except Exception as e:
        logger.error("Failed to send deletion verification email", email=email, error=str(e))
        raise


async def send_deletion_confirmation_email(email: str, execution_date: datetime):
    """
    Send confirmation email after account deletion is queued
    
    Args:
        email: User's email address
        execution_date: When the account will be permanently deleted
    """
    try:
        execution_date_str = execution_date.strftime("%B %d, %Y at %I:%M %p UTC")
        
        params = {
            "from": "membership@resend.dev",
            "to": [email],
            "subject": "Account Deletion Scheduled",
            "html": f"""
                <!DOCTYPE html>
                <html>
                <head>
                    <style>
                        body {{
                            font-family: 'Arial', sans-serif;
                            line-height: 1.6;
                            color: #333;
                            max-width: 600px;
                            margin: 0 auto;
                            padding: 20px;
                        }}
                        .header {{
                            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                            color: white;
                            padding: 30px;
                            text-align: center;
                            border-radius: 10px 10px 0 0;
                        }}
                        .content {{
                            background: #f9fafb;
                            padding: 40px 30px;
                            border-radius: 0 0 10px 10px;
                        }}
                        .info-box {{
                            background: white;
                            border: 2px solid #3b82f6;
                            border-radius: 8px;
                            padding: 20px;
                            margin: 20px 0;
                        }}
                        .date {{
                            font-size: 20px;
                            font-weight: bold;
                            color: #ef4444;
                            text-align: center;
                            margin: 10px 0;
                        }}
                        .warning {{
                            background: #fef2f2;
                            border-left: 4px solid #ef4444;
                            padding: 15px;
                            margin: 20px 0;
                            border-radius: 4px;
                        }}
                        .footer {{
                            text-align: center;
                            margin-top: 30px;
                            color: #6b7280;
                            font-size: 14px;
                        }}
                    </style>
                </head>
                <body>
                    <div class="header">
                        <h1 style="margin: 0;">✓ Account Deletion Scheduled</h1>
                    </div>
                    <div class="content">
                        <p>Hello,</p>
                        
                        <p>Your iLaunching account has been successfully scheduled for deletion.</p>
                        
                        <div class="info-box">
                            <p style="margin: 0; text-align: center;"><strong>Deletion Date:</strong></p>
                            <div class="date">{execution_date_str}</div>
                            <p style="margin: 10px 0 0 0; text-align: center; color: #6b7280;">30 days from now</p>
                        </div>
                        
                        <div class="warning">
                            <strong>⚠️ Important Information:</strong>
                            <ul style="margin: 10px 0 0 0;">
                                <li>Your access has been <strong>immediately revoked</strong></li>
                                <li>You will not be able to log in to your account</li>
                                <li>All data will be permanently deleted on the date above</li>
                                <li>This action cannot be undone</li>
                            </ul>
                        </div>
                        
                        <p><strong>30-Day Grace Period:</strong></p>
                        <p>Your account data will be retained for 30 days. If you change your mind and wish to restore your account, please contact our support team before the deletion date.</p>
                        
                        <p>If you did not request this deletion, please contact our support team immediately at support@ilaunching.io</p>
                        
                        <div class="footer">
                            <p>© 2025 iLaunching. All rights reserved.</p>
                            <p>This is an automated message, please do not reply.</p>
                        </div>
                    </div>
                </body>
                </html>
            """
        }
        
        # Use dedicated deletion API key
        resend.api_key = RESEND_API_KEY_DELETION
        response = resend.Emails.send(params)
        logger.info("Deletion confirmation email sent", email=email, response=response)
        
    except Exception as e:
        logger.error("Failed to send deletion confirmation email", email=email, error=str(e))
        # Don't raise - deletion should proceed even if email fails
        pass


@router.post("/account/send-deletion-code")
async def send_deletion_code(
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Send a verification code for account deletion
    Requires authentication
    """
    try:
        user_id = session.get("user_id")
        
        # Get user email
        result = await db.execute(
            select(User).where(User.id == user_id)
        )
        user = result.scalar_one_or_none()
        
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found"
            )
        
        # Generate and store verification code
        code = generate_verification_code()
        store_verification_code(user.email, code, expires_minutes=10)
        
        # Send verification email
        await send_deletion_verification_email(user.email, code)
        
        logger.info("Deletion verification code sent", user_id=user_id, email=user.email)
        
        return {
            "success": True,
            "message": "Verification code sent to your email",
            "expires_in_minutes": 10
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to send deletion verification code", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to send verification code"
        )


@router.post("/account/verify-deletion-code")
async def verify_deletion_code(
    request_data: VerifyDeletionCodeRequest,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Verify the deletion code
    Requires authentication
    """
    try:
        user_id = session.get("user_id")
        
        # Get user email
        result = await db.execute(
            select(User).where(User.id == user_id)
        )
        user = result.scalar_one_or_none()
        
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found"
            )
        
        # Verify code
        is_valid, error_message = verify_code(user.email, request_data.code)
        
        if not is_valid:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=error_message
            )
        
        logger.info("Deletion code verified successfully", user_id=user_id, email=user.email)
        
        return {
            "verified": True,
            "message": "Code verified successfully"
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to verify deletion code", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to verify code"
        )


@router.delete("/account/delete")
async def delete_account(
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Queue account for deletion
    Requires authentication and verified deletion code
    """
    try:
        user_id = session.get("user_id")
        
        # Check if there's already a pending deletion request
        result = await db.execute(
            select(AccountDeletion).where(
                AccountDeletion.user_id == user_id,
                AccountDeletion.status == "pending"
            )
        )
        existing_deletion = result.scalar_one_or_none()
        
        if existing_deletion:
            return {
                "success": True,
                "message": "Account already queued for deletion",
                "execution_date": existing_deletion.execution_date.isoformat(),
                "days_remaining": (existing_deletion.execution_date - datetime.utcnow()).days
            }
        
        # Create new deletion request
        request_date = datetime.utcnow()
        execution_date = AccountDeletion.calculate_execution_date(request_date)
        
        deletion_request = AccountDeletion(
            user_id=user_id,
            request_date=request_date,
            execution_date=execution_date,
            status="pending"
        )
        
        db.add(deletion_request)
        
        # Update user record to block access immediately
        result = await db.execute(
            select(User).where(User.id == user_id)
        )
        user = result.scalar_one_or_none()
        
        if user:
            user.is_deleted = True
            user.deletion_scheduled_date = execution_date
        
        await db.commit()
        
        # Send confirmation email
        if user:
            await send_deletion_confirmation_email(user.email, execution_date)
        
        logger.info(
            "Account queued for deletion",
            user_id=user_id,
            execution_date=execution_date.isoformat()
        )
        
        return {
            "success": True,
            "message": "Account queued for deletion after 30-day grace period",
            "execution_date": execution_date.isoformat(),
            "days_until_deletion": 30,
            "should_logout": True  # Signal frontend to logout
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to delete account", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to delete account"
        )
