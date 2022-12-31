#!/usr/bin/env bash
#
# Original: from https://github.com/ryuichiueda/TomoTool
# ===============================================================
# The MIT License
#
# Copyright (C) 2013-2015 Ryuichi Ueda
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ===============================================================
#
# See also:
#   https://dev.twitter.com/oauth/overview/authentication-by-api-family
#   https://dev.twitter.com/oauth/overview
#   https://dev.twitter.com/oauth/overview/creating-signatures
#
# If you want to see detailed logs, set an environment variable "DEBUG" to 1 or something.

work_dir="$(pwd)"
tools_dir="$(cd "$(dirname "$0")" && pwd)"

tmp="/tmp/$$"

URL_REDIRECTORS="$(cat << FIN
1drv.ms
amzn.to
bit.ly
boog.io
bugzil.la
g.co
gigaz.in
go.ascii.jp
goo.gl
fb.me
is.gd
kuku.lu
macaf.ee
nico.ms
nico.sc
num.to
ow.ly
p.tl
prt.nu
r10.to
s.nikkei.com
sdrv.ms
t.asahi.com
t.co
tiny.cc
tinyurl.com
urx.nu
ustre.am
wolfr.am
y2u.be
youtu.be
FIN
)"

log() {
  [ "$DEBUG" = '' ] && return 0
  if [ $# -eq 0 ]
  then
    cat | sanitize_secret_params 1>&2
  else
    echo "$*" | sanitize_secret_params 1>&2
  fi
}

sanitize_secret_params() {
  if [ "$CONSUMER_KEY" = '' ]
  then
    cat
    return 0
  fi
  sed -E -e "s/$CONSUMER_KEY/<***consumer-key***>/g" \
        -e "s/$CONSUMER_SECRET/(***consumer-secret***>/g" \
        -e "s/$ACCESS_TOKEN/<***access-token***>/g" \
        -e "s/$ACCESS_TOKEN_SECRET/<***access-token-secret***>/g"
}

exist_command() {
  type "$1" > /dev/null 2>&1
}

load_keys() {
  if [ "$CONSUMER_KEY" = '' -a \
       -f "$work_dir/tweet.client.key" -a \
       "$work_dir" != "$tools_dir" ]
  then
    log 'Using client key at the current directory. (tweet.client.key)'
    source "$work_dir/tweet.client.key"
  fi

  if [ "$CONSUMER_KEY" = '' -a \
       -f "$work_dir/.tweet.client.key" ]
  then
    log 'Using client key at the current directory. (.tweet.client.key)'
    source "$work_dir/.tweet.client.key"
  fi

  if [ "$CONSUMER_KEY" = '' -a \
       -f ~/.tweet.client.key ]
  then
    log 'Using client key at the home directory. (~/.tweet.client.key)'
    source ~/.tweet.client.key
  fi

  if [ "$CONSUMER_KEY" = '' -a \
       -f "$tools_dir/tweet.client.key" ]
  then
    log 'Using client key at the tools directory. (tweet.client.key in tools)'
    source "$tools_dir/tweet.client.key"
  fi

  export MY_SCREEN_NAME
  export MY_LANGUAGE
  export CONSUMER_KEY
  export CONSUMER_SECRET
  export ACCESS_TOKEN
  export ACCESS_TOKEN_SECRET
}


ensure_available() {
  local fatal_error=0

  load_keys

  if [ "$MY_SCREEN_NAME" = '' ]
  then
    echo 'FATAL ERROR: You need to specify your screen name via an environment variable "MY_SCREEN_NAME".' 1>&2
    fatal_error=1
  fi

  if [ "$MY_LANGUAGE" = '' ]
  then
    echo 'FATAL ERROR: You need to specify your language (like "en") via an environment variable "MY_LANGUAGE".' 1>&2
    fatal_error=1
  fi

  if [ "$CONSUMER_KEY" = '' ]
  then
    echo 'FATAL ERROR: You need to specify a consumer key via an environment variable "CONSUMER_KEY".' 1>&2
    fatal_error=1
  fi

  if [ "$CONSUMER_SECRET" = '' ]
  then
    echo 'FATAL ERROR: You need to specify a consumer secret via an environment variable "CONSUMER_SECRET".' 1>&2
    fatal_error=1
  fi

  if [ "$ACCESS_TOKEN" = '' ]
  then
    echo 'FATAL ERROR: You need to specify an access token via an environment variable "ACCESS_TOKEN".' 1>&2
    fatal_error=1
  fi

  if [ "$ACCESS_TOKEN_SECRET" = '' ]
  then
    echo 'FATAL ERROR: You need to specify an access token secret via an environment variable "ACCESS_TOKEN_SECRET".' 1>&2
    fatal_error=1
  fi

  if ! exist_command nkf
  then
    echo 'FATAL ERROR: A required command "nkf" is missing.' 1>&2
    fatal_error=1
  fi

  if ! exist_command curl
  then
    echo 'FATAL ERROR: A required command "curl" is missing.' 1>&2
    fatal_error=1
  fi

  if ! exist_command openssl
  then
    echo 'FATAL ERROR: A required command "openssl" is missing.' 1>&2
    fatal_error=1
  fi

  if ! exist_command jq
  then
    echo 'FATAL ERROR: A required command "jq" is missing.' 1>&2
    fatal_error=1
  fi

  [ $fatal_error = 1 ] && exit 1
}


#================================================================
# sub commands

help() {
  local command="$1"
  shift

  case "$command" in
    '' )
      cat << FIN
Usage:
  ./tweet.sh [command] [...arguments]

Available commands:
  fetch(get, show)
                 : fetches a JSON string of a tweet.
  search         : searches tweets.
  fetch-favorites(fetch-fav)
                 : fetches favorite tweets.
  fetch-tweets(fetch-posts)
                 : fetches tweets of a user.
  watch-mentions(watch)
                 : [OBSOLETE] watches mentions, retweets, DMs, etc.
  type           : detects the type of the given input.
  body           : extracts the body of a tweet.
  owner          : extracts the owner of a tweet.
  get-list-members
                 : gets a list's member information.
  showme         : reports the raw information of yourself.
  whoami         : reports the screen name of yourself.
  rename         : updates your display name.
  language(lang) : reports the selected language of yourself.

  post(tweet, tw): posts a new tweet.
  reply          : replies to a tweet.
  upload         : upload a media file.
  delete(del, remove, rm)
                 : deletes a tweet.
  favorite(fav)  : marks a tweet as a favorite.
  unfavorite(unfav)
                 : removes favorited flag of a tweet.
  retweet(rt)    : retweets a tweet.
  unretweet(unrt): deletes the retweet of a tweet.
  follow         : follows a user.
  unfollow       : unfollows a user.

  fetch-direct-messages(fetch-dm, get-direct-messages, get-dm)
                 : fetches recent DMs.
  direct-message(dm)
                 : sends a DM.
  delete-direct-message(delete-dm, del-dm)
                 : deletes a DM.

  get-user-id    : resolves a screen name string to a user ID integer.
  get-screen-name: resolves a user id integer to a screen name string.

  resolve        : resolves a shortened URL like "https://t.co/xxxx"
  resolve-all    : resolves all shortened URLs in the given input.

For more details, see also: "./tweet.sh help [command]"
FIN
      ;;

    fetch|get|show )
      cat << FIN
