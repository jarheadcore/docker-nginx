#!/usr/bin/env sh
set -eu

ln -s /data/conf/nginx/framework-configs/${APP_FRAMEWORK}.conf /data/conf/nginx/sites.d/${APP_FRAMEWORK}.conf
