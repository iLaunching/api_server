-- ============================================
-- AUTHENTICATION & USER MANAGEMENT SCHEMA
-- Phase 1A: Foundation - Auth & Landing Page
-- ============================================

-- Enable UUID extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- USERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    role VARCHAR(50) DEFAULT 'user',
    subscription_tier VARCHAR(50) DEFAULT 'free',
    email_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_login TIMESTAMP WITH TIME ZONE,
    
    CONSTRAINT email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$')
);

-- ============================================
-- SESSIONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS sessions (
    session_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    refresh_token_hash VARCHAR(255) NOT NULL,
    device_info JSONB DEFAULT '{}',
    ip_address VARCHAR(45),
    user_agent TEXT,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    revoked BOOLEAN DEFAULT FALSE,
    revoked_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_accessed TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- USER PROFILES (Extended user information)
-- ============================================
CREATE TABLE IF NOT EXISTS user_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE UNIQUE,
    phone VARCHAR(20),
    avatar_url TEXT,
    bio TEXT,
    timezone VARCHAR(50) DEFAULT 'UTC',
    language VARCHAR(10) DEFAULT 'en',
    preferences JSONB DEFAULT '{}',
    onboarding_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- PASSWORD RESET TOKENS
-- ============================================
CREATE TABLE IF NOT EXISTS password_reset_tokens (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    used_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- EMAIL VERIFICATION TOKENS
-- ============================================
CREATE TABLE IF NOT EXISTS email_verification_tokens (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    used_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- LOGIN ATTEMPTS (Security tracking)
-- ============================================
CREATE TABLE IF NOT EXISTS login_attempts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    success BOOLEAN NOT NULL,
    failure_reason VARCHAR(100),
    user_agent TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);
CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_sessions_expires_at ON sessions(expires_at);
CREATE INDEX IF NOT EXISTS idx_sessions_revoked ON sessions(revoked) WHERE NOT revoked;
CREATE INDEX IF NOT EXISTS idx_password_reset_user_id ON password_reset_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_password_reset_expires ON password_reset_tokens(expires_at) WHERE NOT used;
CREATE INDEX IF NOT EXISTS idx_email_verification_user_id ON email_verification_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_login_attempts_email ON login_attempts(email);
CREATE INDEX IF NOT EXISTS idx_login_attempts_ip ON login_attempts(ip_address);
CREATE INDEX IF NOT EXISTS idx_login_attempts_created ON login_attempts(created_at);

-- ============================================
-- TRIGGERS FOR UPDATED_AT
-- ============================================

-- Update users.updated_at on UPDATE
CREATE TRIGGER update_users_updated_at 
    BEFORE UPDATE ON users 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Update user_profiles.updated_at on UPDATE
CREATE TRIGGER update_user_profiles_updated_at 
    BEFORE UPDATE ON user_profiles 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Update sessions.last_accessed on any access
CREATE OR REPLACE FUNCTION update_session_last_accessed()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_accessed = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_sessions_last_accessed 
    BEFORE UPDATE ON sessions 
    FOR EACH ROW EXECUTE FUNCTION update_session_last_accessed();

-- ============================================
-- VIEWS FOR CONVENIENCE
-- ============================================

-- Active sessions view
CREATE OR REPLACE VIEW active_sessions AS
SELECT 
    s.session_id,
    s.user_id,
    u.email,
    u.name,
    s.device_info,
    s.ip_address,
    s.created_at,
    s.last_accessed,
    s.expires_at
FROM sessions s
JOIN users u ON s.user_id = u.id
WHERE s.revoked = FALSE 
  AND s.expires_at > NOW();

-- User statistics view
CREATE OR REPLACE VIEW user_statistics AS
SELECT 
    u.id,
    u.email,
    u.name,
    u.role,
    u.subscription_tier,
    u.created_at,
    u.last_login,
    COUNT(DISTINCT s.session_id) as active_sessions,
    (SELECT COUNT(*) FROM login_attempts WHERE email = u.email AND success = TRUE) as successful_logins,
    (SELECT COUNT(*) FROM login_attempts WHERE email = u.email AND success = FALSE) as failed_logins
FROM users u
LEFT JOIN sessions s ON u.id = s.user_id AND s.revoked = FALSE AND s.expires_at > NOW()
GROUP BY u.id;

-- ============================================
-- FUNCTIONS FOR COMMON OPERATIONS
-- ============================================

-- Function to clean expired sessions
CREATE OR REPLACE FUNCTION clean_expired_sessions()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM sessions WHERE expires_at < NOW() AND NOT revoked;
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- Function to clean expired tokens
CREATE OR REPLACE FUNCTION clean_expired_tokens()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
    reset_count INTEGER;
    verify_count INTEGER;
BEGIN
    DELETE FROM password_reset_tokens WHERE expires_at < NOW() AND NOT used;
    GET DIAGNOSTICS reset_count = ROW_COUNT;
    
    DELETE FROM email_verification_tokens WHERE expires_at < NOW() AND NOT used;
    GET DIAGNOSTICS verify_count = ROW_COUNT;
    
    deleted_count := reset_count + verify_count;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- Function to revoke all user sessions (useful for logout from all devices)
CREATE OR REPLACE FUNCTION revoke_all_user_sessions(p_user_id UUID)
RETURNS INTEGER AS $$
DECLARE
    revoked_count INTEGER;
BEGIN
    UPDATE sessions 
    SET revoked = TRUE, revoked_at = NOW()
    WHERE user_id = p_user_id AND NOT revoked;
    
    GET DIAGNOSTICS revoked_count = ROW_COUNT;
    RETURN revoked_count;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- COMMENTS FOR DOCUMENTATION
-- ============================================
COMMENT ON TABLE users IS 'Core user accounts with authentication credentials';
COMMENT ON TABLE sessions IS 'Active user sessions with refresh tokens for JWT authentication';
COMMENT ON TABLE user_profiles IS 'Extended user profile information and preferences';
COMMENT ON TABLE password_reset_tokens IS 'One-time tokens for password reset flows';
COMMENT ON TABLE email_verification_tokens IS 'One-time tokens for email verification';
COMMENT ON TABLE login_attempts IS 'Security audit log of all login attempts';

COMMENT ON COLUMN users.password_hash IS 'bcrypt hashed password';
COMMENT ON COLUMN users.email_verified IS 'Whether user has verified their email address';
COMMENT ON COLUMN users.subscription_tier IS 'User subscription level: free, pro, enterprise';
COMMENT ON COLUMN sessions.refresh_token_hash IS 'bcrypt hashed refresh token for secure storage';
COMMENT ON COLUMN sessions.revoked IS 'Whether this session has been revoked (logged out)';

-- ============================================
-- INITIAL DATA (Optional - for development)
-- ============================================

-- Example: Create a test user (password: "password123")
-- Password hash generated using bcrypt with cost factor 12
INSERT INTO users (email, password_hash, name, email_verified) VALUES
('test@ilaunching.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5LS2LhQY9m1em', 'Test User', TRUE)
ON CONFLICT (email) DO NOTHING;

-- ============================================
-- GRANTS (Adjust based on your database user)
-- ============================================
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO your_db_user;
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO your_db_user;
-- GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO your_db_user;
