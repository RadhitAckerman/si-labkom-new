FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy project
COPY . .

# Install Laravel dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Permissions
RUN chmod -R 777 storage bootstrap/cache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Expose port
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]
