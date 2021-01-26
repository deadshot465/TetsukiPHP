FROM php:8.0-fpm

ARG WWWGROUP
ARG USER
ARG UID

WORKDIR /var/www

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

# Install system dependencies and clear cache
# Then install PHP extensions
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Get latest composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.0

# Create system user for running Composer and Artisan commands.
RUN useradd -G www-data,root -u $UID -d /home/$USER $USER && \
    mkdir -p /home/$USER/.composer && \
    chown -R $USER:$USER /home/$USER

# EXPOSE 17899

COPY . /var/www
RUN mkdir -p /var/www/vendor && \
    composer install && \
    chown -R $USER:$USER /var/www

USER $USER
