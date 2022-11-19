#!/usr/bin/env bash

# Install pre-requisits.
#
[[ -z "$(which bundle)" ]] && gem install bundler

bundle config set path vendor/bundle
bundle install
npm install

# Pull Knack data.
#
chmod +x _bin/knack-pull-yaks.sh
./_bin/knack-pull-yaks.sh

# Script run indicator.
#
date "+%s" > .common-init
