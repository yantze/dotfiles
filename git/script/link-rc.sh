#!/bin/sh

cd "$(dirname $0)/.."

dir="$PWD"

ln -sf "$dir/_gitconfig" ~/.gitconfig
ln -sf "$dir/_gitignore_global" ~/.gitignore_global
