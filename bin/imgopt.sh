#!/bin/bash

# Image optimization helper script. Expects the following packages
# (Ubuntu) or equivalents to be installed:
#
#     graphicsmagick
#     libjpeg-turbo-progs
#     optipng

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
	jpg)
		EXT="jpg"
		;;
	png)
		EXT="png"
		;;
	*)
		NEED_HELP="yes"
		;;
esac
case "$3" in
	avatar)
		SIZE="128"
		;;
	image)
		SIZE="1440"
		;;
	fullbleed)
		SIZE="2880"
		;;
	*)
		NEED_HELP="yes"
		;;
esac
if [[ -f "$4" ]]; then
	OLD="$(basename "$4")"
	DIR="$(dirname "$4")"
	NEW="${OLD%.*}-NEW.$EXT"
else
	NEED_HELP="yes"
fi

if [[ "$NEED_HELP" == "yes" ]]; then
	echo "USAGE: imgopt.sh [rgb|grayscale] [jpg|png] [avatar|image|fullbleed] <IMAGE_TO_OPTIMIZE>"
	echo ""
	echo "Outputs a color (rgb) or grayscale (grayscale) JPEG (jpg) or PNG (png)"
	echo "optimized version of IMAGE_TO_OPTIMIZE that has been scaled down (if"
	echo "appropriate) so that its smallest dimension is either 128px (avatar),"
	echo "1440px (image), or 2880px (fullbleed)."

	echo "The new image will always have '-NEW' appended to its file name. Any"
	echo "input format understood by GraphicsMagick is supported. In general you"
	echo "should opt for JPEG output, unless the image needs to support"
	echo "transparency."
	exit 1
fi

# Determine GraphicsMagick and CJPEG commands.
#
if [[ "$GRAYSCALE" == "yes" ]]; then
	CONVERT="$(which gm) convert -colorspace Rec709Luma"
else
	CONVERT="$(which gm) convert"
fi
if [[ "$GRAYSCALE" == "yes" ]]; then
	CJPEG="$(which cjpeg) -grayscale"
else
	CJPEG="$(which cjpeg)"
fi

# Optimize image.
#
if [[ "$EXT" == "jpg" ]]; then
	bash -c "$CONVERT -resize '${SIZE}x${SIZE}^>' -strip '$DIR/$OLD' TGA:- | $CJPEG -optimize -progressive -outfile '$DIR/$NEW'"
else
	bash -c "$CONVERT -resize '${SIZE}x${SIZE}^>' -strip '$DIR/$OLD' '$DIR/$NEW'"
	optipng -o4 "$DIR/$NEW"
fi
