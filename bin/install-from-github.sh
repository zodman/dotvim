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

selected=$(gum  choose `lastversion --assets $1`)
tmpfile=$(mktemp /tmp/XXXX.deb)
gum spin --title="Downloading $selected" -- curl -s -q -L $selected -o $tmpfile

red "Install the $tmpfile"
if [[ $tmpfile == *.deb ]] 
then
    sudo  dpkg -i  $tmpfile
elif [[ $tmpfile == *.zip ]]
then
    sudo unzip -d /usr/local/ $tmpfile
else
    red "No installed the $tmpfile"
    
fi

rm -rf $tmpfile

