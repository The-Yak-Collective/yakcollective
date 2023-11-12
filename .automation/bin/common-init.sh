#!/usr/bin/env bash

# Check to make sure that we're running in the repository root.
#
if [[ ! -f .automation/etc/skel/_config.yml ]] || [[ ! -d .automation/bin ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Only run init if necessary.
#
if [[ ! -f .automation/var/state/common-init ]]; then

	# Set up cache directory.
	#
	[[ -d .automation/var/cache/build ]] && rm -rf .automation/var/cache/build
	mkdir -p .automation/var/cache/build
	cp -af . .automation/var/cache/build/ 2> /dev/null

	find .automation/var/cache/build -mindepth 1 -type d -iname '.*' -exec rm -rf "{}" \; 2> /dev/null
	find .automation/var/cache/build -mindepth 1 -type f -iname '.*' -exec rm -f "{}" \; 2> /dev/null
	rm -rf .automation/var/cache/build/private

	while IFS= read -d '' -r SKEL_DIR; do
		CACHE_DIR="$(echo "$SKEL_DIR" | sed -e "s#^\.automation/etc/skel#.automation/var/cache/build#")"
		mkdir -p "$CACHE_DIR"
	done < <(find .automation/etc/skel -mindepth 1 -type d -print0)

	while IFS= read -d '' -r SKEL_FILE; do
		CACHE_FILE="$(echo "$SKEL_FILE" | sed -e "s#^\.automation/etc/skel#.automation/var/cache/build#")"
		cp -apf "$SKEL_FILE" "$CACHE_FILE"
	done < <(find .automation/etc/skel -type f -print0)

	(
		cd .automation/var/cache/build

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

		if [[ -z "$(which sqlite3)" ]]; then
			if [[ -n "$(which brew)" ]]; then
				brew install sqlite
			elif [[ -n "$(which apt)" ]]; then
				sudo apt install -y sqlite3
			elif [[ -n "$(which yum)" ]]; then
				sudo yum install -y sqlite3
			else
				echo "The SQLite 3.x is not found and is not installable! Bailing..."
				exit 1
			fi
		fi

		if [[ -z "$(which gem)" ]]; then
			if [[ -n "$(which brew)" ]]; then
				brew install ruby
				if [[ -d /opt/homebrew/opt/ruby/bin ]]; then
					PATH="/opt/homebrew/opt/ruby/bin:$PATH"
				elif [[ -d /usr/local/opt/ruby/bin ]]; then
					PATH="/usr/local/opt/ruby/bin:$PATH"
				fi
			elif [[ -n "$(which apt)" ]]; then
				sudo apt install -y ruby bundler
			elif [[ -n "$(which yum)" ]]; then
				sudo yum install -y ruby rubygem-bundler
			else
				echo "Ruby is not found and is not installable! Bailing..."
				exit 1
			fi
		fi
		[[ -z "$(which bundle)" ]] && sudo gem install bundler
		bundle config set path "$(pwd)/vendor/bundle"
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

		if [[ -z "$(which python3)" ]]; then
			if [[ -n "$(which brew)" ]]; then
				brew install python
			elif [[ -n "$(which apt)" ]]; then
				sudo apt install -y python3
			elif [[ -n "$(which yum)" ]]; then
				sudo yum install -y python3
			else
				echo "Python 3.x is not found and is not installable! Bailing..."
				exit 1
			fi
		fi
		python3 -m venv .
		source bin/activate
		python3 -m pip install --upgrade farcaster
	)

	# Pull Knack data. (But ONLY if we're not being run from
	# knack-pull-yaks.sh, to prevent infinite recursion.)
	#
	if [[ -z "$COMMON_INIT_CALLED_BY_KNACK_YAK_PULL" ]]; then
		chmod +x .automation/bin/knack-pull-yaks.sh
		export KNACK_YAK_PULL_CALLED_BY_COMMON_INIT=1
		./.automation/bin/knack-pull-yaks.sh
		unset KNACK_YAK_PULL_CALLED_BY_COMMON_INIT
	fi

	# Script run indicator.
	#
	date "+%s" > .automation/var/state/common-init
fi
