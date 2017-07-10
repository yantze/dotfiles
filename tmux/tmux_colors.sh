#! /bin/bash

# author: hamvocke
# https://github.com/hamvocke/dotfiles/blob/master/tmux/tmux_colors.sh

# for i in {0..255} ; do
#     printf "\x1b[38;5;${i}mcolour${i}\n"
# done


for i in {0..255} ; do
  printf "$(tput setab ${i})$(tput setaf 0)colour${i} test test xxxx xxxx xxxx\n"
done
