#!/usr/bin/env bash

CURRENT_EXECUTE_HOME=$(pwd -P)
if [[ `uname` = "Darwin" ]]; then #if mac
  SETTING_HOME=~/Library/Application\ Support
else
  SETTING_HOME=~/.config/Code/User
fi

ln -s $CURRENT_EXECUTE_HOME/snippets $SETTING_HOME/Code/User


for file in `ls       \
  *.json              \
  `; do
  ln -s "$CURRENT_EXECUTE_HOME/$file" ~/Library/Application\ Support/Code/User
done
