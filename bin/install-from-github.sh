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

main() {
    options=$(gum spin --title "fetching urls..." -- lastversion --assets $1)
    selected=$(gum  choose `lastversion --assets $1`)
    tmpfile=$(mktemp /tmp/XXXX.deb)
    gum spin --title="Downloading $selected" -- curl -s -q -L $selected -o $tmpfile
    sudo  dpkg -i  $tmpfile
    rm -rf $tmpfile

}
main "$0"