Usage:
  ./tweet.sh fetch 012345
  ./tweet.sh fetch https://twitter.com/username/status/012345
  ./tweet.sh get 012345
  ./tweet.sh show 012345
FIN
      ;;
    search )
      cat << FIN
Usage:
  ./tweet.sh search -q "queries" -c 10
  ./tweet.sh search -q "Bash OR Shell Script" -s 0123456
  ./tweet.sh search -q "queries" -h "echo 'found!'; cat"
  ./tweet.sh search -q "Bash OR Shell Script" -w |
    while read -r tweet; do echo "found!: \${tweet}"; done
FIN
      ;;
    fetch-fav|fetch-favorites )
      cat << FIN
Usage:
  ./tweet.sh fetch-fav -c 10
  ./tweet.sh fetch-favorites -c 100 -s 0123456
FIN
      ;;
    fetch-tweet*|fetch-post* )
      cat << FIN
Usage:
  ./tweet.sh fetch-tweets -u screen_name -c 10
  ./tweet.sh fetch-posts -u screen_name -c 100 -s 0123456
  ./tweet.sh fetch-tweets -u screen_name -c 3 -f
  (-f returns the full tweet text ie. not truncated - tweet_mode=extended)
FIN
      ;;
    watch|watch-mentions )
      cat << FIN
Usage:
  ./tweet.sh watch-mentions -k keyword1,keyword2 |
    while read -r event; do ... done
  ./tweet.sh watch-mentions -k keyword1,keyword2
                            -m "echo 'MENTION'; cat"
                            -r "echo 'RT'; cat"
                            -q "echo 'QT'; cat"
                            -f "echo 'FOLLOWED'; cat"
                            -d "echo 'DM'; cat"
                            -s "echo 'SEARCH-RESULT'; cat"
FIN
      ;;
    type )
      cat << FIN
Usage:
  echo "\$tweet_json" | ./tweet.sh type -k keyword1,keyword2
FIN
      ;;
    body )
      cat << FIN
Usage:
  ./tweet.sh body 012345
  ./tweet.sh body https://twitter.com/username/status/012345
  echo "\$tweet_json" | ./tweet.sh body
FIN
      ;;
    owner )
      cat << FIN
Usage:
  ./tweet.sh owner 012345
  ./tweet.sh owner https://twitter.com/username/status/012345
  echo "\$tweet_json" | ./tweet.sh owner
FIN
      ;;
    get-list-members )
      cat << FIN
Usage:
  ./tweet.sh get-list-members 012345
  ./tweet.sh get-list-members https://twitter.com/i/lists/012345
FIN
      ;;
    showme )
      cat << FIN
Usage:
  ./tweet.sh showme
FIN
      ;;
    whoami )
      cat << FIN
Usage:
  ./tweet.sh whoami
FIN
      ;;
    rename )
      cat << FIN
Usage:
  ./tweet.sh rename New Name, Same Me
FIN
      ;;
    lang|language )
      cat << FIN
Usage:
  ./tweet.sh lang
  ./tweet.sh language
FIN
      ;;

    post|tweet|tw )
      cat << FIN
Usage:
  ./tweet.sh post A tweet from command line
  ./tweet.sh post 何らかのつぶやき
  ./tweet.sh tweet Hello
  ./tweet.sh tw Hi
  ./tweet.sh post -l A tweet with location
  ./tweet.sh post -i /path/to/image.jpg -i /path/to/image.png tweet with images
  ./tweet.sh post -m media_key1,media_key2 tweet with media (old form)
  cat body.txt | ./tweet.sh post
FIN
      ;;
    reply )
      cat << FIN
Usage:
  ./tweet.sh reply 012345 a reply
  ./tweet.sh reply https://twitter.com/username/status/012345 a reply
  ./tweet.sh reply -i /path/to/image.jpg 012345 a reply with an image
  ./tweet.sh reply -m media_key1 012345 a reply with a media (old form)
  cat body.txt | ./tweet.sh reply 012345
FIN
      ;;
    upload )
      cat << FIN
Usage:
  ./tweet.sh upload /path/to/file.png
FIN
      ;;
    del|delete|rm|remove )
      cat << FIN
Usage:
  ./tweet.sh del 012345
  ./tweet.sh delete https://twitter.com/username/status/012345
  ./tweet.sh rm 012345
  ./tweet.sh remove https://twitter.com/username/status/012345
FIN
      ;;
    fav|favorite )
      cat << FIN
Usage:
  ./tweet.sh fav 012345
  ./tweet.sh fav https://twitter.com/username/status/012345
  ./tweet.sh favorite 012345
  ./tweet.sh favorite https://twitter.com/username/status/012345
FIN
      ;;
    unfav|unfavorite )
      cat << FIN
Usage:
  ./tweet.sh unfav 012345
  ./tweet.sh unfav https://twitter.com/username/status/012345
  ./tweet.sh unfavorite 012345
  ./tweet.sh unfavorite https://twitter.com/username/status/012345
FIN
      ;;
    rt|retweet )
      cat << FIN
Usage:
  ./tweet.sh rt 012345
  ./tweet.sh rt https://twitter.com/username/status/012345
  ./tweet.sh retweet 012345
  ./tweet.sh retweet https://twitter.com/username/status/012345
FIN
      ;;
    unrt|unretweet )
      cat << FIN
Usage:
  ./tweet.sh unrt 012345
  ./tweet.sh unrt https://twitter.com/username/status/012345
  ./tweet.sh unretweet 012345
  ./tweet.sh unretweet https://twitter.com/username/status/012345
