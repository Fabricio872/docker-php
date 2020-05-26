# Symfony PHP optimized version

This php container is made on top of [php:fpm-alpine](https://hub.docker.com/_/php)

Contains php bash script for running php commands in container

## php.ini options
 - memory_limit=512M
 - upload_max_filesize=8M
 - post_max_size=256M
 - timezone=Europe/Bratislava

> secondary nameserver is setted to 1.1.1.1 because of raspbian issues

## List of added packages:

 - pdo
 - pdo_mysql
 - intl
 - exif
 - opcache
 - iconv
 - gd
 - composer
