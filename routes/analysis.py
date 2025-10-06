"""
Analysis endpoints for business AI analysis requests.
"""

import uuid
import asyncio
from datetime import datetime, timedelta
from typing import Dict, Any
from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
import structlog

from models.schemas import (
    AnalysisRequest, 
    AnalysisResponse, 
    JobStatusEnum,
    StreamMessage
)
from auth.middleware import get_current_session

logger = structlog.get_logger()
router = APIRouter()

# In-memory job storage (will be replaced with database in later phases)
active_jobs: Dict[str, Dict[str, Any]] = {}

@router.post("/analyze", response_model=AnalysisResponse)
async def start_analysis(
    request: AnalysisRequest,
    background_tasks: BackgroundTasks,
    session_id: str = Depends(get_current_session)
):
    """
    Start a new business analysis.
    
    This endpoint receives analysis requests from Bubble and initiates
    the analysis workflow. Returns immediately with job details and
    WebSocket URL for real-time updates.
    """
    
    # Generate unique job ID
    job_id = str(uuid.uuid4())
    
    # Create job record
    job_data = {
        "job_id": job_id,
        "session_id": session_id,
        "company_name": request.company_name,
        "industry": request.industry,
        "analysis_type": request.analysis_type,
        "additional_context": request.additional_context,
        "priority": request.priority,
        "status": JobStatusEnum.QUEUED,
        "progress": 0,
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow(),
        "current_stage": "queued"
    }
    
    # Store job
    active_jobs[job_id] = job_data
    
    # Add background task to process analysis
    background_tasks.add_task(process_analysis, job_id)
    
    # Calculate estimated completion time
    estimated_completion = datetime.utcnow() + timedelta(minutes=5)  # Basic estimate
    
    logger.info(
        "Analysis started",
        job_id=job_id,
        session_id=session_id,
        company_name=request.company_name,
        analysis_type=request.analysis_type
    )
    
    return AnalysisResponse(
        job_id=job_id,
        status=JobStatusEnum.QUEUED,
        message=f"Analysis started for {request.company_name}",
        websocket_url=f"/ws/{session_id}",
        created_at=job_data["created_at"],
        estimated_completion=estimated_completion
    )

