// Configuration file for AI Chat - EXAMPLE
// Copy this file to config.js and add your API key

const CONFIG = {
    // Multi-Provider API Configuration
    GODFOREVER_API_KEY: 'your-godforever-api-key-here', // Replace with your GodForever API key
    OPENAI_API_KEY: 'your-openai-api-key-here', // Replace with your OpenAI API key (optional)
    DEFAULT_MODEL: 'gpt-4o-mini',
    GODFOREVER_API_URL: 'https://api.red-pill.ai/v1',
    OPENAI_API_URL: 'https://api.openai.com/v1',
    
    // Chat Configuration
    MAX_TOKENS: 2048,
    TEMPERATURE: 0.7,
    
    // UI Configuration
    AUTO_SAVE_INTERVAL: 30000, // 30 seconds
    MAX_CONVERSATIONS: 50,
    
    // Development settings
    DEBUG_MODE: false,
    LOG_API_CALLS: false
};

// Export for use in main application
if (typeof window !== 'undefined') {
    window.CONFIG = CONFIG;
} 