FIN
      ;;
    follow )
      cat << FIN
Usage:
  ./tweet.sh follow username
  ./tweet.sh follow @username
  ./tweet.sh follow https://twitter.com/username/status/012345
FIN
      ;;
    unfollow )
      cat << FIN
Usage:
  ./tweet.sh unfollow username
  ./tweet.sh unfollow @username
  ./tweet.sh unfollow https://twitter.com/username/status/012345
FIN
      ;;

    fetch-dm|fetch-direct-messages|get-dm|get-direct-messages )
      cat << FIN
Usage:
  ./tweet.sh fetch-dm -c 10
  ./tweet.sh get-dm -c 10
FIN
      ;;
    dm|direct-message )
      cat << FIN
Usage:
  ./tweet.sh dm frinedname Good morning.
  ./tweet.sh direct-message frinedname "How are you?"
  cat body.txt | ./tweet.sh direct-message frinedname
FIN
      ;;
    del-dm|delete-dm|del-direct-message|delete-direct-message )
      cat << FIN
Usage:
  ./tweet.sh delete-direct-message 012345
  ./tweet.sh delete-dm 012345
  ./tweet.sh del-dm 012345
FIN
      ;;
    get-user-id )
      cat << FIN
Usage:
  ./tweet.sh get-user-id examplescreenname
FIN
      ;;
    get-screen-name )
      cat << FIN
Usage:
  ./tweet.sh get-screen-name 0000000000
FIN
      ;;
    resolve )
      cat << FIN
Usage:
  ./tweet.sh resolve https://t.co/xxxx
FIN
      ;;
    resolve-all )
      cat << FIN
Usage:
  cat ./tweet-body.txt | ./tweet.sh resolve-all
FIN
      ;;
  esac
}

check_errors() {
  if echo "$1" | grep '^\[' > /dev/null
  then
    return 0
  fi
  if [ "$(echo "$1" | jq -r '.errors | length')" = '0' ]
  then
    return 0
  else
    return 1
  fi
}


fetch() {
  ensure_available

  local target="$1"
  shift
  if [ "$target" = '' ]; then
    echo "Error: no tweet specified to fetch. (please use \"fetch-tweets\" if you want to fetch a list of tweets.)" 1>&2
    exit 1
  fi

  local id="$(echo "$target" | extract_tweet_id)"
  local params="$(cat << FIN
id $id
FIN
  )"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/statuses/show.json)"
  echo "$result"
  check_errors "$result"
}

get_list_members() {
  ensure_available

  local target="$1"
  shift
  local id="$(echo "$target" | extract_list_id)"
  local params="$(cat << FIN
list_id $id
count 5000
FIN
  )"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/lists/members.json)"
  echo "$result"
  check_errors "$result"
}

fetch_with_my_retweet() {
  ensure_available

  local target="$1"
  shift
  if [ "$target" = '' ]; then
    echo "Error: no tweet specified to fetch." 1>&2
    exit 1
  fi

  local id="$(echo "$target" | extract_tweet_id)"
  local params="$(cat << FIN
id $id
include_my_retweet true
FIN
  )"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/statuses/show.json)"
  echo "$result"
  check_errors "$result"
}

search() {
  ensure_available
  local locale='en'
  local count=10
  local since_id=''
  local max_id=''
  local result_type=recent
  local handler=''
  local watch=0

  local OPTIND OPTARG OPT
  while getopts q:l:c:s:m:t:h:w OPT
  do
    case $OPT in
      q )
        query="$(echo $OPTARG | sed -E -e 's/"/\\"/g')"
        ;;
      c )
        count="$OPTARG"
        ;;
      s )
        since_id="$(echo "$OPTARG" | extract_tweet_id)"
        [ "$since_id" != '' ] && since_id="since_id $since_id"
        ;;
      m )
        max_id="$(echo "$OPTARG" | extract_tweet_id)"
        [ "$max_id" != '' ] && max_id="max_id $max_id"
        ;;
      t )
        result_type="$OPTARG"
        ;;
      h )
        handler="$OPTARG"
        ;;
      w )
        watch=1
        ;;
    esac
  done

  [ "$MY_LANGUAGE" = 'ja' ] && locale='ja'

  if [ "$handler" = '' -a $watch = 0 ]
  then
    local params="$(cat << FIN
q $query
lang $MY_LANGUAGE
locale $locale
result_type $result_type
count $count
$since_id
$max_id
FIN
    )"
    local result="$(echo "$params" |
                      call_api GET https://api.twitter.com/1.1/search/tweets.json)"
    echo "$result"
    check_errors "$result"
  else
    watch_search_results "$query" "$handler"
  fi
}

watch_search_results() {
  local query="$1"
  local handler="$2"
  local user_screen_name="$(self_screen_name)"
  local params
  if [ "$query" = '' ]
  then
    echo "Tracking sample tweets..." 1>&2
    call_api GET https://stream.twitter.com/1.1/statuses/sample.json |
      handle_search_results "$user_screen_name" "$handler"
  else
    echo "Tracking tweets with the query: $query..." 1>&2
    params="$(cat << FIN
track $query
FIN
    )"
    echo "$params" |
      call_api POST https://stream.twitter.com/1.1/statuses/filter.json |
      handle_search_results "$user_screen_name" "$handler"
  fi
}

handle_search_results() {
  local user_screen_name="$1"
  local handler="$2"

  local separator='--------------------------------------------------------------'

  local owner
  while read -r line
  do
    if [ "$line" = 'Exceeded connection limit for user' ]
    then
      echo "$line" 1>&2
      exit 1
    fi

    # Ignore self tweet
    owner="$(echo "$line" | extract_owner)"
    [ "$owner" = "$user_screen_name" \
      -o "$owner" = 'null' \
      -o "$owner" = '' ] && continue

    log "$separator"
    log "TWEET DETECTED: Matched to the given query"

    if [ "$handler" = '' ]
    then
      echo "$line"
    else
      echo "$line" |
        (cd "$work_dir"; eval "$handler")
    fi
  done
}

fetch_favorites() {
  ensure_available
  local count=10
  local since_id=''
  local max_id=''
  local user_screen_name="$(self_screen_name)"

  local OPTIND OPTARG OPT
  while getopts c:s:m:u: OPT
  do
    case $OPT in
      c )
        count="$OPTARG"
        ;;
      s )
        since_id="$(echo "$OPTARG" | extract_tweet_id)"
        [ "$since_id" != '' ] && since_id="since_id $since_id"
        ;;
      m )
        max_id="$(echo "$OPTARG" | extract_tweet_id)"
        [ "$max_id" != '' ] && max_id="max_id $max_id"
        ;;
      u )
        user_screen_name="$OPTARG"
        ;;
    esac
  done

  local params="$(cat << FIN
