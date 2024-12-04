#!/bin/bash

# Start PHP 7.4 environment
cd /Users/user/docker-php-env/php74
docker-compose down
# Start PHP 8.0 environment
cd /Users/user/docker-php-env/php81
docker-compose down
docker-compose up -d
# /User/user/project 為專案資料夾