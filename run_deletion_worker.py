"""
Account Deletion Worker - Railway Deployment
This script can be triggered by Railway's cron service or run manually
"""

import os
import sys

# Add parent directory to path for imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from workers.account_deletion_worker import run_worker
import asyncio

if __name__ == "__main__":
    print("=== Account Deletion Worker ===")
    print(f"Starting at: {os.popen('date').read().strip()}")
    print(f"DATABASE_URL configured: {'Yes' if os.getenv('DATABASE_URL') else 'No'}")
    
    asyncio.run(run_worker())
    
    print(f"Finished at: {os.popen('date').read().strip()}")
    print("===============================")
