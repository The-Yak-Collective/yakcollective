# https://jekyllrb.com/docs/step-by-step/01-setup/#installation
source "https://rubygems.org"
gem "jekyll"

# Temporary fix? The jekyll gem depends on the jekyll-sass-converter
# gem. Unfortunately, the update from 2.2.0 -> 3.0.0 breaks both the use
# and install of this gem on Alpine (and other musl-libc) distros (used
# on GitHub, Fleek, Netlify, etc.).
#
# https://github.com/jekyll/jekyll-sass-converter/issues/145#issuecomment-1363069829
# https://github.com/sass/dart-sass-embedded/issues?q=is%3Aissue+alpine
# https://github.com/dart-lang/sdk/issues/40906
gem 'jekyll-sass-converter', '~> 2.2'

# https://github.com/jekyll/jekyll/issues/8523#issue-774747339
gem "webrick"

# https://github.com/benbalter/jekyll-titles-from-headings
gem "jekyll-titles-from-headings"

# https://github.com/avillafiorita/jekyll-datapage_gen
gem "jekyll-datapage-generator"
