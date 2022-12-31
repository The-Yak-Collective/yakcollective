---
title: Cardboard Iguana Security is Live!
date: 2022-02-20 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-20-cardboard-iguana-security-is-live.html
author: 100007
---

Up until now there actually hasn’t _been_ a Cardboard Iguana Security website. All of those posts before this one? Just me, writing to myself.

All that changes today though, because Cardboard Iguana Security is (finally) live!

To commemorate the occasion, I thought I’d talk a little bit about what’s going on behind the scenes here.

- [Cardboard Iguana Security](https://cardboard-iguana.com)

# Design Philosophy

I had a number of goals when I set out on this journey.

(1) I wanted to continue to take my notes using Obsidian, and I didn’t want to have to worry about post frontmatter, how to link images, etc. It all needed to _just work_.

(2) I wanted the content to be usable on GitHub, as well as in Obsidian and on the website itself. No broken images, etc. This put significant constraints on how I could structure the site (for example, I never was able to figure out how to use Jekyll’s built-in post functionality without messing up images and internal links _somewhere_).

(3) I wanted to use a single base theme for all three of my websites (since I manage the content of all three using Obsidian).

(4) I wanted to experiment with web3 technologies (specifically IPFS and ENS, which I’ve been studying with the Yak Collective). I also wanted to experiment with the Gemini protocol (I didn’t actually manage to do this, though my content is all Gemini-ready). The use of IPFS put constraints on how I could structure the site (I needed to use relative links to actual HTML documents), while the line-oriented nature of Gemini mean that my source formatting options were very constrained (in particular, md2gmn and other parsers don’t really handle embedded links very well, so I was limited to lists of links and links that occupied a single line).

(5) Finally, I wanted to use a minimal amount of styling and HTML code. How small could I make Cardboard Iguana Security while still looking good?

While some of these constraints (particularly around linking) remain a bit vexing, overall I feel that having these constraints led to a stronger (and, I think, more sustainable) end result than I might otherwise have come up with.

- [Obsidian](https://obsidian.md/)
- [necopinus / cardboard-iguana.com](https://github.com/necopinus/cardboard-iguana.com)
- [Jekyll](https://jekyllrb.com/)
- [Cardboard Iguana Security](https://cardboard-iguana.com)
- [necopinus.xyz](https://necopinus.xyz)
- [Château MaxMin()](https://chateaumaxmin.info)
- [IPFS](https://ipfs.io/)
- [ENS](https://ens.domains/)
- [Blockchain File Storage and Hosting | Nathan Acks](https://www.youtube.com/watch?v=G0-sJB5mbps)
- [The Yak Collective](https://www.yakcollective.org/)
- [Project Gemini Speculative Specification](gemini://gemini.circumlunar.space/docs/specification.gmi)
- [Static-site generators (IPFS Docs)](https://docs.ipfs.io/how-to/websites-on-ipfs/static-site-generators/)
- [tdemin / gmnhg](https://github.com/tdemin/gmnhg)

# How the Build Process Works

I keep all of my notes and writings in Obsidian. I’ve set Obsidian up to insert relative Markdown links and take care to keep my markup limited to what constitutes “Gemini compatible Markdown”. (As I mentioned previously, this isn’t actually that hard to do - the most difficult part is remembering to keep a list of links at the end of each section, rather than embedding links directly in the document text.)

I sync Obsidian to a private repo on GitHub, and then use GitHub Actions to push the folders that correspond to my websites out to their corresponding public repos. For Cardboard Iguana, the code to do this looks like the following:

```
mkdir _repos
cd _repos

git clone https://necopinus:$PERSONAL_ACCESS_TOKEN@github.com/necopinus/cardboard-iguana.com
cd cardboard-iguana.com

git config user.name "GitHub Action"
git config user.email "github.actions@cardboard-iguana.com"

chmod +x .bin/update-website.sh
./.bin/update-website.sh

git add -A -v
git commit -m "Refreshed website content" || true
git push
```

Pushing out to the other two websites is done in a similar fashion.

`update-website.sh` is a simple script that deletes all content from the repo (less a few files specifically used to build the site) and then copies the relevant content into the public repo from the corresponding folder in the private repo.

```
#!/usr/bin/env bash

CWD="$(pwd)"
REPO_DIR="$(basename "$CWD")"
REPO_PARENT_DIR="$(basename "$(dirname "$CWD")")"

if [["$REPO_DIR" == "cardboard-iguana.com"]] && \
   [["$REPO_PARENT_DIR" == "_repos"]] && \
   [[-d ../../cardboard-iguana.com]]; then
	find . -mindepth 1 \
	       -maxdepth 1 \
	       -not -iname '.bin' \
	       -not -iname '.git' \
	       -not -iname '.gitignore' \
	       -not -iname '_config.yml' \
	       -exec rm -rf "{}" \;

	cp -rf ../../cardboard-iguana.com/* .
else
	echo "Unexpected execution directory"
	exit 1
fi
```

Commits into the website public repo trigger a build in Fleek. The build kicks off by calling a stub script in `.bin/build.sh` which clones my custom theme repository, moves relevant files into project root, and then kicks off the actual build process in `_build/html.sh`.

```
#!/usr/bin/env bash

# Check to make sure that we're running in the repository root.
#
if [[! -f _config.yml || ! -d .bin]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Remove old _theme directory, if it exists
#
[[-d _theme]] && rm --recursive --force _theme

# Clone the theme and copy relevant files into the main repository.
#
git clone https://github.com/necopinus/website-theme.git _theme
rm -f _theme/README.md _theme/LICENSE
find _theme -mindepth 1 \
            -maxdepth 1 \
            -not -iname '.*' \
            -exec basename "{}" \; | xargs rm -rf
mv _theme/* .
rm -rf _theme

# Build website.
#
./_build/html.sh
```

`_build/html.sh` makes sure that everything we need is installed, builds the site using Jekyll, and then ensures that all links are relative and files are properly minified.

```
#!/usr/bin/env bash

# Check to make sure that we're running in the repository
# root.
#
if [[! -f _config.yml || ! -d .bin]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Clean destination directory.
#
[[-d _site]] && rm -rf _site

# Build the site using either system Jekyll (assume that
# our environment has installed the necessary gems
# automatically) or via bundler.
#
if [[-n "$(which jekyll)"]]; then
	jekyll build --profile || exit 4
elif [[-n "$(which bundle)"]]; then
	bundle config set path vendor/bundle || exit 8
	bundle install || exit 3
	bundle exec jekyll build --profile || exit 16
else
	echo "Cannot find Bundler, and Jekyll does not seem to be installed."
	exit 32
fi

# Wrap tables in a div in order to make them scrollable
# (without breaking accessibility).
#
find _site -type f \
           -iname '*.html' \
           -exec sed -i -e 's#<table>#<div class="table-wrapper"><table>#g;s#</table>#</table></div>#g' "{}" \;

# Make all URLs relative (required for most web3 hosting
# solutions).
#
npm install
(
	cd _site
	../node_modules/.bin/all-relative
)

# Minify: https://github.com/tdewolff/minify
#
# Current version: 2.9.22 (last checked 2021-11-14)
#
# It's too bad we need to cart this binary around as part
# of the repo, but Fleek doesn't support installing our
# own tools (otherwise we'd just `apt install minify`).
#
chmod +x _build/minify
cp -rf _site _site.original
rm -rf _site/*
(
	cd _site.original
	../_build/minify --all \
	                 --recursive \
	                 --sync \
	                 --output ../_site .
)
rm -rf _site.original
```

Once the site’s built, Fleek pushes files out to IPFS and its own CDN (cardboard-iguana.eth points to the relevant IPNS hash for visitors using IPFS).

- [Obsidian](https://obsidian.md/)
- [dy-sh / obsidian-consistent-attachments-and-links](https://github.com/dy-sh/obsidian-consistent-attachments-and-links)
- [dy-sh / obsidian-unique-attachments](https://github.com/dy-sh/obsidian-unique-attachments)
- [Gemini Compatible Markdown](https://cardboard-iguana.com/notes/gemini-compatible-markdown.html)
- [GitHub Actions](https://github.com/features/actions)
- [cardboard-iguana.com / .bin / update-website.sh](https://github.com/necopinus/cardboard-iguana.com/blob/main/.bin/update-website.sh)
- [Fleek](https://fleek.co/)
- [cardboard-iguana.com / .bin / build.sh](https://github.com/necopinus/cardboard-iguana.com/blob/main/.bin/build.sh)
- [website-theme / \_build / html.sh](https://github.com/necopinus/website-theme/blob/main/_build/html.sh)
- [Jekyll](https://jekyllrb.com/)
- [all-relative](https://www.npmjs.com/package/all-relative)
- [tdewolff / minify](https://github.com/tdewolff/minify)
- [IPFS](https://ipfs.io/)
- [InterPlanetary Name System (IPNS)](https://docs.ipfs.io/concepts/ipns/)

# Where Next?

As I mentioned previously, the above process doesn’t build anything for Gemini. I’d like to add this in at some point, but I’ve yet to find a Gemini host geared toward multiple websites (even sourcehut seems to focus on single, personal websites). I really don’t want to spend the time running my own server, though I’m starting to suspect it may come to that.

I’d like to find a way to handle links that is more Markdown-native will producing sensible output in a Markdown-to-Gemini converter. If such a thing doesn’t exist once I finish the certification sequence I’m currently working on, perhaps I’ll submit a patch for md2gmn.

But for now, I’ve spent _way_ too much time on this. Time to get back to my studies!

- [Project Gemini](gemini://gemini.circumlunar.space/docs/specification.gmi)
- [sourcehut](https://sourcehut.org/)
- [tdemin / gmnhg](https://github.com/tdemin/gmnhg)
