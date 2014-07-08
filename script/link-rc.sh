#!/bin/sh
cd "$(dirname $0)/.."

dir="$PWD"

#for rc in _*;
  #do ln -sf "$dir/$rc" "../.${rc:1}";
#done;

ln -sf "$dir/_vimrc" ~/.vimrc
ln -sf "$dir/vimfiles" ~/.vim
