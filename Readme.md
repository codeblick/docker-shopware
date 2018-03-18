[![Docker Pulls](https://img.shields.io/docker/pulls/codeblick/shopware.svg)](https://hub.docker.com/r/codeblick/shopware/)
[![Docker Stars](https://img.shields.io/docker/stars/codeblick/shopware.svg)](https://hub.docker.com/r/codeblick/shopware/)
[![Build Status](https://travis-ci.org/codeblick/docker-shopware.svg?branch=5.4)](https://travis-ci.org/codeblick/docker-shopware)

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