screen_name $user_screen_name
count $count
$since_id
$max_id
FIN
  )"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/favorites/list.json)"
  echo "$result"
  check_errors "$result"
}

watch_mentions() {
  ensure_available

  local extra_keywords=''
  local OPTIND OPTARG OPT
  while getopts k:m:r:q:f:d:s: OPT
  do
    case $OPT in
      k )
        extra_keywords="$OPTARG"
        ;;
    esac
  done

  local user_screen_name="$(self_screen_name)"
  local tracking_keywords="$user_screen_name"
  [ "$extra_keywords" != '' ] && tracking_keywords="$tracking_keywords,$extra_keywords"

  echo "Tracking mentions for $tracking_keywords..." 1>&2

  local params="$(cat << FIN
replies all
track $tracking_keywords
FIN
  )"
  echo "$params" |
    call_api GET https://userstream.twitter.com/1.1/user.json |
    handle_mentions "$user_screen_name" "$@"
}

fetch_tweets() {
  ensure_available
  local count=10
  local since_id=''
  local max_id=''
  local user_screen_name="$(self_screen_name)"
  local exclude_replies='exclude_replies 1'
  local include_rts='include_rts 0'
  local tweet_mode='tweet_mode extended'

  local OPTIND OPTARG OPT
  while getopts c:s:m:u:arf OPT
  do
    case $OPT in
      c )
        count="$OPTARG"
        ;;
      s )
        since_id="$(echo "$OPTARG" | extract_tweet_id)"
        [ "$since_id" != '' ] && since_id="since_id $since_id"
        ;;
      m )
        max_id="$(echo "$OPTARG" | extract_tweet_id)"
        [ "$max_id" != '' ] && max_id="max_id $max_id"
        ;;
      u )
        user_screen_name="$OPTARG"
        ;;
      a )
        exclude_replies='exclude_replies 0'
        ;;
      r )
        include_rts='include_rts 1'
        ;;
      f )
        tweet_mode='tweet_mode extended'
        ;;
    esac
  done

  local params="$(cat << FIN
screen_name $user_screen_name
count $count
$since_id
$max_id
$exclude_replies
$include_rts
$tweet_mode
FIN
  )"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/statuses/user_timeline.json)"
  echo "$result"
  check_errors "$result"
}

watch_mentions() {
  ensure_available

  local extra_keywords=''
  local OPTIND OPTARG OPT
  while getopts k:m:r:q:f:d:s: OPT
  do
    case $OPT in
      k )
        extra_keywords="$OPTARG"
        ;;
    esac
  done

  local user_screen_name="$(self_screen_name)"
  local tracking_keywords="$user_screen_name"
  [ "$extra_keywords" != '' ] && tracking_keywords="$tracking_keywords,$extra_keywords"

  echo "Tracking mentions for $tracking_keywords..." 1>&2

  local params="$(cat << FIN
replies all
track $tracking_keywords
FIN
  )"
  echo "$params" |
    call_api GET https://userstream.twitter.com/1.1/user.json |
    handle_mentions "$user_screen_name" "$@"
}

handle_mentions() {
  local user_screen_name=$1
  shift

  local keywords=''
  local mention_handler=''
  local retweet_handler=''
  local quoted_handler=''
  local followed_handler=''
  local dm_handler=''
  local search_handler=''

  local OPTIND OPTARG OPT
  while getopts k:m:r:q:f:d:s: OPT
  do
    case $OPT in
      k )
        keywords="$OPTARG"
        ;;
      m )
        mention_handler="$OPTARG"
        ;;
      r )
        retweet_handler="$OPTARG"
        ;;
      q )
        quoted_handler="$OPTARG"
        ;;
      f )
        followed_handler="$OPTARG"
        ;;
      d )
        dm_handler="$OPTARG"
        ;;
      s )
        search_handler="$OPTARG"
        ;;
    esac
  done

  local type
  while read -r line
  do
    type="$(echo "$line" |
              detect_type -k "$keywords")"
    [ $? != 0 ] && continue;

    log "Detected: $type"

    case "$type" in
      event-follow )
        if [ "$followed_handler" != '' ]
        then
          echo "$line" |
            (cd "$work_dir"; eval "$followed_handler")
        else
          echo "$line"
        fi
        continue
        ;;

      direct-message )
        if [ "$dm_handler" != '' ]
        then
          echo "$line" |
            jq -r -c .direct_message
            (cd "$work_dir"; eval "$dm_handler")
        else
          echo "$line"
        fi
        continue
        ;;

      quotation )
        if [ "$quoted_handler" != '' ]
        then
          echo "$line" |
            (cd "$work_dir"; eval "$quoted_handler")
        else
          echo "$line"
        fi
        continue
        ;;

      retweet )
        if [ "$retweet_handler" != '' ]
        then
          echo "$line" |
            (cd "$work_dir"; eval "$retweet_handler")
        else
          echo "$line"
        fi
        continue
        ;;

      mention )
        if [ "$mention_handler" != '' ]
        then
          echo "$line" |
            (cd "$work_dir"; eval "$mention_handler")
        else
          echo "$line"
        fi
        continue
        ;;

      search-result )
        if [ "$search_handler" != '' ]
        then
          echo "$line" |
            (cd "$work_dir"; eval "$search_handler")
        else
          echo "$line"
        fi
        continue
        ;;
    esac
  done
}

