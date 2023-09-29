#!/usr/bin/env bash
# requirements:
# https://github.com/dvershinin/lastversion
# https://github.com/charmbracelet/gum
### used lastversion and gum

set -o errexit

red() {
	RED='\033[0;31m'
	NOCOLOR='\033[0m'
	printf "${RED} $1 ${NOCOLOR}"
}

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	red "Usage: ./$0 <owner/repo>"
	exit
fi

selected=$(gum choose $(lastversion --at gitlab --at github --assets $1))

tmp_filename=$(curl -s -q -L -I $selected | grep 'disposition' | tail -n1 | awk '{print $3}' | sed s/filename=//g | sed 's/\r$//g')

#tmpfile=$(mktemp /tmp/XXXX.$tmp_filename)
tmpfile=/tmp/$tmp_filename

gum spin --title="Downloading $selected" -- curl -s -q -L $selected -o $tmpfile

red "Install the $tmpfile"
if [[ $tmpfile == *.deb ]]; then
	sudo dpkg -i $tmpfile
elif [[ $tmpfile == *.appimage ]]; then
	sudo install $tmpfile $HOME/.local/bin/
	sudo ln -s $HOME/.local/bin/$tmp_filename \
		$HOME/.local/bin/$(echo $tmp_filename | sed s/\.appimage//g)
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
