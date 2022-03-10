####  sudo ln -s $(which date) /bin/gdate
hdate () {
    last_date=$(date +%s -d "$1")
    awk -v date="$last_date" -v now="$(date +%s)" '
    BEGIN {  
       diff = (now - date);
       if (diff > (24*60*60)) printf "%.0f days ago", diff/(24*60*60);
       else if (diff > (60*60)) printf "%.0f hrs ago", diff/(60*60);
       else if (diff > 60) printf "%.0f mins ago", diff/60;
       else printf "%s secs ago", diff;
    }'
}

_jrnl_last_entry() {
	lastdatetime=`jrnl --short -n 1 | awk '{print $1 " " $2}'`
    _jrnl_last_entry_out=$(hdate "$lastdatetime" )
}

_jrnl_prompt() {
   _jrnl_last_entry
    echo "last jrnl: $_jrnl_last_entry_out"
}
alias jrnl-prompt=_jrnl_prompt
