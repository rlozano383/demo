FROM    debian:10

ENV     DEBIAN_FRONTEND noninteractive
RUN     set -eux ; \
        apt update ; \
        apt -y install php-bcmath php-curl php-imagick \
            php-gd php-mbstring php-xml php-zip php-mysql \
            libapache2-mod-php curl unzip ; \
        rm -rf /var/lib/apt/lists/* ; \
        a2enmod rewrite ; \
        a2dismod status

ADD     https://wordpress.org/latest.zip /var/www

RUN     set -eux ; \
        rm -rf /var/www/html ; \
        unzip /var/www/latest.zip -d /var/www ; \
        mv /var/www/wordpress /var/www/html ; \
        chown -R www-data.www-data /var/www/html ; \
        ln -sf /dev/stdout /var/log/apache2/access.log ; \
        ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE  80
ENTRYPOINT [ "/usr/sbin/apachectl", "-D", "FOREGROUND"]
