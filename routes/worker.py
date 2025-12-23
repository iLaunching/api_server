"""
Worker Management Routes
Endpoints for triggering and monitoring background workers
"""

import structlog
from fastapi import APIRouter, HTTPException, status, Depends
from typing import Dict

from workers.account_deletion_worker import process_pending_deletions

logger = structlog.get_logger()
router = APIRouter()


@router.post("/worker/account-deletion")
async def trigger_account_deletion_worker():
    """
    Manually trigger the account deletion worker
    
    This endpoint can be used for:
    - Manual testing
    - Triggering from external cron services
    - Emergency cleanup
    
    Note: Normally runs automatically via scheduled cron job
    """
    try:
        logger.info("Manual trigger: Account deletion worker")
        
        # Run the worker
        await process_pending_deletions()
        
        return {
            "success": True,
            "message": "Account deletion worker completed successfully"
        }
        
    except Exception as e:
        logger.error("Account deletion worker trigger failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Account deletion worker failed: {str(e)}"
        )


@router.get("/worker/account-deletion/status")
async def get_deletion_worker_status():
    """
    Get status of pending account deletions
    
    Returns counts and information about pending deletions
    """
    try:
        from config.database import get_db
        from sqlalchemy import text
        
        async for db in get_db():
            # Get pending deletions count
            result = await db.execute(text("""
                SELECT COUNT(*) as total,
                       COUNT(CASE WHEN execution_date <= NOW() THEN 1 END) as ready,
                       COUNT(CASE WHEN execution_date > NOW() THEN 1 END) as waiting
                FROM account_deletions
                WHERE status = 'pending'
            """))
            
            stats = result.fetchone()
            
            # Get next execution date
            next_deletion = await db.execute(text("""
                SELECT execution_date
                FROM account_deletions
                WHERE status = 'pending' AND execution_date > NOW()
                ORDER BY execution_date ASC
                LIMIT 1
            """))
            
            next_row = next_deletion.fetchone()
            
            return {
                "pending_total": stats[0] if stats else 0,
                "ready_to_delete": stats[1] if stats else 0,
                "waiting": stats[2] if stats else 0,
                "next_deletion": next_row[0].isoformat() if next_row else None
            }
            
    except Exception as e:
        logger.error("Failed to get account deletion worker status", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to get account deletion worker status"
        )
