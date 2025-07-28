#!/bin/bash

# AI Chat Setup Script
echo "🤖 AI Chat - Setup Script"
echo "=========================="

# Check if config.example.js exists
if [ ! -f "config.example.js" ]; then
    echo "❌ Error: config.example.js not found!"
    echo "Please make sure you're in the correct directory."
    exit 1
fi

# Copy config file if it doesn't exist
if [ ! -f "config.js" ]; then
    cp config.example.js config.js
    echo "✅ Created config.js from example"
else
    echo "⚠️  config.js already exists, skipping copy"
fi

# Prompt for API key
echo ""
echo "📝 Please edit config.js and add your GodForever API key."
echo "   Replace 'your-godforever-api-key-here' with your actual API key."
echo ""

# Ask if user wants to open the config file
read -p "🔧 Open config.js for editing? (y/n): " open_config

if [[ $open_config =~ ^[Yy]$ ]]; then
    # Try different editors
    if command -v code >/dev/null 2>&1; then
        code config.js
    elif command -v nano >/dev/null 2>&1; then
        nano config.js
    elif command -v vi >/dev/null 2>&1; then
        vi config.js
    else
        echo "ℹ️  Please open config.js manually in your preferred editor"
    fi
fi

echo ""
echo "🚀 Setup complete! Next steps:"
echo "1. Edit config.js with your API key (if not done already)"
echo "2. Open index.html in your web browser"
echo "3. Start chatting with AI models!"
echo ""
echo "📚 For more information, see README.md" 