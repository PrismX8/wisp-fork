#!/bin/sh
set -e
: "${PORT:=4000}"
sed "s/__PORT__/${PORT}/g" /app/config.template.toml > /app/config.toml
exec /app/epoxy-server /app/config.toml
