#!/bin/bash
THEME=$(ls | fzf)
[ $? -eq 0 ] && sed -i "$ d" ../alacritty.yml && echo "  - ~/$(realpath --relative-base=$HOME $PWD)/$THEME" >> ../alacritty.yml
