-- Business AI Advisor Database Schema

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Analysis Jobs Table
CREATE TABLE analysis_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_name VARCHAR(255) NOT NULL,
    industry VARCHAR(100),
    analysis_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'queued',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    completed_at TIMESTAMP WITH TIME ZONE,
    user_session VARCHAR(255),
    metadata JSONB DEFAULT '{}',
    progress INTEGER DEFAULT 0,
    error_message TEXT
);

-- Analysis Results Table
CREATE TABLE analysis_results (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    job_id UUID REFERENCES analysis_jobs(id) ON DELETE CASCADE,
    worker_type VARCHAR(50) NOT NULL,
    result_data JSONB NOT NULL,
    confidence_score DECIMAL(3,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    processing_time_ms INTEGER,
    data_sources TEXT[]
);

-- External Data Cache Table
CREATE TABLE data_cache (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cache_key VARCHAR(255) UNIQUE NOT NULL,
    data_source VARCHAR(50) NOT NULL,
    cached_data JSONB NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- LLM Usage Tracking Table
CREATE TABLE llm_usage (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    job_id UUID REFERENCES analysis_jobs(id),
    model_name VARCHAR(100) NOT NULL,
    provider VARCHAR(50) NOT NULL,
    prompt_tokens INTEGER,
    completion_tokens INTEGER,
    total_tokens INTEGER,
    cost_usd DECIMAL(10,6),
    latency_ms INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Worker Health Table
CREATE TABLE worker_health (
    worker_id VARCHAR(100) PRIMARY KEY,
    worker_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    last_heartbeat TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    tasks_completed INTEGER DEFAULT 0,
    tasks_failed INTEGER DEFAULT 0,
    avg_processing_time_ms INTEGER,
    metadata JSONB DEFAULT '{}'
);

-- Create Indexes
CREATE INDEX idx_analysis_jobs_status ON analysis_jobs(status);
CREATE INDEX idx_analysis_jobs_created_at ON analysis_jobs(created_at);
CREATE INDEX idx_analysis_jobs_company ON analysis_jobs(company_name);
CREATE INDEX idx_analysis_results_job_id ON analysis_results(job_id);
CREATE INDEX idx_analysis_results_worker_type ON analysis_results(worker_type);
CREATE INDEX idx_data_cache_key ON data_cache(cache_key);
CREATE INDEX idx_data_cache_expires ON data_cache(expires_at);
CREATE INDEX idx_llm_usage_job_id ON llm_usage(job_id);
CREATE INDEX idx_llm_usage_created_at ON llm_usage(created_at);
CREATE INDEX idx_worker_health_type ON worker_health(worker_type);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply trigger to analysis_jobs
CREATE TRIGGER update_analysis_jobs_updated_at 
    BEFORE UPDATE ON analysis_jobs 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data for development
INSERT INTO analysis_jobs (company_name, industry, analysis_type, status) VALUES
('TechCorp Inc', 'technology', 'full_analysis', 'completed'),
('RetailGiant', 'retail', 'competitor_analysis', 'in_progress'),
('StartupXYZ', 'fintech', 'market_analysis', 'queued');