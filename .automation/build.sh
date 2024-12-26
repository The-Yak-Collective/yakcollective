#!/usr/bin/env bash

set -e

# Make sure yarn and gawk are available.
#
if [[ -z "$(which yarn 2> /dev/null)" ]]; then
	echo "Could not find yarn in your system's PATH!"
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
	)
	exit
fi

# Set up the build directory.
#
(
	cd "$SCRIPT_DIR"

	mkdir --parents build
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

	cp -af ../overlay/* quartz/
	cd quartz
	[[ -e .git ]] && rm -rf .git
	[[ -e package-lock.json ]] && rm -f package-lock.json
	yarn install
)

# Build the site!
#
(
	cd "$SCRIPT_DIR"

	[[ -e www ]] && rm -rf www
	mkdir -p www

	cd build/quartz
	if [[ "$1" == "serve" ]]; then
		yarn run quartz build \
			--directory ../src \
			--output ../../www \
			--serve
	else
		yarn run quartz build \
			--directory ../src \
			--output ../../www

		cd ../../www
		while IFS= read -d '' -r DIR; do
			DIR_NAME="$(basename "$DIR")"
			sed -i'' "s#href=\"\./$DIR_NAME/\.\./\.\./#href=\"./$DIR_NAME/../#g" index.html
		done < <(find . -mindepth 1 -maxdepth 1 -type d -print0)
	fi
)
