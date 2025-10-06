"""
Status endpoints for checking job progress and results.
"""

from typing import Dict, Any, Optional
from fastapi import APIRouter, Depends, HTTPException
import structlog

from models.schemas import JobStatus, JobStatusEnum
from auth.middleware import get_current_session

logger = structlog.get_logger()
router = APIRouter()

@router.get("/status/{job_id}", response_model=JobStatus)
async def get_job_status(
    job_id: str,
    session_id: str = Depends(get_current_session)
):
    """
    Get the current status of an analysis job.
    
    Returns detailed information about job progress, current stage,
    and any available results.
    """
    
    # Import active_jobs from analysis route
    from routes.analysis import active_jobs
    
    if job_id not in active_jobs:
        raise HTTPException(
            status_code=404,
            detail=f"Job {job_id} not found"
        )
    
    job = active_jobs[job_id]
    
    # Check if the session has access to this job
    if job["session_id"] != session_id:
        raise HTTPException(
            status_code=403,
            detail="Access denied to this job"
        )
    
    # Prepare results preview if available
    results_preview = None
    if job["status"] == JobStatusEnum.COMPLETED and "results" in job:
        results_preview = {
            "executive_summary_preview": job["results"]["executive_summary"][:200] + "...",
            "confidence_score": job["results"]["confidence_score"],
            "recommendations_count": len(job["results"]["recommendations"])
        }
    
    logger.info("Status requested", job_id=job_id, session_id=session_id, status=job["status"])
    
    return JobStatus(
        job_id=job_id,
        status=job["status"],
        progress=job["progress"],
        current_stage=job["current_stage"],
        message=f"Analysis for {job['company_name']} is {job['status'].value}",
        created_at=job["created_at"],
        updated_at=job["updated_at"],
        completed_at=job.get("completed_at"),
        error_message=job.get("error_message"),
        results_preview=results_preview
    )

@router.get("/status/{job_id}/results")
async def get_job_results(
    job_id: str,
    session_id: str = Depends(get_current_session)
):
    """
    Get the full results of a completed analysis job.
    """
    
    from routes.analysis import active_jobs
    
    if job_id not in active_jobs:
        raise HTTPException(
            status_code=404,
            detail=f"Job {job_id} not found"
        )
    
    job = active_jobs[job_id]
    
    # Check session access
    if job["session_id"] != session_id:
        raise HTTPException(
            status_code=403,
            detail="Access denied to this job"
        )
    
    # Check if job is completed
    if job["status"] != JobStatusEnum.COMPLETED:
        raise HTTPException(
            status_code=400,
            detail=f"Job is not completed. Current status: {job['status'].value}"
        )
    
    # Return full results
    if "results" not in job:
        raise HTTPException(
            status_code=404,
            detail="Results not available"
        )
    
    logger.info("Results requested", job_id=job_id, session_id=session_id)
    
    return {
        "job_id": job_id,
        "status": job["status"],
        "completed_at": job["completed_at"],
        "results": job["results"]
    }

@router.get("/jobs")
async def list_user_jobs(
    session_id: str = Depends(get_current_session),
    limit: int = 10,
    offset: int = 0
):
    """
    List all jobs for the current session.
    """
    
    from routes.analysis import active_jobs
    
    # Filter jobs by session
    user_jobs = [
        {
            "job_id": job_id,
            "company_name": job["company_name"],
            "analysis_type": job["analysis_type"],
            "status": job["status"],
            "progress": job["progress"],
            "created_at": job["created_at"],
            "updated_at": job["updated_at"]
        }
        for job_id, job in active_jobs.items()
        if job["session_id"] == session_id
    ]
    
    # Sort by creation date (newest first)
    user_jobs.sort(key=lambda x: x["created_at"], reverse=True)
    
    # Apply pagination
    total = len(user_jobs)
    paginated_jobs = user_jobs[offset:offset + limit]
    
    logger.info("Jobs listed", session_id=session_id, total=total, returned=len(paginated_jobs))
    
    return {
        "jobs": paginated_jobs,
        "total": total,
        "limit": limit,
        "offset": offset,
        "has_more": offset + limit < total
    }

@router.delete("/status/{job_id}")
async def cancel_job(
    job_id: str,
    session_id: str = Depends(get_current_session)
):
    """
    Cancel a running analysis job.
    """
    
    from routes.analysis import active_jobs
    
    if job_id not in active_jobs:
        raise HTTPException(
            status_code=404,
            detail=f"Job {job_id} not found"
        )
    
    job = active_jobs[job_id]
    
    # Check session access
    if job["session_id"] != session_id:
        raise HTTPException(
            status_code=403,
            detail="Access denied to this job"
        )
    
    # Check if job can be cancelled
    if job["status"] in [JobStatusEnum.COMPLETED, JobStatusEnum.FAILED, JobStatusEnum.CANCELLED]:
        raise HTTPException(
            status_code=400,
            detail=f"Cannot cancel job with status: {job['status'].value}"
        )
    
    # Cancel the job
    job["status"] = JobStatusEnum.CANCELLED
    job["updated_at"] = job["completed_at"] = job.get("updated_at")
    job["error_message"] = "Job cancelled by user"
    
    logger.info("Job cancelled", job_id=job_id, session_id=session_id)
    
    return {
        "job_id": job_id,
        "status": "cancelled",
        "message": "Job cancelled successfully"
    }