#!/usr/bin/env bash

echo "[$(date)] Started member update from Knack"

# These environment variables should also be set:
#
#     KNACK_APP_ID
#     KNACK_API_KEY
#     KNACK_OBJECT
#
# The KNACK_OBJECT should be in the form "object_0", where "0" is the
# schema you want to pull. You can find this out by looking at the URL
# when viewing the schema of interest in the Knack Builder.
#
# App ID and API KEY are available in the Knack Builder under Settings >
# API & Code.

# Source init. (But ONLY if we're not being run from common-init.sh, to
# prevent infinite recursion.)
#
if [[ -z "$KNACK_YAK_PULL_CALLED_BY_COMMON_INIT" ]]; then
	if [[ -f ./.automation/bin/common-init.sh ]]; then
		export COMMON_INIT_CALLED_BY_KNACK_YAK_PULL=1
		source ./.automation/bin/common-init.sh
		unset COMMON_INIT_CALLED_BY_KNACK_YAK_PULL
	else
		echo "Init file not found! Are you running from the repository root?"
		exit 1
	fi
fi

# Knack can return up to 1000 rows per page. The default is 25.
#
#     https://docs.knack.com/docs/pagination
#
KNACK_ROWS_PER_PAGE=1000

# Create temp directory.
#
TEMP_DIR="$(mktemp -d)"

# Pull the first page of data.
#
#    https://docs.knack.com/docs/retrieving-multiple-records
#
echo "[$(date)] Pulling Knack member data..."
curl -sS -X  GET \
         -H "X-Knack-Application-Id: $KNACK_APP_ID" \
         -H "X-Knack-REST-API-Key: $KNACK_API_KEY" \
            "https://api.knack.com/v1/objects/${KNACK_OBJECT}/records?rows_per_page=${KNACK_ROWS_PER_PAGE}&page=1" > $TEMP_DIR/knack-yaks-1.json

# How many pages of data do we have?
#
TOTAL_PAGES=$(jq .total_pages $TEMP_DIR/knack-yaks-1.json)

# If we have more than one page then we need to pull down the remaining
# data.
#
# FIXME: There's a potential race condition here where people may be
# registering or making updates at the same time that we're dumping
# member data. This could lead to duplicate and/or missing rows.
#
if [[ TOTAL_PAGES -gt 1 ]]; then
	for (( CURRENT_PAGE=2; CURRENT_PAGE<=$TOTAL_PAGES; CURRENT_PAGE++ )); do
		echo "Pulling Knack member data ($CURRENT_PAGE/$TOTAL_PAGES)..."
		curl -sS -X  GET \
		         -H "X-Knack-Application-Id: $KNACK_APP_ID" \
		         -H "X-Knack-REST-API-Key: $KNACK_API_KEY" \
		            "https://api.knack.com/v1/objects/${KNACK_OBJECT}/records?rows_per_page=${KNACK_ROWS_PER_PAGE}&page=${CURRENT_PAGE}" > $TEMP_DIR/knack-yaks-${CURRENT_PAGE}.json
	done
fi

# Create a single JSON object of all yaks.
#
#     https://stackoverflow.com/a/52730148
#
echo "[$(date)] Processing Knack member data..."
mkdir -p .automation/var/cache/build/_data
jq -n '{records: [inputs.records] | add}' $TEMP_DIR/knack-yaks-* > .automation/var/cache/build/_data/knack_yaks.json

# Download Knack avatars locally.
#
(
	cd .automation/var/cache/build
	mkdir -p members

	while IFS= read -r RECORD; do
		MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
		echo "    Processing avatar for member $MEMBER_ID..."
		KNACK_PATH="$(echo "$RECORD" | cut -s -f 2 | sed -e "s#https://s3-eu-west-1.amazonaws.com/assets.knack-eu.com/assets/5f70876d8e7037001504bfe8/##")"
		if [[ -n "$KNACK_PATH" ]]; then
			USE_CURL="yes"
			AVATAR_URL="https://res.cloudinary.com/yak-collective/image/upload/c_fill,g_face,w_400,h_400,e_sharpen:50/yak-barn-v1/${KNACK_PATH%.*}.webp"
			OG_URL="https://res.cloudinary.com/yak-collective/image/upload/c_fill,g_face,w_1200,h_630,e_sharpen:50/yak-barn-v1/${KNACK_PATH%.*}.webp"
		else
			USE_CURL="no"
			AVATAR_URL=""
			OG_URL=""
		fi
		if [[ "$USE_CURL" == "yes" ]]; then
			curl -sS -o "members/${MEMBER_ID}.webp"    "$AVATAR_URL"
			curl -sS -o "members/${MEMBER_ID}-og.webp" "$OG_URL"
		fi
		if [[ ! -s "members/${MEMBER_ID}.webp" ]]; then
			cp "Assets/Yak.webp" "members/${MEMBER_ID}.webp"
		fi
		if [[ ! -s "members/${MEMBER_ID}-og.webp" ]]; then
			cp "Assets/Yak Trail.webp" "members/${MEMBER_ID}-og.webp"
		fi
	done <<< "$(jq -r '.records[] | [.field_101_raw, .field_44_raw.url?] | @tsv' _data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')"
)

# Update members page.
#
echo "[$(date)] Updating members page..."

mkdir -p .automation/var/cache/templates

if [[ -f Members.md ]]; then
	if [[ $(grep -c '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' Members.md) -eq 1 ]] \
	&& [[ $(grep -c '<!-- ----------------------------------------------------- -->' Members.md) -eq 2 ]]; then
		sed '/<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->/,$d' Members.md | head -n -1 > .automation/var/cache/templates/Members.md
		cat >> .automation/var/cache/templates/Members.md <<- EOF
		<!-- ----------------------------------------------------- -->
		<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->
		<!-- ----------------------------------------------------- -->
		EOF
	fi
fi

cat .automation/var/cache/templates/Members.md > Members.md

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1 | sed -e 's/^\s*//;s/\s*$//')"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#^\s*##;s#\s*$##;s#|#/#g')"

	echo "- [$NAME](https://www.yakcollective.org/members/${MEMBER_ID}/)" >> Members.md
done < <(jq -r '.records[] | [.field_102_raw, .field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | grep -E '^true' | sed -e 's/^true\s\+//;s/^\s*//;s/\s*$//;s/([^()]\+)//g;s/@.*//;s/ \+/ /g' | sort -uR)

# Cleanup.
#
echo "[$(date)] Cleaning up temporary files..."

rm -rf $TEMP_DIR

echo "[$(date)] Finished member update from Knack"
