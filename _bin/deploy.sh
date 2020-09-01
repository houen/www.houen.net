#!/usr/bin/env bash

_bin/doctoc.sh
git commit -m "update TOC" _pages/work-guide.md

# TODO: pull work_guide/README.md from Dropbox/GitHub and link
# TODO: pull and link CV-condensed.md from Dropbox

git push heroku master