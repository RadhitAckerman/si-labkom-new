FROM dunglas/frankenphp

WORKDIR /app

# Copy Laravel project
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Generate app key
RUN php artisan key:generate --force

# Set permissions
RUN chmod -R 777 storage bootstrap/cache

# Expose port
EXPOSE 8080

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
