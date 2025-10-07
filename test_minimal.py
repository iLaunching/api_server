"""
Minimal test to check if the issue is with database initialization
"""
import os
import asyncio
from fastapi import FastAPI
import uvicorn

# Create a minimal FastAPI app without database initialization
app = FastAPI(
    title="Database Test API",
    version="1.0.0"
)

@app.get("/")
async def root():
    return {"message": "API is running"}

@app.get("/test-env")
async def test_env():
    return {
        "has_database_url": bool(os.getenv("DATABASE_URL")),
        "has_redis_url": bool(os.getenv("REDIS_URL")),
        "database_url_prefix": os.getenv("DATABASE_URL", "")[:30] if os.getenv("DATABASE_URL") else None,
        "redis_url_prefix": os.getenv("REDIS_URL", "")[:30] if os.getenv("REDIS_URL") else None
    }

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)