#!/bin/env zxpy
import colorama

import os

HOME = os.getenv("HOME")

os.chdir(os.path.join(HOME, '.local', 'bin'))

~"rm -f nvim.appimage"
~"curl -s -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
~"chmod u+x nvim.appimage"
print(f'{colorama.Fore.GREEN}> Install success {colorama.Fore.RESET}')
~"nvim.appimage --version"
