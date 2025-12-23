# Account Deletion Worker Setup

## Overview
Automated worker that permanently deletes user accounts after their 30-day grace period expires.

## How It Works

### Daily Schedule
- **Runs:** Every day at 3:00 AM UTC
- **Purpose:** Process accounts whose `execution_date` has passed

### Workflow
1. **Find Candidates**
   ```sql
   SELECT user_id FROM account_deletions 
   WHERE execution_date <= NOW() AND status = 'pending'
   ```

2. **Delete Related Data**
   - User sessions
   - User profiles
   - Smart hub memberships
   - Owned smart hubs
   - Verification codes
   - Any other related data

3. **Delete User Row**
   - Removes the user from `users` table

4. **Mark Complete**
   - Updates `account_deletions` status to `'completed'`
   - Alternative: Delete the queue row entirely

## Railway Deployment Options

### Option 1: Railway Cron Service (Recommended)

1. **Create a New Service in Railway**
   - Go to your Railway project
   - Click "New Service"
   - Select "Cron Job"

2. **Configure the Cron Job**
   - **Schedule:** `0 3 * * *` (daily at 3 AM)
   - **Command:** `python run_deletion_worker.py`
   - **Environment Variables:** Link to your existing database

3. **Deploy**
   - Railway will automatically run the worker on schedule

### Option 2: External Cron Service

Use services like:
- **EasyCron** (https://easycron.com)
- **Cron-job.org** (https://cron-job.org)
- **GitHub Actions** (free for public repos)

Configure them to call:
```bash
curl -X POST https://your-api.railway.app/api/v1/worker/account-deletion
```

Then create an endpoint in your API to trigger the worker.

### Option 3: Railway Scheduled Deployments

Add to your `railway.json`:
```json
{
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "python main.py",
    "restartPolicyType": "ON_FAILURE"
  },
  "cron": {
    "accountDeletion": {
      "schedule": "0 3 * * *",
      "command": "python run_deletion_worker.py"
    }
  }
}
```

## Manual Testing

Run the worker manually to test:

```bash
# Locally (with DATABASE_URL set)
export DATABASE_URL="postgresql://..."
python run_deletion_worker.py

# On Railway (using Railway CLI)
railway run python run_deletion_worker.py
```

## Monitoring

Check logs to verify the worker is running:

```bash
# Railway logs
railway logs

# Look for these messages:
# 🔄 Starting account deletion worker
# 📋 Found X account(s) to delete
# ✅ Successfully deleted account
# 🎉 Account deletion worker completed
```

## Safety Features

1. **Transaction-based:** Each deletion is wrapped in a transaction
2. **Error handling:** Failed deletions don't stop processing others
3. **Audit trail:** Option to keep deletion records as 'completed'
4. **Logging:** Comprehensive logging for monitoring

## Customization

### Change Schedule
Edit the cron expression in your deployment:
- `0 3 * * *` - Daily at 3 AM
- `0 */6 * * *` - Every 6 hours
- `0 3 * * 0` - Weekly (Sunday at 3 AM)

### Keep Deletion Records
The account deletion worker updates status to `'completed'` by default.

To delete records instead, edit `workers/account_deletion_worker.py`:
```python
# Uncomment this in mark_deletion_complete():
await conn.execute("""
    DELETE FROM account_deletions WHERE id = $1
""", deletion_id)
```

### Add More Related Tables
Edit `cleanup_user_data()` to include additional tables:
```python
await conn.execute("""
    DELETE FROM your_table WHERE user_id = $1
""", user_id)
```

## Troubleshooting

### Worker not running?
- Check Railway cron job logs
- Verify DATABASE_URL is set
- Ensure the account deletion worker service is deployed

### Deletions not processing?
- Check if accounts have `execution_date <= NOW()`
- Verify status is `'pending'`
- Look for errors in account deletion worker logs

### Database connection issues?
- Verify DATABASE_URL is correct
- Check database connection limits
- Ensure account deletion worker has network access

## Security Considerations

1. **Irreversible:** Deletions are permanent - no recovery
2. **Grace period:** 30 days gives users time to reconsider
3. **Immediate blocking:** Access is revoked when deletion is queued
4. **Audit trail:** Keep completed records for compliance

## Next Steps

1. Deploy the account deletion worker to Railway
2. Test with a test account
3. Monitor logs for first few days
4. Set up alerts for failures (optional)