async def process_analysis(job_id: str):
    """
    Background task to process analysis.
    
    This is a simplified version that simulates analysis processing.
    In later phases, this will coordinate with the AI orchestrator
    and specialized workers.
    """
    
    if job_id not in active_jobs:
        logger.error("Job not found for processing", job_id=job_id)
        return
    
    job = active_jobs[job_id]
    session_id = job["session_id"]
    
    try:
        # Update job status
        job["status"] = JobStatusEnum.IN_PROGRESS
        job["updated_at"] = datetime.utcnow()
        job["current_stage"] = "data_collection"
        job["progress"] = 10
        
        # Send WebSocket update
        progress_blocks = [{
            "id": f"progress_{job_id}_1",
            "type": "paragraph",
            "data": {
                "text": f"🔍 Starting analysis for <b>{job['company_name']}</b>...",
                "alignment": "left"
            }
        }]
        
        await send_job_update(session_id, job_id, {
            "type": "progress",
            "job_id": job_id,
            "stage": "data_collection",
            "content": f"🔍 Starting analysis for {job['company_name']}...",
            "progress": 10,
            "blocks": progress_blocks,
            "isContentChunk": True,
            "chunkNumber": 1,
            "totalChunks": 4,  # We'll send 4 progress updates + 1 final
            "complete": False,
            "editor_data": {
                "time": int(datetime.utcnow().timestamp() * 1000),
                "blocks": progress_blocks,
                "version": "2.30.6"
            }
        })
        
        # Simulate data collection phase
        await asyncio.sleep(2)
        job["progress"] = 30
        job["current_stage"] = "competitor_analysis"
        progress_blocks = [{
            "id": f"progress_{job_id}_2",
            "type": "paragraph",
            "data": {
                "text": "📊 Analyzing <span style=\"color: rgb(16, 185, 129);\">competitor landscape</span>...",
                "alignment": "left"
            }
        }]
        
        await send_job_update(session_id, job_id, {
            "type": "progress",
            "job_id": job_id,
            "stage": "competitor_analysis",
            "content": "📊 Analyzing competitor landscape...",
            "progress": 30,
            "blocks": progress_blocks,
            "isContentChunk": True,
            "chunkNumber": 2,
            "totalChunks": 4,
            "complete": False,
            "editor_data": {
                "time": int(datetime.utcnow().timestamp() * 1000),
                "blocks": progress_blocks,
                "version": "2.30.6"
            }
        })
        
        # Simulate competitor analysis
        await asyncio.sleep(3)
        job["progress"] = 60
        job["current_stage"] = "market_trends"
        progress_blocks = [{
            "id": f"progress_{job_id}_3",
            "type": "paragraph",
            "data": {
                "text": "📈 Examining <b>market trends</b> and opportunities...",
                "alignment": "left"
            }
        }]
        
        await send_job_update(session_id, job_id, {
            "type": "progress",
            "job_id": job_id,
            "stage": "market_trends",
            "content": "📈 Examining market trends and opportunities...",
            "progress": 60,
            "blocks": progress_blocks,
            "isContentChunk": True,
            "chunkNumber": 3,
            "totalChunks": 4,
            "complete": False,
            "editor_data": {
                "time": int(datetime.utcnow().timestamp() * 1000),
                "blocks": progress_blocks,
                "version": "2.30.6"
            }
        })
        
        # Simulate market analysis
        await asyncio.sleep(2)
        job["progress"] = 80
        job["current_stage"] = "synthesis"
        progress_blocks = [{
            "id": f"progress_{job_id}_4",
            "type": "paragraph",
            "data": {
                "text": "🧠 Synthesizing <i>insights</i> and <b>recommendations</b>...",
                "alignment": "left"
            }
        }]
        
        await send_job_update(session_id, job_id, {
            "type": "progress",
            "job_id": job_id,
            "stage": "synthesis",
            "content": "🧠 Synthesizing insights and recommendations...",
            "progress": 80,
            "blocks": progress_blocks,
            "isContentChunk": True,
            "chunkNumber": 4,
            "totalChunks": 4,
            "complete": False,
            "editor_data": {
                "time": int(datetime.utcnow().timestamp() * 1000),
                "blocks": progress_blocks,
                "version": "2.30.6"
            }
        })
        
        # Generate mock results
        await asyncio.sleep(2)
        mock_results = generate_mock_analysis_results(job['company_name'], job['industry'])
        
        # Complete the job
        job["status"] = JobStatusEnum.COMPLETED
        job["progress"] = 100
        job["current_stage"] = "completed"
        job["completed_at"] = datetime.utcnow()
        job["updated_at"] = datetime.utcnow()
        job["results"] = mock_results
        
        # Send final results
        await send_job_update(session_id, job_id, {
            "type": "completed",
            "job_id": job_id,
            "stage": "completed",
            "content": "✅ Analysis completed successfully!",
            "progress": 100,
            "results": mock_results,
            "blocks": mock_results["editor_data"]["blocks"],  # Send blocks for Editor.js animation
            "editor_data": mock_results["editor_data"],  # Keep for compatibility
            "isContentChunk": True,  # Mark as content chunk for processing
            "chunkNumber": 5,  # Final chunk after 4 progress updates
            "totalChunks": 5,  # 4 progress + 1 final
            "complete": True  # Mark as complete
        })
        
        logger.info("Analysis completed", job_id=job_id, company_name=job['company_name'])
        
    except Exception as e:
        # Handle errors
        job["status"] = JobStatusEnum.FAILED
        job["error_message"] = str(e)
        job["updated_at"] = datetime.utcnow()
        
        await send_job_update(session_id, job_id, {
            "type": "error",
            "job_id": job_id,
            "content": f"❌ Analysis failed: {str(e)}",
            "error": str(e)
        })
        
        logger.error("Analysis failed", job_id=job_id, error=str(e))

async def send_job_update(session_id: str, job_id: str, update_data: dict):
    """Send job update via WebSocket"""
    try:
        from main import send_to_websocket
        await send_to_websocket(session_id, update_data)
    except Exception as e:
        logger.error("Failed to send WebSocket update", session_id=session_id, error=str(e))