detect_type() {
  local keywords_matcher=''

  local OPTIND OPTARG OPT
  while getopts k: OPT
  do
    case $OPT in
      k )
        keywords_matcher="$(echo "$OPTARG" | \
                              sed -e 's/,/|/g' \
                                  -e 's/ +/.*/g')"
        ;;
    esac
  done

  local input="$(cat)"

  if [ "$input" = 'Exceeded connection limit for user' ]
  then
    return 1
  fi

  # Events
  case "$(echo "$input" | jq -r .event)" in
    null )
      : # do nothing for tweets at here
      ;;
    follow )
      local screen_name="$(echo "$input" | \
                             jq -r .source.screen_name | \
                             tr -d '\n')"
      if [ "$screen_name" != "$MY_SCREEN_NAME" ]
      then
        echo "event-follow"
        return 0
      fi
      return 1
      ;;
    * ) # ignore other unknown events
      return 1
      ;;
  esac

  # DM
  local sender="$(echo "$input" | jq -r .sender_screen_name)"
  [ "$sender" = '' ] && sender="$(echo "$input" | jq -r .direct_message.sender_screen_name)"
  if [ "$sender" != '' \
       -a "$sender" != 'null' \
       -a "$sender" != "$MY_SCREEN_NAME" ]
  then
    echo "direct-message"
    return 0
  fi

  # Ignore self tweet or non-tweet object
  local owner="$(echo "$input" | extract_owner)"
  if [ "$owner" = "$MY_SCREEN_NAME" \
       -o "$owner" = 'null'  \
       -o "$owner" = '' ]
  then
    return 1
  fi

  # Detect quotation at first, because quotation can be
  # deteted as retweet or a simple mention unexpectedly.
  # NOTE: An RT of a QT can have both quoted_status and retweeted_status.
  #       We must ignore such case, because it is actually an RT not a QT.
  if [ "$(echo "$input" | \
            jq -r .quoted_status.user.screen_name | \
            tr -d '\n')" = "$MY_SCREEN_NAME" \
       -a \
       "$(echo "$input" | \
            jq -r .retweeted_status.user.screen_name | \
            tr -d '\n')" != "$MY_SCREEN_NAME" ]
  then
    echo "quotation"
    return 0
  fi

  local tweet_body="$(echo "$input" | body)"

  # Detect retweet before reqply, because "RT: @(screenname)"
  # can be deteted as a simple mention unexpectedly.
  if echo "$tweet_body" | grep "RT @$MY_SCREEN_NAME:" > /dev/null
  then
    echo "retweet"
    return 0
  fi
  if echo "$tweet_body" | egrep "^RT @[^:]+:" > /dev/null
  then
    # don't handle RT of RT
    return 1
  fi

  if echo "$tweet_body" | grep "@$MY_SCREEN_NAME" > /dev/null
  then
    echo "mention"
    return 0
  fi

  if echo "$tweet_body" | egrep -i "$keywords_matcher" > /dev/null
  then
    echo "search-result"
    return 0
  fi

  return 1
}

body() {
  local target="$1"
  if [ "$target" != '' ]
  then
    local id="$(echo "$target" | extract_tweet_id)"
    fetch "$id" | body
  else
    jq -r .text | unicode_unescape
  fi
}

owner_screen_name() {
  local target="$1"
  local screen_name
  if [ "$target" != '' ]
  then
    local id="$(echo "$target" | extract_tweet_id)"
    screen_name="$(fetch "$id" | extract_owner)"
  else
    screen_name="$(extract_owner)"
  fi
  if [ "$screen_name" = '' -o "$screen_name" = 'null' ]
  then
    echo ''
  else
    echo "@$screen_name"
  fi
}

# implementation of showme
my_information() {
  ensure_available
  call_api GET https://api.twitter.com/1.1/account/verify_credentials.json
}

rename() {
  ensure_available
  local params="$(cat << FIN
name $*
FIN
  )"
  local result="$(echo "$params" |
                    call_api POST https://api.twitter.com/1.1/account/update_profile.json)"

  echo "$result"
  check_errors "$result"
}

# implementation of whoami
self_screen_name() {
  if [ "$MY_SCREEN_NAME" != '' ]
  then
    echo "$MY_SCREEN_NAME" | tr -d '\n'
  else
    my_information |
      jq -r .screen_name |
      tr -d '\n'
  fi
}

# implementation of language
self_language() {
  local lang="$(my_information |
    jq -r .lang |
    tr -d '\n')"
  if [ "$lang" = 'null' -o "$lang" = '' ]
  then
    echo "en"
  else
    echo "$lang"
  fi
}

posting_body() {
  if [ -p /dev/fd/0 ]; then # the posting body is given via the pipeline
    cat | sed -E -e 's/$/\\n/' | paste -s -d '\0' -
  else
    echo -n -e "$*" | sed -E -e 's/$/\\n/' | paste -s -d '\0' -
  fi
}

status_param_from_posting_body() {
  local body="$(posting_body $*)"
  if [ "$body" != '' ]
  then
    echo "status $body"
  else
    echo ''
  fi
}

post() {
  ensure_available

  local uploaded_media_id=''
  local uploaded_media_ids=''
  local media_params=''
  local location_params=''

  local OPTIND OPTARG OPT
  while getopts i:m:l OPT
  do
    case $OPT in
      i )
        uploaded_media_id="$(upload_and_get_media_id "$OPTARG")" || exit $?
        if [ "$uploaded_media_ids" = '' ]; then
          uploaded_media_ids="$uploaded_media_id"
        else
          uploaded_media_ids="$uploaded_media_ids,$uploaded_media_id"
        fi
        media_params="media_ids $uploaded_media_ids"
        ;;
      m )
        media_params="media_ids $OPTARG"
        ;;
      l )
        location_params="$(curl --silent  http://geoip.nekudo.com/api | jq --raw-output '.location | "lat \(.latitude)\nlong \(.longitude)"')"
        ;;
    esac
  done
  shift $(expr $OPTIND - 1)

  local params="$(cat << FIN
$(status_param_from_posting_body $*)
$location_params
$media_params
FIN
  )"
  local result="$(echo "$params" |
                    call_api POST https://api.twitter.com/1.1/statuses/update.json)"

  echo "$result"
  check_errors "$result"
}

reply() {
  ensure_available

  local media_params=''

  local OPTIND OPTARG OPT
  while getopts i:m: OPT
  do
    case $OPT in
      i )
        uploaded_media_id="$(upload_and_get_media_id "$OPTARG")" || exit $?
        if [ "$uploaded_media_ids" = '' ]; then
          uploaded_media_ids="$uploaded_media_id"
        else
          uploaded_media_ids="$uploaded_media_ids,$uploaded_media_id"
        fi
        media_params="media_ids $uploaded_media_ids"
        ;;
      m )
        media_params="media_ids=$OPTARG"
        ;;
    esac
  done
  shift $(expr $OPTIND - 1)

  local target="$1"
  shift

  local id="$(echo "$target" | extract_tweet_id)"

  local params="$(cat << FIN
$(status_param_from_posting_body $*)
in_reply_to_status_id $id
$media_params
FIN
  )"
  local result="$(echo "$params" |
                    call_api POST https://api.twitter.com/1.1/statuses/update.json)"
  echo "$result"
  check_errors "$result"
}

