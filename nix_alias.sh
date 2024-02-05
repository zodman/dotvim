alias nix-env-search='bkt -- nix-env -qa "*"  --description '
alias nix-env-update='nix-channel --update && gum spin --title "Updating ..."  --show-output -- nix-env -u "*" '
