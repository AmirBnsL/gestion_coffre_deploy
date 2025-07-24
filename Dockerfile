# Use an official PHP image with Node.js installed
FROM php:8.3-apache

# Install system dependencies
RUN apt-get update && \
    apt-get install -y git zip unzip curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs


# Set working directory
WORKDIR /var/www

# Copy backend code
COPY gestion_coffre_backend/ ./backend/

# Copy frontend code
COPY gestion-coffre/ ./frontend/

# Install backend dependencies
WORKDIR /var/www/backend
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-interaction --optimize-autoloader

# Install PHP database drivers
RUN docker-php-ext-install pdo pdo_mysql

# Build frontend
WORKDIR /var/www/frontend
RUN npm install && npm run build

# Move built frontend to backend public directory
RUN cp -r dist/* /var/www/backend/public/

# Set correct permissions for public directory
RUN chown -R www-data:www-data /var/www/backend/public \
    && chmod -R 755 /var/www/backend/public

# Copy wait-for-mysql script
COPY wait-for-mysql.sh /wait-for-mysql.sh
RUN chmod +x /wait-for-mysql.sh

# Set working directory to backend
WORKDIR /var/www/backend

# Expose port 80
EXPOSE 80

# Expose backend and frontend ports
EXPOSE 8000
EXPOSE 5173

# Start both backend and frontend servers, running migrations first
CMD ["/bin/bash", "/wait-for-mysql.sh", "mysql", "3306"]
