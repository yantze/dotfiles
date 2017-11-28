#!/usr/bin/env bash

CURRENT_EXECUTE_HOME=$(pwd -P)

ln -s $CURRENT_EXECUTE_HOME/settings.json ~/Library/Application\ Support/Code/User
ln -s $CURRENT_EXECUTE_HOME/snippets ~/Library/Application\ Support/Code/User
ln -s $CURRENT_EXECUTE_HOME/keybindings.json ~/Library/Application\ Support/Code/User
