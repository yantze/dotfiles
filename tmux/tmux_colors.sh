#! /bin/bash

# author: hamvocke
# https://github.com/hamvocke/dotfiles/blob/master/tmux/tmux_colors.sh

echo section 1
for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
done

echo section 2
for i in {0..255} ; do
  printf "$(tput setab ${i})$(tput setaf 0)colour${i} test test xxxx xxxx xxxx\n"
done

echo section 3
# 单列
for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
done

# 多列
echo section 4
for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i
    if ! (( ($i + 1 ) % 8 ))
        then echo
    fi
done
