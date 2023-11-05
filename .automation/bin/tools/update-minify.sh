#!/usr/bin/env bash

# Source init.
#
if [[ -f ./.automation/bin/common-init.sh ]]; then
	source ./.automation/bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Get local version.
#
if [[ -f ./.automation/var/state/minify-version ]]; then
	LOCAL_VERSION="$(cat ./.automation/var/state/minify-version)"
else
	LOCAL_VERSION="XXX"
fi

# Get remote version.
#
REMOTE_VERSION="$(curl -L -s https://api.github.com/repos/tdewolff/minify/releases/latest | jq . | grep tag_name | sed -e 's/^\s*"tag_name":\s*"v\(.\+\)",\?/\1/')"

# Install/update if there is a new version.
#
if [[ "$LOCAL_VERSION" != "$REMOTE_VERSION" ]]; then
	mkdir -p ./.automation/bin/third-party/minify
	(
		cd ./.automation/bin/third-party/minify

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

		mkdir -p ../../../var/state
		echo "$REMOTE_VERSION" > ../../../var/state/minify-version
	)
else
	echo "Minify is already at v${REMOTE_VERSION}"
fi
