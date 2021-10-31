#!/usr/bin/env bash

# Software requirements:
#
#     bash
#     curl
#     jq
#
# These are all available in the current/default Netlify build image.
#
#     https://github.com/netlify/build-image/blob/focal/included_software.md
#
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
curl -X  GET \
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
		curl -X  GET \
		     -H "X-Knack-Application-Id: $KNACK_APP_ID" \
		     -H "X-Knack-REST-API-Key: $KNACK_API_KEY" \
		        "https://api.knack.com/v1/objects/${KNACK_OBJECT}/records?rows_per_page=${KNACK_ROWS_PER_PAGE}&page=${CURRENT_PAGE}" > $TEMP_DIR/knack-yaks-${CURRENT_PAGE}.json
	done
fi

# Create a single JSON object of all yaks.
#
#     https://stackoverflow.com/a/52730148
#
mkdir -p _data
jq -n '{records: [inputs.records] | add}' $TEMP_DIR/knack-yaks-* > _data/knack_yaks.json

# Cleanup.
#
rm -rf $TEMP_DIR
