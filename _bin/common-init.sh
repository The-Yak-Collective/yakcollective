#!/usr/bin/env bash

# Check to make sure that we're running in the repository root.
#
if [[ ! -f _config.yml ]] || [[ ! -d _bin ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Only run init if necessary.
#
if [[ ! -f .common-init ]]; then

	# Install pre-requisits.
	#
	if [[ -z "$(which curl)" ]]; then
		if [[ -n "$(which brew)" ]]; then
			brew install curl
		elif [[ -n "$(which apt)" ]]; then
			sudo apt install -y curl
		elif [[ -n "$(which yum)" ]]; then
			sudo yum install -y curl
		else
			echo "curl is not found and is not installable! Bailing..."
			exit 1
		fi
	fi

	if [[ -z "$(which jq)" ]]; then
		if [[ -n "$(which brew)" ]]; then
			brew install jq
		elif [[ -n "$(which apt)" ]]; then
			sudo apt install -y jq
		elif [[ -n "$(which yum)" ]]; then
			sudo yum install -y jq
		else
			echo "jq is not found and is not installable! Bailing..."
			exit 1
		fi
	fi

	if [[ -z "$(which gm)" ]]; then
		if [[ -n "$(which brew)" ]]; then
			brew install graphicsmagick
		elif [[ -n "$(which apt)" ]]; then
			sudo apt install -y graphicsmagick
		elif [[ -n "$(which yum)" ]]; then
			sudo yum install -y GraphicsMagick
		else
			echo "Graphics Magick is not found and is not installable! Bailing..."
			exit 1
		fi
	fi

	if [[ -z "$(which cwebp)" ]]; then
		if [[ -n "$(which brew)" ]]; then
			brew install webp
		elif [[ -n "$(which apt)" ]]; then
			sudo apt install -y webp
		elif [[ -n "$(which yum)" ]]; then
			sudo yum install -y libwebp-tools
		else
			echo "The webp tools are not found and is not installable! Bailing..."
			exit 1
		fi
	fi

	if [[ -z "$(which gem)" ]]; then
		if [[ -n "$(which brew)" ]]; then
			brew install ruby
		elif [[ -n "$(which apt)" ]]; then
			sudo apt install -y ruby
		elif [[ -n "$(which yum)" ]]; then
			sudo yum install -y ruby
		else
			echo "Ruby is not found and is not installable! Bailing..."
			exit 1
		fi
	fi
	[[ -z "$(which bundle)" ]] && gem install bundler
	bundle config set path vendor/bundle
	bundle install

	if [[ -z "$(which npm)" ]]; then
		if [[ -n "$(which brew)" ]]; then
			brew install node
		elif [[ -n "$(which apt)" ]]; then
			sudo apt install -y nodejs npm
		elif [[ -n "$(which yum)" ]]; then
			sudo yum install -y nodejs npm
		else
			echo "NodeJS is not found and is not installable! Bailing..."
			exit 1
		fi
	fi
	npm install

	# Pull Knack data.
	#
	chmod +x _bin/knack-pull-yaks.sh
	./_bin/knack-pull-yaks.sh

	# Script run indicator.
	#
	date "+%s" > .common-init
fi