def generate_mock_analysis_results(company_name: str, industry: str) -> dict:
    """Generate mock analysis results for testing in Editor.js format"""
    
    industry_display = industry.title() if industry else "Technology"
    current_time = int(datetime.utcnow().timestamp() * 1000)  # Editor.js timestamp format
    
    # Generate unique block IDs
    import random
    import string
    
    def generate_block_id():
        return ''.join(random.choices(string.ascii_letters + string.digits, k=10))
    
    # Create Editor.js formatted blocks
    editor_blocks = [
        {
            "id": generate_block_id(),
            "type": "header1",
            "data": {
                "text": f"Business Analysis Report: <b>{company_name}</b>",
                "alignment": "left"
            }
        },
        {
            "id": generate_block_id(),
            "type": "paragraph",
            "data": {
                "text": f"📊 Based on our comprehensive analysis of <b>{company_name}</b> in the <span style=\"background-color: rgb(199, 210, 254); color: rgb(49, 46, 129);\">{industry_display}</span> sector, we've identified several key opportunities and strategic recommendations.",
                "alignment": "left"
            }
        },
        {
            "id": generate_block_id(),
            "type": "header2",
            "data": {
                "text": "🎯 <b>Key Findings</b>",
                "alignment": "left"
            }
        },
        {
            "id": generate_block_id(),
            "type": "bulletedList",
            "data": {
                "items": [
                    "<b>Market Position</b>: Strong competitive position with room for expansion",
                    "<b>Growth Opportunities</b>: 3 high-potential market segments identified", 
                    "<b>Risk Factors</b>: Moderate competition, regulatory considerations",
                    "<b>Recommendation</b>: Focus on <span style=\"color: rgb(16, 185, 129);\">digital transformation</span> and customer acquisition"
                ]
            }
        },
        {
            "id": generate_block_id(),
            "type": "divider",
            "data": {}
        },
        {
            "id": generate_block_id(),
            "type": "header2", 
            "data": {
                "text": "🏆 Competitive Landscape",
                "alignment": "left"
            }
        },
        {
            "id": generate_block_id(),
            "type": "numberedList",
            "data": {
                "items": [
                    "<b>12 direct competitors</b> analyzed across the market",
                    "Market share: Estimated <span style=\"background-color: rgb(254, 202, 202); color: rgb(153, 27, 27);\">8-15%</span> in target segment",
                    "Multiple <b>differentiation opportunities</b> identified",
                    "Competitive advantages in <i>brand recognition</i> and <i>customer service</i>"
                ],
                "alignment": "left"
            }
        },
        {
            "id": generate_block_id(),
            "type": "alert",
            "data": {
                "type": "info",
                "text": "📈 Industry growth rate: <b>12% annually</b> with strong momentum in AI, automation, and sustainability sectors"
            }
        },
        {
            "id": generate_block_id(),
            "type": "header2",
            "data": {
                "text": "🚀 Strategic Recommendations",
                "alignment": "left"
            }
        },
        {
            "id": generate_block_id(),
            "type": "table",
            "data": {
                "rows": [
                    {
                        "id": "header_row",
                        "cells": [
                            {"id": "h1", "text": "<b>Priority</b>", "color": "#6910A8"},
                            {"id": "h2", "text": "<b>Timeframe</b>", "color": "#6910A8"},
                            {"id": "h3", "text": "<b>Action</b>", "color": "#6910A8"},
                            {"id": "h4", "text": "<b>Expected Impact</b>", "color": "#6910A8"}
                        ]
                    },
                    {
                        "id": "row1",
                        "cells": [
                            {"id": "r1c1", "text": "🔥 High", "color": None},
                            {"id": "r1c2", "text": "0-6 months", "color": None},
                            {"id": "r1c3", "text": "Optimize marketing channels", "color": None},
                            {"id": "r1c4", "text": "15-20% increase in leads", "color": "#2D6A4F"}
                        ]
                    },
                    {
                        "id": "row2", 
                        "cells": [
                            {"id": "r2c1", "text": "⚡ Medium", "color": None},
                            {"id": "r2c2", "text": "6-12 months", "color": None},
                            {"id": "r2c3", "text": "Develop mobile app", "color": None},
                            {"id": "r2c4", "text": "New customer segments", "color": "#2D6A4F"}
                        ]
                    },
                    {
                        "id": "row3",
                        "cells": [
                            {"id": "r3c1", "text": "🎯 High", "color": None},
                            {"id": "r3c2", "text": "12-18 months", "color": None},
                            {"id": "r3c3", "text": "Strategic acquisition", "color": None},
                            {"id": "r3c4", "text": "Market share expansion", "color": "#2D6A4F"}
                        ]
                    }
                ],
                "columnWidths": [120, 120, 200, 180]
            }
        },
        {
            "id": generate_block_id(),
            "type": "callout",
            "data": {
                "emoji": "💡",
                "backgroundColor": "default",
                "text": f"<b>Confidence Score:</b> 85% based on comprehensive market data and industry benchmarks"
            }
        },
        {
            "id": generate_block_id(),
            "type": "quote",
            "data": {
                "text": f"The {industry_display} sector presents <b>significant opportunities</b> for {company_name} to expand market presence through strategic digital initiatives and customer-centric improvements.",
                "caption": f"Analysis completed at {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC",
                "alignment": "left"
            }
        }
    ]
    
    # Return in Editor.js format with metadata
    return {
        "editor_data": {
            "time": current_time,
            "blocks": editor_blocks,
            "version": "2.30.6"
        },
        "metadata": {
            "company_name": company_name,
            "industry": industry_display,
            "confidence_score": 0.85,
            "data_sources": ["Industry reports", "Competitor websites", "Social media analysis", "Market research"],
            "analysis_date": datetime.utcnow().isoformat(),
            "total_blocks": len(editor_blocks)
        }
    }