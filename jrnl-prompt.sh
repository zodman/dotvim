####  sudo ln -s $(which date) /bin/gdate
hdate() {
	last_date=$(date +%s -d "$1")
	awk -v date="$last_date" -v now="$(date +%s)" '
    BEGIN {  
       diff = (now - date);
       if (diff > (24*60*60)) printf "%.0fd", diff/(24*60*60);
       else if (diff > (60*60)) printf "%.0fh", diff/(60*60);
       else if (diff > 60) printf "%.0fm", diff/60;
       else printf "%ss", diff;
    }'
}

_jrnl_last_entry() {
	lastdatetime=$(jrnl --short -n 1 --config-override colors.date NONE | awk '{print $1 " " $2}')
	_jrnl_last_entry_out=$(hdate "$lastdatetime")
}

_jrnl_prompt() {
	_jrnl_last_entry
	echo "jrnl:$_jrnl_last_entry_out"
}
alias jrnl-prompt=_jrnl_prompt
