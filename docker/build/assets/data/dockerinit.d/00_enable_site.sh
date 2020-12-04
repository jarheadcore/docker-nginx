#!/usr/bin/env sh
set -eu

echo -n "  Enabling site with '${APP_FRAMEWORK}' framework and upstream '${UPSTREAM_SERVER}'..."
envsubst '${UPSTREAM_SERVER}' < /data/conf/nginx/framework-configs/${APP_FRAMEWORK}.conf > /data/conf/nginx/sites.d/${APP_FRAMEWORK}.conf
echo " done."