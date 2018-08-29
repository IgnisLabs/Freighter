FROM php:7.2-fpm

ARG uid=1000

#-------------------------------------------------
# Install Composer
#-------------------------------------------------

RUN apt-get update && apt-get install -y wget
COPY ./composer-installer.sh /var
RUN sh /var/composer-installer.sh

#-------------------------------------------------
# Install PHP libraries and extensions
#-------------------------------------------------

RUN apt-get update && apt-get install -qq git git-core curl \
    libz-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    zip \
    unzip

# Install PDO MySQL driver
RUN docker-php-ext-install pdo_mysql

# Configure and install GD
RUN docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 \
    && docker-php-ext-install gd

#-------------------------------------------------
# Final touches
#-------------------------------------------------

# Fix psysh issue for artisan tinker to work
RUN mkdir -p /var/www/.config/psysh && chown -R www-data:www-data /var/www/.config

# Initialize composer dirs
RUN mkdir -p /var/www/.composer && chown -R www-data:www-data /var/www/.composer

# Make sure www-data user id matches the host
RUN usermod -u $uid www-data

CMD ["php-fpm", "--nodaemonize"]
