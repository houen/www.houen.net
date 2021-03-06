#!/usr/bin/env bash

# _bin/doctoc.sh
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
rsync --recursive --delete _bin/on_rpi_server rpi.houen.net:/home/houen/www.houen.net/bin
rsync --recursive --delete _site/ rpi.houen.net:/home/houen/www.houen.net/site/
ssh rpi.houen.net "docker stop www_houen_net"
ssh rpi.houen.net "docker rm www_houen_net"
ssh rpi.houen.net "sh /home/houen/www.houen.net/bin/docker_start.sh"
