FROM codeblick/php:7.1-apache

ENV SHOPWARE_VCS_BRANCH=5.4

ENV SHOPWARE_DB_USER=root
ENV SHOPWARE_DB_PASSWORD=secret
ENV SHOPWARE_DB_NAME=shopware
ENV SHOPWARE_DB_HOST=db
ENV SHOPWARE_DB_PORT=3306

WORKDIR /var/www/shopware

RUN apt-get update -qq && \
    apt-get install -y -qq \
        unzip \
        phpunit \
        wget \
        mysql-client \
        git \
        openjdk-7-jre-headless \
        ant && \
    curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    git clone --depth 1 -b ${SHOPWARE_VCS_BRANCH} https://github.com/shopware/shopware.git /var/www/shopware/ && \
    composer install && \
    wget -q -O test_images.zip http://releases.s3.shopware.com/test_images.zip && \
    unzip -qq test_images.zip && \
    rm test_images.zip

COPY ./assets/config.php /var/www/shopware/config.php
COPY ./assets/shopware.sql /shopware.sql
COPY ./assets/setup.sh /setup.sh

COPY ./assets/ioncube_loader_lin_7.1.so /usr/local/ioncube/
RUN echo "zend_extension=/usr/local/ioncube/ioncube_loader_lin_7.1.so" > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    bash -c "chown -R www-data:www-data /var/www/shopware" && \
    bash -c "chmod +x /setup.sh" && \
    rm -r recovery && \
    sed -i -- "s/\/var\/www\/html/\/var\/www\/shopware/ig" /etc/apache2/sites-enabled/000-default.conf

CMD ["/setup.sh"]
