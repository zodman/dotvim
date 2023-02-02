#!/bin/bash

DIRFILES="/home/zodman/Dropbox/jarvis"
# DIRWINFILES='C:\Users\QA\jarvis\'

function noti () {
    # TEXT=`curl 'https://api.chucknorris.io/jokes/random?category=dev' -s | jq -r ".value"| sed s/\\"//g`
    #$POWERSHELL "New-BurntToastNotification  -Silent -Text \"$1\", \"$TEXT\""
#    $POWERSHELL "mpv --really-quiet 'C:\Users\QA\jarvis\jarvis_text.mp3'" 
    mpv --really-quiet '$DIRFILES\jarvis_text.mp3' 
}
function cmd_random_fail() {
  #p="$DIRFILES/failed"
  #f=$(find $p | shuf -n1)
  #f1=$(basename $f)
  #$POWERSHELL "mpv --no-video --really-quiet '$DIRWINFILES\failed\\$f1'" 
  mpv --no-video --really-quiet "$DIRFILES/speech_failed.mp3"
}

function cmd_random_success() {
  #p="$DIRFILES/success"
  #f=$(find $p | shuf -n1)
  #f1=$(basename $f)
  #$POWERSHELL "mpv --no-video --really-quiet '$DIRWINFILES\success\\$f1'"

  mpv --no-video --really-quiet "$DIRFILES/speech_success.mp3"
}


# Change the colour of an AnyBar
# Usage:
#   anybar <colour> <n>
#     Change the colour of the n'th AnyBar
#   anybar <colour>
#     Change the colour of this tab's AnyBar
#   anybar
#     Change the colour of this tab's AnyBar to white (resetting it)
function anybar() {
  local COLOUR=${1-white}
  local OFFSET=${2:-$(_anybar_iterm_offset)}
  local ANYBAR_PORT=$((1738 + $OFFSET))
  echo -n $COLOUR | nc -4u -w0 127.0.0.1 ${ANYBAR_PORT}
}

# Monitor a long running command using AnyBar
# This sets AnyBar to orange whilst the command is running,
# then to green or red depending on whether the command succeeded or not
#
# Usage:
#   alias m=anybar_monitor
#   s <some command>
function anybar_monitor() {
  if [ $# -eq 0 ]; then
    anybar white
  else
    anybar orange
    $@
    local EXIT_STATUS=$?
    if [ $EXIT_STATUS -ne 0 ]; then
      anybar red
      cmd_random_fail
    else
      anybar green
      cmd_random_success
    fi

    return $EXIT_STATUS
  fi
}

function _anybar_iterm_offset() {
  local ITERM_SESSION_OFFSET=0
  if [ $ITERM_SESSION_ID ]; then
      ITERM_SESSION_OFFSET=$((1 + ${ITERM_SESSION_ID:3:1}))
  fi
  echo $ITERM_SESSION_OFFSET
}

