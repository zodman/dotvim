#!/usr/bin/env bash
# requirements:
# https://github.com/dvershinin/lastversion
# https://github.com/charmbracelet/gum
### used lastversion and gum

set -o errexit

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo "Usage: ./$0 <software>"
	exit
fi

selected=$(gum choose $(lastversion --assets $1))

tmp_filename=$(curl -s -q -L -I $selected | grep 'disposition' | tail -n1 | awk '{print $3}' | sed s/filename=//g | sed 's/\r$//g')

tmpfile=$(mktemp /tmp/XXXX.$tmp_filename)

gum spin --title="Downloading $selected" -- curl -s -q -L $selected -o $tmpfile

red "Install the $tmpfile"
if [[ $tmpfile == *.deb ]]; then
	sudo dpkg -i $tmpfile
elif [[ $tmpfile == *.tar.gz ]]; then
	ouput_dir="/usr/local/src/$tmp_filename"
	sudo mkdir -p $ouput_dir
	sudo tar -zxvf $tmpfile --directory $ouput_dir
	red "installed at $ouput_dir"
elif [[ $tmpfile == *.zip ]]; then
	sudo unzip -d /usr/local/ $tmpfile
else
	red "No installed the $tmpfile"

fi

rm -rf $tmpfile
