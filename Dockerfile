FROM ubuntu
MAINTAINER neold2028

RUN apt update
RUN apt install apache2 -y
RUN apt install python-software-properties -y
RUN apt install software-properties-common -y
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
RUN apt update && apt upgrade -y
RUN apt install php7.2 php7.2-xml php7.2-mbstring php7.2-mysql php7.2-json php7.2-curl php7.2-cli php7.2-common php7.2-gd libapache2-mod-php7.2 php7.2-zip -y
RUN php --version
RUN apt install curl unzip -y
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chown 755 /usr/local/bin/composer
RUN composer create-project laravel/laravel /var/www/html/laravel
RUN chown -R www-data:www-data /var/www/html/laravel
RUN chmod -R 755 /var/www/html/laravel/storage
RUN systemctl enable apache2

ENTRYPOINT /usr/sbin/apache2ctl -D FOREGROUND
