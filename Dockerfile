FROM php:7.1-cli

RUN echo 'deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list \ 
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch-proposed-updates main non-free contrib' >> /etc/apt/sources.list \    
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib' >> /etc/apt/sources.list \ 
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch-proposed-updates main non-free contrib' >> /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y zip \
    && apt-get install -y unzip \
    && apt-get install -y libpng-dev \
    && apt-get install -y vim

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install opcache
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN mv composer.phar /usr/local/bin/composer
RUN php -r "unlink('composer-setup.php');"
RUN mkdir /app