upload() {
  ensure_available

  local target="$1"
  if [ "$target" = '' ]; then
    echo "Error: no media file specified to upload." 1>&2
    exit 1
  fi

  local result="$(call_api POST https://upload.twitter.com/1.1/media/upload.json media="$target")"
  echo "$result"
  check_errors "$result"
}

upload_and_get_media_id() {
  local target="$1"
  if [ "$target" = '' ]; then
    echo "Error: no media file specified to upload." 1>&2
    exit 1
  fi

  log "Uploading image: $target"

  local upload_result=''
  local uploaded_media_id=''

  # "echo ''" is requried to avoid unexpected reading data from STDIN.
  upload_result="$(echo '' | upload "$target")"
  log "Uploaded result: $upload_result"

  uploaded_media_id="$(echo "$upload_result" | jq --raw-output '.media_id_string')"
  if [ "$uploaded_media_id" = '' ]; then
    echo "Error: failed to upload $target" 1>&2
    exit 1
  fi

  echo "$uploaded_media_id"
}

delete() {
  ensure_available

  local target="$1"
  shift
  if [ "$target" = '' ]; then
    echo "Error: no tweet specified to delete." 1>&2
    exit 1
  fi

  local id="$(echo "$target" | extract_tweet_id)"
  if [ "$id" = '' ]
  then
    echo "not deletable target: \"$target\"" 1>&2
    return 1
  fi

  local result="$(call_api POST "https://api.twitter.com/1.1/statuses/destroy/$id.json")"
  echo "$result"
  check_errors "$result"
}

favorite() {
  ensure_available

  local target="$1"
  if [ "$target" = '' ]; then
    echo "Error: no tweet specified to favorite." 1>&2
    exit 1
  fi

  local id="$(echo "$target" | extract_tweet_id)"
  if [ "$id" = '' ]
  then
    echo "not favoritable target: \"$target\"" 1>&2
    return 1
  fi

  local params="$(cat << FIN
id $id
FIN
  )"
  local result="$(echo "$params" |
                    call_api POST https://api.twitter.com/1.1/favorites/create.json)"
  echo "$result"
  check_errors "$result"
}

unfavorite() {
  ensure_available

  local target="$1"
  if [ "$target" = '' ]; then
    echo "Error: no tweet specified to unfavorite." 1>&2
    exit 1
  fi

  local id="$(echo "$target" | extract_tweet_id)"
  if [ "$id" = '' ]
  then
    echo "not unfavoritable target: \"$target\"" 1>&2
    return 1
  fi

  local params="$(cat << FIN
id $id
FIN
  )"
  local result="$(echo "$params" |
                    call_api POST https://api.twitter.com/1.1/favorites/destroy.json)"
  echo "$result"
  check_errors "$result"
}

retweet() {
  ensure_available

  local target="$1"
  shift
  if [ "$target" = '' ]; then
    echo "Error: no tweet specified to retweet." 1>&2
    exit 1
  fi

  local id="$(echo "$target" | extract_tweet_id)"
  if [ "$id" = '' ]
  then
    echo "not retweetable target: \"$target\"" 1>&2
    return 1
  fi

  local result="$(call_api POST "https://api.twitter.com/1.1/statuses/retweet/$id.json")"
  echo "$result"
  check_errors "$result"
}

unretweet() {
  ensure_available

  local target="$1"
  shift
  if [ "$target" = '' ]; then
    echo "Error: no tweet specified to unretweet." 1>&2
    exit 1
  fi

  local id="$(echo "$target" | extract_tweet_id)"
  if [ "$id" = '' ]
  then
    echo "not unretweetable target: \"$target\"" 1>&2
    return 1
  fi

  local retweet_id="$(fetch_with_my_retweet "$id" | jq -r .current_user_retweet.id_str)"
  delete "$retweet_id"
}

follow() {
  ensure_available

  local target="$1"
  local screen_name

  if [ "$target" = '' ]; then
    echo "Error: no user specified to follow." 1>&2
    exit 1
  fi

  if echo "$target" | egrep '^https?:' >/dev/null 2>&1
  then
    target="$(owner_screen_name "$target")"
  fi
  screen_name="$(echo "$target" | sed 's/^@//')"

  if [ "$screen_name" = '' ]
  then
    echo "not followable target: \"$target\"" 1>&2
    return 1
  fi

  local params="$(cat << FIN
screen_name $screen_name
follow true
FIN
  )"
  local result="$(echo "$params" |
                    call_api POST https://api.twitter.com/1.1/friendships/create.json)"
  echo "$result"
  check_errors "$result"
}

unfollow() {
  ensure_available

  local target="$1"
  local screen_name

  if [ "$target" = '' ]; then
    echo "Error: no user specified to unfollow." 1>&2
    exit 1
  fi

  if echo "$target" | egrep '^https?:' >/dev/null 2>&1
  then
    target="$(owner_screen_name "$target")"
  fi
  screen_name="$(echo "$target" | sed 's/^@//')"

  if [ "$screen_name" = '' ]
  then
    echo "not unfollowable target: \"$target\"" 1>&2
    return 1
  fi

  local params="$(cat << FIN
screen_name $screen_name
FIN
  )"
  local result="$(echo "$params" |
                    call_api POST https://api.twitter.com/1.1/friendships/destroy.json)"
  echo "$result"
  check_errors "$result"
}


fetch_direct_messages() {
  ensure_available
  local count=10

  local OPTIND OPTARG OPT
  while getopts c: OPT
  do
    case $OPT in
      c )
        count="$OPTARG"
        ;;
    esac
  done

  local params="$(cat << FIN
count $count
FIN
  )"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/direct_messages/events/list.json)"
  echo "$result"
  check_errors "$result"
}

direct_message() {
  ensure_available

  local target="$1"
  shift
  if [ "$target" = '' ]; then
    echo "Error: no recipient specified to send a direct message." 1>&2
    exit 1
  fi

  target="$(normalize_to_user_id "$(echo -n "$target" | sed 's/^@//')")"

  local params="$(compact_json << FIN
{
  "event": {
    "type": "message_create",
    "message_create": {
      "target": {
        "recipient_id": "$target"
      },
      "message_data": {
        "text": $(posting_body "$*" | to_json_string)
      }
    }
  }
}
FIN
  )"
  local result="$(echo "$params" |
                    call_api_with_json POST https://api.twitter.com/1.1/direct_messages/events/new.json)"
  echo "$result"
  check_errors "$result"
}

