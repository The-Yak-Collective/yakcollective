#!/usr/bin/env bash

# Source init.
#
#if [[ -f ./_bin/common-init.sh ]]; then
#	source ./_bin/common-init.sh
#else
#	echo "Init file not found! Are you running from the repository root?"
#	exit 1
#fi

# Get local version.
#
if [[ -f ./_versions/minify ]]; then
	LOCAL_VERSION="$(cat ./_versions/minify)"
else
	LOCAL_VERSION="XXX"
fi

# Get remote version.
#
REMOTE_VERSION="$(curl -L -s https://api.github.com/repos/tdewolff/minify/releases/latest | jq . | grep tag_name | sed -e 's/^\s*"tag_name":\s*"v\(.\+\)",\?/\1/')"

# Install/update if there is a new version.
#
if [[ "$LOCAL_VERSION" != "$REMOTE_VERSION" ]]; then
	mkdir -p ./_bin/minify
	(
		cd ./_bin/minify

		curl -L -O "https://github.com/tdewolff/minify/releases/download/v${REMOTE_VERSION}/minify_darwin_amd64.tar.gz"
		tar -xzvf minify_darwin_amd64.tar.gz
		mv minify minify-darwin-x86_64

		curl -L -O "https://github.com/tdewolff/minify/releases/download/v${REMOTE_VERSION}/minify_darwin_arm64.tar.gz"
		tar -xzvf minify_darwin_arm64.tar.gz
		mv minify minify-darwin-arm64

		curl -L -O "https://github.com/tdewolff/minify/releases/download/v${REMOTE_VERSION}/minify_linux_amd64.tar.gz"
		tar -xzvf minify_linux_amd64.tar.gz
		mv minify minify-linux-x86_64

		curl -L -O "https://github.com/tdewolff/minify/releases/download/v${REMOTE_VERSION}/minify_linux_arm64.tar.gz"
		tar -xzvf minify_linux_arm64.tar.gz
		mv minify minify-linux-arm64

		rm bash_completion
		rm *.tar.gz

		mkdir -p ../../_versions
		echo "$REMOTE_VERSION" > ../../_versions/minify
	)
else
	echo "Minify is already at v${REMOTE_VERSION}"
fi
