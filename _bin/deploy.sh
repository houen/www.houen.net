#!/usr/bin/env bash

set -e

dt=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

_bin/doctoc.sh

git add .
git commit -am "deploy on $dt" || echo "Up-to-date. Nothing to commit"

# git commit -m "update TOC" _pages/work-guide.md

# # TODO: pull work_guide/README.md from Dropbox/GitHub and link
# # TODO: pull and link CV-condensed.md from Dropbox

# INFO:
# https://caddyserver.com/docs/caddyfile/patterns
# https://hub.docker.com/_/caddy
# https://caddyserver.com/docs/caddyfile/directives/rewrite
# https://bobcares.com/blog/auto-restart-docker-containers/2/#:~:text=To%20set%20a%20restart%20policy,docker%20daemon%20would%20restart%20it.
# https://docs.docker.com/engine/reference/run/#restart-policies---restart

jekyll build

# OLD, FOR RPI
# rsync --recursive --delete _bin/on_rpi_server rpi.houen.net:/home/houen/www.houen.net/bin
# rsync --recursive --delete _site/ rpi.houen.net:/home/houen/www.houen.net/site/
# ssh rpi.houen.net "docker stop www_houen_net"
# ssh rpi.houen.net "docker rm www_houen_net"
# ssh rpi.houen.net "sh /home/houen/www.houen.net/bin/docker_start.sh"

# NEW, FOR SIMPLY.COM
echo ""
echo ""
echo "Syncing to simply.com public_html folder. Password: nia"
echo ""
rsync --recursive --delete _site/ houen.net@linux23.unoeuro.com:public_html/
echo ""
echo "[DONE]"
