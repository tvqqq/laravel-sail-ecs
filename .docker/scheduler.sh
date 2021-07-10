#!/bin/bash

php /var/www/app/artisan schedule:run --verbose --no-interaction >> /dev/null 2>&1
sleep 60
