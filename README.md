# API Server - Main Entry Point

FastAPI-based API server that handles requests from Bubble frontend and coordinates with other services.

## Features
- RESTful API endpoints
- WebSocket streaming for real-time responses
- Authentication middleware
- Request validation and error handling
- Connection to AI orchestrator

## Endpoints
- `GET /health` - Health check
- `POST /api/v1/analyze` - Start business analysis
- `GET /api/v1/status/{job_id}` - Check analysis status
- `WS /ws/{session_id}` - WebSocket for streaming results

## Environment Variables
- `DATABASE_URL` - PostgreSQL connection string
- `REDIS_URL` - Redis connection string
- `AI_ORCHESTRATOR_URL` - Main AI service URL
- `PORT` - Server port (default: 8000)# Railway deployment trigger Fri Oct 10 16:25:01 UTC 2025
# Trigger Railway restart
