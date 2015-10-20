#!/bin/sh

SOLARIZED_COLORS=$(dirname "$0")/solarized_colors.txt

usage() {
  {
    echo "Usage: "$(basename "$0")" [options] filename"
    echo
		echo "Options:"
		echo -e "      --help\t\tprint this help, then exit"
		echo -e "  -l, --light\t\tswitch colors to light color scheme (default is dark)"
		echo -e "  -H, --high-contrast\tadjust color scheme to high-contrast"
		echo -e "  -q, --quote\t\tenclose color values in double quotes (\")"
		echo -e "  -s, --script\t\tinstead of processing a file, output a sed script file to stdout"
  } >&2
  exit 2
}

quote=

while test $# -gt 0; do
	case $1 in
		--help)
			usage
		;;
		-l|--light)
			light=1
		;;
		-H|--high-contrast)
			high_contrast=1
		;;
		-q|--quote)
			quote='"'
		;;
		-s|--script)
			script=1
		;;
		-?*)
			echo "unrecognized option \"$1\"" >&2
			exit 1
		;;
		*)
			test "$1" = '-' && read_stdin=1 || filename="$1"
		;;
	esac
	
	shift
done

test "$read_stdin$filename$script" = "" && usage
test "$filename" && exec <"$filename"

declare -A colors
while read name tmp color; do
	test "$name" -a "${name:0:1}" != "#" -a "$tmp" = "=" -a "$color" &&	colors[$name]=$color
done <"$SOLARIZED_COLORS"

swap() {
	local tmp=${colors[$1]}
	colors[$1]=${colors[$2]}
	colors[$2]=$tmp
}

assign() {
	colors[$1]=${colors[$2]}
}

if test "$light"; then
	swap base00 base0
	swap base01 base1
	swap base02 base2
	swap base03 base3
fi

if test "$high_contrast"; then
	assign base01 base00
	assign base00 base0
	assign base0 base1
	assign base1 base2
	assign base2 base3
fi

if test "$script"; then
	echo '# ******************************************************************************'
	echo -n '# Solarized Colors ('
	test "$light" && echo -n "light" || echo -n "dark"
	test "$high_contrast" && echo -n ', high-contrast'
	echo -e ')\n#\n'
	for name in ${!colors[*]}; do
		echo "s,{"$name"},$quote"${colors[$name]}"$quote,g"
	done | sort
else
	cmd='sed'
	for name in ${!colors[*]}; do
		cmd="$cmd -e s,{"$name"},$quote"${colors[$name]}"$quote,g"
	done
	$cmd
fi
