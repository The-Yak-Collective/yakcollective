# Yak Collective Website

![Netlify Status](https://api.netlify.com/api/v1/badges/943ff646-41b6-4b4b-ab86-a891698c72c7/deploy-status)

Every collective needs a website. This is ours. It isn't much to look at, but it gets the job done.

## Building the Website

```bash
# You'll need to set the KNACK_APP_ID, KNACK_API_KEY, and KNACK_OBJECT
# environment variables in order to pull the member list down locally
# (which is needed for the build process). Values for these variables
# can be found in Netlify. NEVER COMMIT THESE VARIABLES TO GIT!
#
export KNACK_APP_ID=XXXXXXXX
export KNACK_API_KEY=YYYYYYYY
export KNACK_OBJECT=ZZZZZZZZ

# Cache member data locally.
#
./_bin/knack-pull-yaks.sh

# OPTIONAL: Set Bundler to only install gems within the build
# directory.
#
bundle config set path vendor/bundle

# Install deps.
#
bundle install

# Serve the site on http://127.0.0.1:4000.
#
bundle exec jekyll serve
```

In general there should be not need to run `_bin/build.sh` unless you're specifically debugging that functionality.

## Ways to Contribute

[Current website issues and projects on GitHub.](https://github.com/The-Yak-Collective/yakcollective/issues) Pull requests and ideas welcome!

Conversations happen on [the Discord #infrastructure channel](https://discord.com/channels/692111190851059762/704369362315772044).