delete_direct_message() {
  ensure_available

  local target="$1"
  shift
  if [ "$target" = '' ]; then
    echo "Error: no message id specified to delete." 1>&2
    exit 1
  fi

  local params="$(cat << FIN
id $target
FIN
  )"
  local result="$(echo "$params" |
                    call_api DELETE https://api.twitter.com/1.1/direct_messages/events/destroy.json)"
  echo "$result"
  check_errors "$result"
}

get_user_id_from_screen_name() {
  ensure_available
  local params="screen_name $1"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/users/show.json)"
  echo -n "$result" | jq -r .id_str
  check_errors "$result"
}

get_screen_name_from_user_id() {
  ensure_available
  local params="user_id $1"
  local result="$(echo "$params" |
                    call_api GET https://api.twitter.com/1.1/users/show.json)"
  echo "$result" | jq -r .screen_name
  check_errors "$result"
}



#================================================================
# utilities to operate text

url_encode() {
  # process per line, because nkf -MQ automatically splits
  # the output string to 72 characters per a line.
  while read -r line
  do
    echo -e "$line" |
      while read -r part
      do
        echo "$part" |
          # convert to MIME quoted printable
          #  W8 => input encoding is UTF-8
          #  MQ => quoted printable
          nkf -W8MQ |
          sed 's/=$//' |
          tr '=' '%' |
          # reunify broken linkes to a line
          paste -s -d '\0' - |
          sed -e 's/%7E/~/g' \
              -e 's/%5F/_/g' \
              -e 's/%2D/-/g' \
              -e 's/%2E/./g'
      done |
        sed 's/$/%0A/g' |
        paste -s -d '\0' - |
        sed 's/%0A$//'
  done
}

# usage:
#   $ cat params
#   param1 aaa
#   param2 b b b
#   $ cat params | to_encoded_list
#   param1=aaa&param2=b%20b%20b
#   $ cat params | to_encoded_list ','
#   param1=aaa,param2=b%20b%20b
to_encoded_list() {
  local delimiter="$1"
  [ "$delimiter" = '' ] && delimiter='\&'
  local transformed="$( \
    # sort params by their name
    sort -k 1 -t ' ' |
    # remove blank lines
    grep -v '^\s*$' |
    # "name a b c" => "name%20a%20b%20c"
    url_encode |
    # "name%20a%20b%20c" => "name=a%20b%20c"
    sed 's/%20/=/' |
    # connect lines with the delimiter
    paste -s -d "$delimiter" - |
    # remove last line break
    tr -d '\n')"
  echo "$transformed"
  log "to_encoded_list: $transformed"
}

compact_json() {
  cat | jq -c .
}

to_json_string() {
  echo "\"$(sed -e 's/"/\\"/g' -e 's/$/\\n/' |
              paste -s -d '\0' - |
              sed 's/\\n$//')\""
}

extract_tweet_id() {
  resolve_original_url |
    sed -E -e 's;https://[^/]+/([^/]+|i/web)/status/;;' \
          -e 's;^([0-9]+)[^0-9].*$;\1;'
}

extract_list_id() {
  resolve_original_url |
    sed -E -e 's;https://[^/]+/([^/]+|i/web)/lists/;;' \
          -e 's;^([0-9]+)[^0-9].*$;\1;'
}

extract_owner() {
  jq -r .user.screen_name
}

normalize_to_user_id() {
  local possible_screen_name="$1"
  if ! echo -n "$possible_screen_name" | egrep '^[0-9]+$' >/dev/null 2>&1
  then
    get_user_id_from_screen_name "$possible_screen_name"
  else
    echo -n "$possible_screen_name"
  fi
}

unicode_unescape() {
  sed 's/\\u\(....\)/\&#x\1;/g' |
    nkf --numchar-input
}

URL_REDIRECTORS_MATCHER="^https?://($(echo "$URL_REDIRECTORS" | sed -E 's/\./\\./g' | paste -s -d '|' - | sed -E 's/^ *| *$//g'))/"

resolve_original_url() {
  while read -r url
  do
    if echo "$url" | egrep -i "$URL_REDIRECTORS_MATCHER" 2>&1 >/dev/null
    then
      curl --silent --head "$url" | egrep -i "^Location:" | sed -E "s/^[^:]+: *//"
    else
      echo $url
    fi
  done
}

resolve_all_urls() {
  input="$(cat)"
  url_resolvers="$(echo "$input" |
    egrep -o -i 'https?://[a-z0-9/\.]+' |
    sort |
    uniq |
    while read url
    do
      resolved="$(./tweetbot.sh/tweet.sh/tweet.sh resolve "$url" |
                    sed -E -e 's/([$&])/\\\1/g' |
                    tr -d '\r\n')"
      if [ "$url" != "$resolved" ]
      then
        echo -n " -e s;$url;$resolved;g"
      fi
    done)"
  if [ "$url_resolvers" != '' ]
  then
    echo -n "$input" | sed -E $url_resolvers
  else
    echo -n "$input"
  fi
}


#================================================================
# utilities to generate API requests with OAuth authentication

call_api_with_json() {
  call_api "$1" "$2" "$3" json
}

