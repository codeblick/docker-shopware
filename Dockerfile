FROM codeblick/php:7.1-apache

ENV SHOPWARE_VCS_BRANCH=5.4

ENV SHOPWARE_DB_USER=root
ENV SHOPWARE_DB_PASSWORD=secret
ENV SHOPWARE_DB_NAME=shopware
ENV SHOPWARE_DB_HOST=db
ENV SHOPWARE_DB_PORT=3306

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
    git clone --depth 1 -b ${SHOPWARE_VCS_BRANCH} https://github.com/shopware/shopware.git /var/www/html/ && \
    composer install && \
    wget -O test_images.zip http://releases.s3.shopware.com/test_images.zip && \
    unzip test_images.zip && \
    rm test_images.zip

COPY ./assets/config.php /var/www/html/config.php
COPY ./assets/shopware.sql /shopware.sql
COPY ./assets/setup.sh /setup.sh

RUN chmod -R 777 /var/www/html && \
    chmod +x /setup.sh && \
    rm -r recovery

CMD ["/setup.sh"]
