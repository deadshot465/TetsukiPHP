FROM php:8.0-fpm

ARG WWWGROUP
ARG user
ARG uid

WORKDIR /var/www/html

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Get latest composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.0

# Create system user for running Composer and Artisan commands.
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

EXPOSE 17899

# Set working directory
WORKDIR /var/www

USER $user