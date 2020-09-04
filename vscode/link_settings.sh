#!/usr/bin/env bash

# vscode extension dir
# ~/.vscode/extensions/

CURRENT_EXECUTE_HOME=$(pwd -P)
if [[ `uname` = "Darwin" ]]; then #if mac
  SETTING_HOME=~/Library/Application\ Support
else
  SETTING_HOME=~/.config/Code/User
fi

# link

ln -s $CURRENT_EXECUTE_HOME/snippets "$SETTING_HOME/Code/User"

for file in `ls       \
  *.json              \
  `; do
  ln -s "$CURRENT_EXECUTE_HOME/$file" "$SETTING_HOME/Code/User"
done
