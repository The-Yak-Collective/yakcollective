#!/bin/false
# UTF-8-compatible string alignment library

# Space pad align string to width
# @params
# $1: The alignment width
# $2: The string to align
# @stdout
# aligned string

align::left() {
	local -i width=${1:?} # Mandatory column width
	local -- str=${2:?} # Mandatory input string
	local -i length=$((${#str} > width ? width : ${#str}))
	local -i pad_right=$((width - length))
	printf '%s%*s' "${str:0:length}" $pad_right ''
}

align::right() {
	local -i width=${1:?} # Mandatory column width
	local -- str=${2:?} # Mandatory input string
	local -i length=$((${#str} > width ? width : ${#str}))
	local -i offset=$((${#str} - length))
	local -i pad_left=$((width - length))
	printf '%*s%s' $pad_left '' "${str:offset:length}"
}

align::center() {
	local -i width=${1:?} # Mandatory column width
	local -- str=${2:?} # Mandatory input string
	local -i length=$((${#str} > width ? width : ${#str}))
	local -i offset=$(((${#str} - length) / 2))
	local -i pad_left=$(((width - length) / 2))
	local -i pad_right=$((width - length - pad_left))
	printf '%*s%s%*s' $pad_left '' "${str:offset:length}" $pad_right ''
}

# https://stackoverflow.com/questions/73742856/printing-and-padding-strings-with-bash-printf/73747519#73747519
