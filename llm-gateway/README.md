# 🧠 LLM Gateway - Phase 2 Step 5

Production-ready **LLM Gateway service** that provides intelligent AI model routing with caching and cost optimization.

## ✅ **Features Built**
- **Multi-Provider Support**: OpenAI GPT + Anthropic Claude
- **Intelligent Caching**: Redis-backed response caching  
- **Cost Optimization**: Automatic cost tracking per request
- **Health Monitoring**: Production-ready health checks
- **Streaming Support**: Real-time response streaming
- **Model Selection**: Automatic model routing by task type

## 🚀 **Railway Deployment**

### 1. **Deploy to Railway**
1. Railway Dashboard → "New Project"
2. Select GitHub repo → `llm-gateway` folder  
3. Railway auto-detects Dockerfile

### 2. **Required Environment Variables**
```bash
# Core Infrastructure
REDIS_URL=redis://default:password@host:6379

# AI Provider API Keys (configure any/all):
OPENAI_API_KEY=sk-proj-your_key_here
ANTHROPIC_API_KEY=sk-ant-your_key_here
GOOGLE_API_KEY=your_google_api_key_here
DEEPSEEK_API_KEY=sk-your_deepseek_key_here
```

### 3. **Get API Keys**
- **OpenAI**: https://platform.openai.com/api-keys
- **Anthropic**: https://console.anthropic.com/
- **Google**: https://aistudio.google.com/app/apikey
- **DeepSeek**: https://platform.deepseek.com/api_keys

## 📊 **Available Models (12 Total)**

### **Ultra-Budget Tier**
| Model | Provider | Cost/1K tokens | Best For |
|-------|----------|----------------|----------|
| `gemini-1.5-flash-8b` | Google | $0.0000375 | Cheapest option |
| `deepseek-chat` | DeepSeek | $0.00014 | General chat |
| `deepseek-coder` | DeepSeek | $0.00014 | **Coding tasks** |

### **Budget Tier**  
| Model | Provider | Cost/1K tokens | Best For |
|-------|----------|----------------|----------|
| `gemini-1.5-flash` | Google | $0.000075 | **Fastest responses** |
| `gpt-4o-mini` | OpenAI | $0.00015 | **Default choice** |
| `claude-3-haiku` | Anthropic | $0.00025 | Quick analysis |

### **Standard Tier**
| Model | Provider | Cost/1K tokens | Best For |
|-------|----------|----------------|----------|
| `claude-3-5-haiku` | Anthropic | $0.001 | Balanced quality |
| `gemini-1.5-pro` | Google | $0.0035 | Advanced reasoning |
| `gpt-4-turbo` | OpenAI | $0.01 | Complex tasks |

### **Premium Tier**
| Model | Provider | Cost/1K tokens | Best For |
|-------|----------|----------------|----------|
| `claude-3-5-sonnet` | Anthropic | $0.015 | **Best quality** |
| `gpt-4o` | OpenAI | $0.03 | Premium analysis |

### **Smart Selection**
- **Auto-selects optimal model** based on task type
- **Fallback logic** if preferred provider unavailable
- **Cost optimization** - starts with cheapest suitable model

## 🧪 **Test Endpoints**
```bash
# Health check
curl https://your-gateway.railway.app/health

# Generate completion
curl -X POST https://your-gateway.railway.app/generate \
  -H "Content-Type: application/json" \
  -d '{"messages":[{"role":"user","content":"Hello!"}],"model":"gpt-4o-mini"}'
```

## 🎯 **Ready for Integration**
Deploy this service and we'll connect it to your main API server for complete AI pipeline! 🚀