# Dockerfile for ECS production deployment 🚀
FROM ubuntu:21.04

LABEL maintainer="TVQ"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Ho_Chi_Minh

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG PHP_VERSION=8.0
ENV PHP_VERSION ${PHP_VERSION}

ARG PATH_DOCKER_ECS="./docker/ecs/.docker"
ENV PATH_DOCKER_ECS ${PATH_DOCKER_ECS}

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y software-properties-common && \
  LC_ALL=C.UTF-8 add-apt-repository -y -u ppa:ondrej/php && \
  apt-get install -y \
  php${PHP_VERSION} \
  php${PHP_VERSION}-fpm \
  php${PHP_VERSION}-mysql \
  mcrypt \
  php${PHP_VERSION}-gd \
  php${PHP_VERSION}-xml \
  php${PHP_VERSION}-gmp \
  curl \
  zip \
  php${PHP_VERSION}-zip \
  php${PHP_VERSION}-curl \
  php${PHP_VERSION}-redis \
  php${PHP_VERSION}-mbstring \
  php${PHP_VERSION}-xml \
  php${PHP_VERSION}-opcache \
  php${PHP_VERSION}-bcmath \
  openssl \
  nginx \
  vim \
  supervisor && \
  rm -fr /var/lib/apt/lists/*

RUN /usr/sbin/phpenmod mcrypt

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN rm -f /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/sites-enabled/default
ADD . /var/www/app
ADD ${PATH_DOCKER_ECS}/nginx /etc/nginx

WORKDIR /var/www/app

RUN chown -R www-data:www-data /var/www/app

RUN mkdir /run/php

COPY ${PATH_DOCKER_ECS}/php/laravel.conf /etc/php/${PHP_VERSION}/fpm/pool.d/laravel.conf
COPY ${PATH_DOCKER_ECS}/php/php${PHP_VERSION}.ini /etc/php/${PHP_VERSION}/fpm/php.ini

RUN rm /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN sed -i -e 's/;daemonize = yes/daemonize = no/g' /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

COPY ${PATH_DOCKER_ECS}/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sed -i "s/#PHP_VERSION#/${PHP_VERSION}/g" /etc/supervisor/conf.d/supervisord.conf

RUN chown -R www-data:www-data /var/log/supervisor/ &&\
  chown -R www-data:www-data /etc/nginx/

# Cronjob
COPY ${PATH_DOCKER_ECS}/scheduler.sh /
RUN chmod 755 /scheduler.sh

CMD ["/bin/bash", "./docker/ecs/.docker/entrypoint.sh"]
