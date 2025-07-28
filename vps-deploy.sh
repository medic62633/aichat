#!/bin/bash

# AI Chat VPS Deployment Script
# Run this script on your VPS as root or with sudo

echo "🚀 Starting AI Chat VPS Deployment..."

# Update system
echo "📦 Updating system packages..."
apt update && apt upgrade -y

# Install required packages
echo "📦 Installing nginx, git, and certbot..."
apt install -y nginx git certbot python3-certbot-nginx ufw curl

# Configure firewall
echo "🔒 Configuring firewall..."
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable

# Create web directory
echo "📁 Setting up web directory..."
mkdir -p /var/www/aichat
cd /var/www/aichat

# Clone your repository
echo "📥 Cloning AI Chat repository..."
git clone https://github.com/medic62633/aichat.git .

# Set permissions
echo "🔑 Setting correct permissions..."
chown -R www-data:www-data /var/www/aichat
chmod -R 755 /var/www/aichat

# Create nginx configuration
echo "⚙️ Creating nginx configuration..."
cat > /etc/nginx/sites-available/aichat << 'EOL'
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;  # Replace with your domain
    root /var/www/aichat;
    index index.html index.htm;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied expired no-cache no-store private auth;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss;

    location / {
        try_files $uri $uri/ /index.html;
        
        # Cache static assets
        location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
            expires 1y;
            add_header Cache-Control "public, immutable";
        }
    }

    # Security: block common attack patterns
    location ~ /\. {
        deny all;
    }
    
    location ~* \.(htaccess|htpasswd|ini|log|sh|sql|conf)$ {
        deny all;
    }
}
EOL

# Enable the site
echo "🔗 Enabling nginx site..."
ln -sf /etc/nginx/sites-available/aichat /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test nginx configuration
echo "✅ Testing nginx configuration..."
nginx -t

if [ $? -eq 0 ]; then
    echo "✅ Nginx configuration is valid"
    systemctl restart nginx
    systemctl enable nginx
else
    echo "❌ Nginx configuration has errors. Please check the config."
    exit 1
fi

echo "🎉 AI Chat has been deployed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Point your domain to this server's IP address"
echo "2. Replace 'your-domain.com' in /etc/nginx/sites-available/aichat with your actual domain"
echo "3. Run: sudo nginx -t && sudo systemctl reload nginx"
echo "4. Install SSL certificate: sudo certbot --nginx -d your-domain.com -d www.your-domain.com"
echo ""
echo "🌐 Your site will be available at:"
echo "   http://your-server-ip (immediately)"
echo "   http://your-domain.com (after DNS setup)"
echo ""
echo "📁 App files are located at: /var/www/aichat"
echo "⚙️ Nginx config: /etc/nginx/sites-available/aichat"
echo ""
echo "🔄 To update your app:"
echo "   cd /var/www/aichat && git pull && sudo systemctl reload nginx" 