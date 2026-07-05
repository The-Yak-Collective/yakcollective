#!/usr/bin/env bash

set -e

# Make sure npm and gawk are available.
#
if [[ -z "$(which npm 2> /dev/null)" ]]; then
	echo "Could not find npm in your system's PATH!"
	exit 1
fi

if [[ -z "$(which gawk 2> /dev/null)" ]]; then
	echo "Could not find gawk in your system's PATH!"
	exit 1
fi

# Try to locate the git directory based on the path of this script.
#
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ ! -d "$SCRIPT_DIR/../.git" ]] || [[ ! -d "$SCRIPT_DIR/overlay" ]] || [[ ! -d "$SCRIPT_DIR/quartz" ]]; then
	echo "Could not locate website git repo!"
	exit 1
fi

# Clean build directory and exit if instructed  to do so
#
if [[ "$1" == "clean" ]]; then
	(
		cd "$SCRIPT_DIR"

		[[ -e build ]] && rm -rf build
		[[ -e www ]] && rm -rf www
	)
	exit
fi

# Set up the build directory.
#
(
	cd "$SCRIPT_DIR"

	mkdir -p build
	cd build

	[[ ! -d src ]] && rm -f src
	if [[ ! -e src ]]; then
		mkdir src
		cd src

		tar -cf - -C ../../../ --exclude='.automation' . | tar -xf -
		rm -rf .git \
		       .github \
		       .gitignore \
		       .obsidian \
		       .trash \
		       .vscode \
		       private \
		       README.md
		find . -type f \( -name '.DS_Store' -o -name '.nomedia' \) -delete
		find . -type f -iname '*.md' -exec gawk -i inplace '{ _ = 0 }; \
		     match($0, /(.*)!\[([^\]]+)\]\(([^:\)]+)\)(.*)/, u) { \
		         _ = 1; \
		         gsub("%20", " ", u[3]); \
		         printf("%s![[%s|%s]]%s\n", u[1], u[3], u[2], u[4]) \
		     }; !_ { print $0 }' "{}" \;
		cd ..
	fi

	[[ ! -d quartz ]] && rm -f quartz
	cp -af ../quartz quartz
	cd quartz
	
	npm install

  cp ../../overlay/quartz.config.yaml ./
	npx quartz plugin install --from-config

	cp -af ../../overlay/* ./
)

# Build the site!
#
(
	cd "$SCRIPT_DIR"

	[[ -e www ]] && rm -rf www
	mkdir -p www

	cd build/quartz
	if [[ "$1" == "serve" ]]; then
		npx quartz build \
		  --directory ../../src \
		  --output ../../www \
		  --serve
	else
		npx quartz build \
		  --directory ../../src \
		  --output ../../www
	fi
	sed -i'' -e 's#href=\&quot;[\./]\+/#href=\&quot;https://www.yakcollective.org/#g;s#src=\&quot;[\./]\+/#src=\&quot;https://www.yakcollective.org/#g;' ../../www/index.xml
)
