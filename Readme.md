[![Build Status](https://travis-ci.org/codeblick/docker-php.svg?branch=7.1-apache)](https://travis-ci.org/codeblick/docker-php)

# codeblick/shopware

## About

This image is used for shopware plugin development.

## Usage

**Admin:** demo  
**Password:** demo

```shell
shopware:
  image: codeblick/shopware
  volumes:
    - ./MyPlugin:/var/www/html/custom/plugins/MyPlugin
  environment:
    - PLUGIN_NAME=MyPlugin
  links:
    - db
  ports:
    - 8080:80

db:
  image: mysql:5.7
  environment:
    - MYSQL_ROOT_PASSWORD=secret
    - MYSQL_DATABASE=shopware
  ports:
    - 3306:3306
```
