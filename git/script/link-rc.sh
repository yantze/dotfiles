#!/bin/sh

cd "$(dirname $0)/.."

dir="$PWD"

ln -sf "$dir/_gitconfig" ~/.gitconfig
