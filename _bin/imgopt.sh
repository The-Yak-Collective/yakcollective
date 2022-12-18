#!/usr/bin/env bash

# Image optimization helper script. Expects the following packages
# (Ubuntu) or equivalents to be installed:
#
#     graphicsmagick
#     webp

# Parse commandline
#
NEED_HELP="no"
case "$1" in
	rgb)
		GRAYSCALE="no"
		;;
	grayscale)
		GRAYSCALE="yes"
		;;
	*)
		NEED_HELP="yes"
		;;
esac
case "$2" in
	avatar)
		SIZE="512"
		;;
	image)
		SIZE="2048"
		;;
	fullbleed)
		SIZE="4096"
		;;
	*)
		NEED_HELP="yes"
		;;
esac
if [[ -f "$3" ]]; then
	OLD="$(basename "$4")"
	EXT="$(echo ${FILE_NAME##*.} | tr '[:upper:]' '[:lower:]')"
	DIR="$(dirname "$4")"
	NEW="${OLD%.*}.webp"
else
	NEED_HELP="yes"
fi

if [[ "$NEED_HELP" == "yes" ]]; then
	echo "USAGE: imgopt.sh [rgb|grayscale] [avatar|image|fullbleed] <IMAGE_TO_OPTIMIZE>"
	echo ""
	echo "Outputs a color (rgb) or grayscale (grayscale) WebP version of"
	echo "IMAGE_TO_OPTIMIZE that has been scaled down (if appropriate) so that"
	echo "its smallest dimension is either 128px (avatar), 1440px (image), or"
	echo "2880px (fullbleed). Any input format understood by GraphicsMagick is"
	echo "supported."
	exit 1
fi

# Determine GraphicsMagick command.
#
if [[ "$GRAYSCALE" == "yes" ]]; then
	CONVERT="gm convert -colorspace Rec709Luma"
else
	CONVERT="gm convert"
fi

# Convert image to webp
#
if [[ "$EXT" == "webp" ]]; then
	echo "Image $DIR/$OLD is already in WebP format..."
	exit 1
elif [[ "$EXT" == "gif" ]]; then
	if [[ -x "$(which gif2webp)" ]]; then
		gif2webp -metadata none "$DIR/$OLD" -o "$DIR/$NEW"
	else
		echo "Required binary (gif2webp) not found!"
		exit 1
	fi
else
	TMP="$(mktemp -u).tiff"
	if [[ -x "$(which gm)" ]] && [[ -x "$(which cwebp)" ]]; then
		bash -c "$CONVERT -resize '${SIZE}x${SIZE}^>' -strip '$DIR/$OLD' '$TMP'"
		if [[ $? -eq 0 ]]; then
			cwebp -preset default -metadata none -q 85 "$TMP" -o "$DIR/$NEW"
			rm "$TMP"
		else
			echo "Could not conver $DIR/$OLD! Is the format supported by GraphicsMagick?"
			exit 1
		fi
	else
		echo "Required binaries (gm & cwebp) not found!"
		exit 1
	fi
fi
