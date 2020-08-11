FROM php:7.3-fpm
RUN apt-get update && apt-get install -y \
   libfreetype6-dev \
   libjpeg62-turbo-dev \
   libpng-dev \
   git \
   ssh \
   libcurl3-dev \
   make \
   curl \
   wget \
   bzip2 \
   locales \
   libpq-dev \
   libicu-dev \
   libcurl4-openssl-dev \
   default-mysql-client \
   supervisor \
   libssl-dev \
   libxpm-dev \
   zlib1g-dev \
   libbz2-dev \
   beanstalkd \
   openconnect \
   libsnmp-dev \
   libkrb5-dev \
   libgmp3-dev \
   libtidy-dev \
   libxml2-dev \
   freetds-dev \
   libxslt1-dev \
   libpspell-dev \
   libmcrypt-dev \
   libenchant-dev \
   libc-client-dev \
   build-essential \
   bash-completion \
   libmemcached-dev \
   libfreetype6-dev \
   libjpeg62-turbo-dev \
   apt-transport-https \
   ca-certificates \
   libzip-dev \
   xvfb \
   postgresql-client \
   --no-install-recommends

RUN pecl install memcached apcu xdebug mongodb \
   && docker-php-ext-enable memcached  xdebug mongodb

#LIBS
RUN docker-php-ext-install opcache \
bcmath \
bz2 \
mbstring \
-j$(nproc) iconv \
-j$(nproc) gd \
intl \
tokenizer \
pdo_mysql \
pdo_pgsql \
xmlrpc \
soap \
mysqli \
pdo \
xml \
pcntl \
zip
### INSTALL COMPOSER
  RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  RUN php composer-setup.php
  RUN php -r "unlink('composer-setup.php');"
  RUN mv composer.phar /usr/local/bin/composer

###install node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN usermod -u 1000 www-data
USER www-data
WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm"]
