FROM php:fpm-alpine

WORKDIR /srv/www

RUN docker-php-ext-install pdo pdo_mysql
