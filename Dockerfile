FROM php:8.4-apache

RUN apt-get update && apt-get install -y \
    git zip unzip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . .

COPY docker/apache/site.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

EXPOSE 80
