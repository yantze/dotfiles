#!/bin/sh

#author: yantze@126.com


cd "$(dirname $0)/.."

dir="$PWD"

if [[ -a ~/.vimrc ]]; then
    mv ~/.vimrc{,_old}
fi
if [[ -d ~/.vim ]]; then
    mv ~/.vim{,_old}
fi

ln -sf "$dir/_vimrc" ~/.vimrc
ln -sf "$dir/vimfiles" ~/.vim

#install vundle plugin
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


#install Bundle's Plugin
vim +BundleInstall +qall


#DEFAULT : Not to install YCM plug-in
sed -i '/Valloric\/YouCompleteMe/{s@^@" @}' ~/.vim/_vimrc.bundles
# if you want to install & compile YCM
# cd ~/.vim/bundle/YouCompleteMe
# mkdir ycm_build
# git submodule update --init --recursive
# ./install.sh


