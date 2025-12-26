"""
Account Deletion Worker
Automated cleanup job that runs daily to permanently delete accounts
whose 30-day grace period has expired.

Schedule: Runs daily at 3:00 AM
"""

import asyncio
import asyncpg
import os
import structlog
from datetime import datetime

logger = structlog.get_logger()

DATABASE_URL = os.getenv("DATABASE_URL")

async def cleanup_user_data(conn, user_id: str):
    """
    Delete all user data from related tables
    
    Args:
        conn: Database connection
        user_id: UUID of the user to delete
    """
    logger.info("Starting user data cleanup", user_id=user_id)
    
    try:
        # Delete user sessions
        await conn.execute("""
            DELETE FROM sessions WHERE user_id = $1
        """, user_id)
        logger.info("Deleted sessions", user_id=user_id)
        
        # Delete user profile
        await conn.execute("""
            DELETE FROM user_profiles WHERE user_id = $1
        """, user_id)
        logger.info("Deleted user profile", user_id=user_id)
        
        # Delete smart hub memberships
        await conn.execute("""
            DELETE FROM smart_hub_members WHERE user_id = $1
        """, user_id)
        logger.info("Deleted smart hub memberships", user_id=user_id)
        
        # Delete owned smart hubs (cascade will handle related data)
        await conn.execute("""
            DELETE FROM smart_hubs WHERE owner_id = $1
        """, user_id)
        logger.info("Deleted owned smart hubs", user_id=user_id)
        
        # Delete verification codes if any
        await conn.execute("""
            DELETE FROM email_verification_codes WHERE email IN (
                SELECT email FROM users WHERE id = $1
            )
        """, user_id)
        logger.info("Deleted verification codes", user_id=user_id)
        
        # Add any other related tables here
        # Examples:
        # - Posts/Comments
        # - Notifications
        # - User settings
        # - File uploads
        # - Activity logs
        
        logger.info("User data cleanup completed", user_id=user_id)
        return True
        
    except Exception as e:
        logger.error("Failed to cleanup user data", user_id=user_id, error=str(e))
        raise


async def delete_user(conn, user_id: str):
    """
    Delete the user row from the users table
    
    Args:
        conn: Database connection
        user_id: UUID of the user to delete
    """
    try:
        await conn.execute("""
            DELETE FROM users WHERE id = $1
        """, user_id)
        logger.info("Deleted user row", user_id=user_id)
        return True
        
    except Exception as e:
        logger.error("Failed to delete user", user_id=user_id, error=str(e))
        raise


async def mark_deletion_complete(conn, deletion_id: str):
    """
    Mark the deletion request as completed
    Alternative: Delete the row entirely to save space
    
    Args:
        conn: Database connection
        deletion_id: UUID of the deletion request
    """
    try:
        # Option 1: Update status to 'completed' (keeps audit trail)
        await conn.execute("""
            UPDATE account_deletions
            SET status = 'completed'
            WHERE id = $1
        """, deletion_id)
        
        # Option 2: Delete the row entirely (uncomment to use this instead)
        # await conn.execute("""
        #     DELETE FROM account_deletions WHERE id = $1
        # """, deletion_id)
        
        logger.info("Marked deletion as completed", deletion_id=deletion_id)
        return True
        
    except Exception as e:
        logger.error("Failed to mark deletion complete", deletion_id=deletion_id, error=str(e))
        raise


async def process_pending_deletions():
    """
    Main worker function that processes all pending account deletions
    whose execution_date has passed
    """
    if not DATABASE_URL:
        logger.error("DATABASE_URL environment variable not set")
        return
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        logger.info("🔄 Starting account deletion worker")
        
        # Fetch all pending deletions whose execution date has passed
        pending_deletions = await conn.fetch("""
            SELECT id, user_id, request_date, execution_date
            FROM account_deletions
            WHERE execution_date <= NOW()
            AND status = 'pending'
            ORDER BY execution_date ASC
        """)
        
        if not pending_deletions:
            logger.info("✅ No pending deletions to process")
            return
        
        logger.info(f"📋 Found {len(pending_deletions)} account(s) to delete")
        
        # Process each deletion
        deleted_count = 0
        failed_count = 0
        
        for deletion in pending_deletions:
            deletion_id = str(deletion['id'])
            user_id = str(deletion['user_id'])
            execution_date = deletion['execution_date']
            
            logger.info(
                "Processing account deletion",
                deletion_id=deletion_id,
                user_id=user_id,
                execution_date=execution_date.isoformat()
            )
            
            try:
                # Begin transaction for this deletion
                async with conn.transaction():
                    # Step 1: Delete all user data from related tables
                    await cleanup_user_data(conn, user_id)
                    
                    # Step 2: Delete the user row
                    await delete_user(conn, user_id)
                    
                    # Step 3: Mark deletion as completed
                    await mark_deletion_complete(conn, deletion_id)
                
                deleted_count += 1
                logger.info(
                    "✅ Successfully deleted account",
                    deletion_id=deletion_id,
                    user_id=user_id
                )
                
            except Exception as e:
                failed_count += 1
                logger.error(
                    "❌ Failed to delete account",
                    deletion_id=deletion_id,
                    user_id=user_id,
                    error=str(e)
                )
                # Continue processing other deletions even if one fails
                continue
        
        logger.info(
            "🎉 Account deletion worker completed",
            total=len(pending_deletions),
            deleted=deleted_count,
            failed=failed_count
        )
        
    except Exception as e:
        logger.error("Fatal error in account deletion worker", error=str(e))
        raise
        
    finally:
        await conn.close()


async def run_worker():
    """
    Entry point for the account deletion worker
    """
    logger.info("🚀 Account Deletion Worker Starting", time=datetime.utcnow().isoformat())
    
    try:
        await process_pending_deletions()
    except Exception as e:
        logger.error("Account deletion worker failed", error=str(e))
        raise
    
    logger.info("✅ Account Deletion Worker Finished", time=datetime.utcnow().isoformat())


if __name__ == "__main__":
    # Run the account deletion worker
    asyncio.run(run_worker())
