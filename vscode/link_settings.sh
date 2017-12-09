#!/usr/bin/env bash

CURRENT_EXECUTE_HOME=$(pwd -P)

ln -s $CURRENT_EXECUTE_HOME/snippets ~/Library/Application\ Support/Code/User

for file in `ls       \
  *.json              \
  `; do
  ln -s "$CURRENT_EXECUTE_HOME/$file" ~/Library/Application\ Support/Code/User
done
