FROM php:fpm-alpine

WORKDIR /srv/www

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN apk add --no-cache icu-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install exif
RUN docker-php-ext-install opcache
RUN docker-php-ext-install -j$(nproc) iconv
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
  docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

RUN echo -e "memory_limit=512M\nupload_max_filesize=8M\npost_max_size=256M\ndate.timezone=Europe/Bratislava" >> /usr/local/etc/php/php.ini
RUN echo -e "nameserver 1.1.1.1\n" > /etc/resolv.conf
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm composer-setup.php