# usage:
# echo 'status Hello!' | call_api POST https://api.twitter.com/1.1/statuses/update.json
call_api() {
  local method=$1
  local url=$2
  local file=$3
  local data_type=$4

  local params=''
  local raw_params=''
  local content_type_header=''
  if [ ! -t 0 ]
  then
    raw_params="$(cat)"
    if [ "$data_type" = 'json' ]
    then
      content_type_header="--header 'content-type: application/json'"
      # no params for authentication!
    else
      params="$raw_params"
    fi
  fi

  local oauth="$(echo "$params" | generate_oauth_header "$method" "$url")"
  local headers="Authorization: OAuth $oauth"
  params="$(echo "$params" | to_encoded_list)"

  log "METHOD : $method"
  log "URL    : $url"
  log "HEADERS: $headers"
  log "DATA TYPE  : $data_type"
  log "RAW PARAMS : $raw_params"
  log "PARAMS : $params"

  local file_params=''
  if [ "$file" != '' ]
  then
    local file_param_name="$(echo "$file" | sed -E 's/=.+$//')"
    local file_path="$(echo "$file" | sed -E 's/^[^=]+=//')"
    file_params="--form $file_param_name=@$file_path"
    log "FILE   : $file_path (as $file_param_name)"
  fi

  local debug_params=''
  if [ "$DEBUG" != '' ]
  then
    debug_params="--verbose"
  fi

  local curl_params
  if [ "$method" = 'POST' -o "$method" = "DELETE" ]
  then
    local main_params=''
    if [ "$file_params" = '' ]
    then
      if [ "$data_type" = 'json' ]
      then
        main_params="--data \"$(echo "$raw_params" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')\""
      else
        # --data parameter requries any input even if it is blank.
        if [ "$params" = '' ]
        then
          params='""'
        fi
        main_params="--data \"$params\""
      fi
    elif [ "$params" != '""' -a "$params" != '' ]
    then
      # on the other hand, --form parameter doesn't accept blank input.
      main_params="--form \"$params\""
    fi
    curl_params="--header \"$headers\" \
         $([ "$method" != 'POST' ] && echo "--request $method" || echo '') \
         $content_type_header \
         --silent \
         $main_params \
         $file_params \
         $debug_params \
         $url"
  else
    curl_params="--get \
         --header \"$headers\" \
         --data \"$params\" \
         --silent \
         --http1.1 \
         $debug_params \
         $url"
  fi
  curl_params="$(echo "$curl_params" | tr -d '\n' | sed -E 's/  +/ /g')"
  log "curl $curl_params"
  # Command line string for logging couldn't be executed directly because
  # quotation marks in the command line will be passed to curl as is.
  # To avoid sending of needless quotation marks, the command line must be
  # executed via "eval".
  if [ "$debug_params" = '' ]
  then
    eval "curl $curl_params"
  else
    # to apply sanitize_secret_params only for stderr, swap stderr and stdout temporally.
    (eval "curl $curl_params" 3>&2 2>&1 1>&3 | sanitize_secret_params) 3>&2 2>&1 1>&3
  fi
}

# usage:
#   $ cat params
#   param1 aaa
#   param2 b b b
#   $ cat params | generate_oauth_header POST https://api.twitter.com/1.1/statuses/update.json
#   oauth_consumer_key=xxxxxxxxxxxxxx,oauth_nonce=xxxxxxxxxxxxxxxxx,oauth_signature_method=HMAC-SHA1,oauth_timestamp=xxxxxxxxx,oauth_token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx,oauth_version=1.0,oauth_signature=xxxxxxxxxxxxxxxxxx
generate_oauth_header() {
  local method=$1
  local url=$2

  local common_params="$(common_params)"

  local signature=$(cat - <(echo "$common_params") | generate_signature "$method" "$url")
  local header=$(cat <(echo "$common_params") <(echo "oauth_signature $signature") |
    to_encoded_list ',' |
    tr -d '\n')

  echo -n "$header"
  log "HEADER: $header"
}

# usage:
#   $ cat params
#   param1 aaa
#   param2 b b b
#   $ cat params | generate_signature POST https://api.twitter.com/1.1/statuses/update.json
#   xxxxxxxxxxxxxxxxxxxxxxx
generate_signature() {
  local method=$1
  local url=$2

  local signature_key="${CONSUMER_SECRET}&${ACCESS_TOKEN_SECRET}"

  local encoded_url="$(echo "$url" | url_encode)"
  local signature_source="${method}&${encoded_url}&$( \
    to_encoded_list |
    url_encode |
    # Remove last extra line-break
    tr -d '\n')"
  log "SIGNATURE SOURCE: $signature_source"

  # generate signature
  local signature=$(echo -n "$signature_source" |
    openssl sha1 -hmac $signature_key -binary |
    openssl base64 |
    tr -d '\n')

  echo -n "$signature"
  log "SIGNATURE: $signature"
}

common_params() {
  cat << FIN
oauth_consumer_key $CONSUMER_KEY
oauth_nonce $(date +%s%N)
oauth_signature_method HMAC-SHA1
oauth_timestamp $(date +%s)
oauth_token $ACCESS_TOKEN
oauth_version 1.0
FIN
}


#================================================================

# Orphan processes can be left after Ctrl-C or something,
# because there can be detached. We manually find them and kill all.
kill_descendants() {
  local target_pid=$1
  local children=$(ps --no-heading --ppid $target_pid -o pid)
  for child in $children
  do
    kill_descendants $child
  done
  if [ $target_pid != $$ ]
  then
    kill $target_pid 2>&1 > /dev/null
  fi
}

if [ "$(basename "$0")" = "tweet.sh" ]
then
  command="$1"
  shift

  self_pid=$$
  trap 'kill_descendants $self_pid; exit 0' HUP INT QUIT KILL TERM

  case "$command" in
    fetch|get|show )
      fetch "$@"
      ;;
    get-list-members )
      get_list_members "$@"
      ;;
    search )
      search "$@"
      ;;
    fetch-fav|fetch-favorites )
      fetch_favorites "$@"
      ;;
    fetch-tweet*|fetch-post* )
      fetch_tweets "$@"
      ;;
    watch|watch-mentions )
      watch_mentions "$@"
      ;;
    type )
      detect_type "$@"
      ;;
    body )
      body "$@"
      ;;
    owner )
      owner_screen_name "$@"
      ;;
    showme )
      my_information
      ;;
    whoami )
      self_screen_name
      ;;
    rename )
      rename "$@"
      ;;
    lang|language )
      self_language
      ;;

    post|tweet|tw )
      post "$@"
      ;;
    reply )
      reply "$@"
      ;;
    upload )
      upload "$@"
      ;;
    del|delete|rm|remove )
      delete "$@"
      ;;
    fav|favorite )
      favorite "$@"
      ;;
    unfav|unfavorite )
      unfavorite "$@"
      ;;
    rt|retweet )
      retweet "$@"
      ;;
    unrt|unretweet )
      unretweet "$@"
      ;;
    follow )
      follow "$@"
      ;;
    unfollow )
      unfollow "$@"
      ;;

    fetch-dm|fetch-direct-messages|get-dm|get-direct-messages )
      fetch_direct_messages "$@"
      ;;
    dm|direct-message )
      direct_message "$@"
      ;;
    del-dm|delete-dm|del-direct-message|delete-direct-message )
      delete_direct_message "$@"
      ;;

    get-user-id )
      get_user_id_from_screen_name "$1"
      ;;

    get-screen-name )
      get_screen_name_from_user_id "$1"
      ;;

    resolve )
      echo "$1" | resolve_original_url
      ;;

    resolve-all )
      resolve_all_urls
      ;;

    help|* )
      help "$@"
      ;;
  esac
fi