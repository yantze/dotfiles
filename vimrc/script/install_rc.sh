#!/bin/sh
#author: yantze@126.com


<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 650b744ce130d87ab7cfeb32268038569f952778
# cd "$(dirname $0)/.."
# dir="$PWD"
# 
# time=$(date +%S)
# if [[ -a ~/.vimrc ]]; then
#     mv ~/.vimrc{,_old_$time}
# fi
# if [[ -a ~/.gvimrc ]]; then
#     mv ~/.gvimrc{,_old_$time}
# fi
# if [[ -d ~/.vim ]]; then
#     mv ~/.vim{,_old_$time}
# fi
# 
# ln -sf "$dir/_vimrc" ~/.vimrc
# ln -sf "$dir/_gvimrc" ~/.gvimrc
# ln -sf "$dir/vimfiles" ~/.vim
<<<<<<< HEAD
=======
cd "$(dirname $0)/.."
dir="$PWD"

time=$(date +%S)
if [[ -a ~/.vimrc ]]; then
    mv ~/.vimrc{,_old_$time}
fi
if [[ -a ~/.gvimrc ]]; then
    mv ~/.gvimrc{,_old_$time}
fi
if [[ -d ~/.vim ]]; then
    mv ~/.vim{,_old_$time}
fi

ln -sf "$dir/_vimrc" ~/.vimrc
ln -sf "$dir/_gvimrc" ~/.gvimrc
ln -sf "$dir/vimfiles" ~/.vim
>>>>>>> 3e9d7db8797b5d7fb6b8a28784d4930268fdb073
=======
>>>>>>> 650b744ce130d87ab7cfeb32268038569f952778

#install vundle plugin
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


#install Bundle's Plugin
vim +BundleInstall +qall

#DEFAULT : Not to install YCM plug-in
#sed -i '/Valloric\/YouCompleteMe/{s@^@" @}' ~/.vim/_vimrc.bundles
# if you want to install & compile YCM
# cd ~/.vim/bundle/YouCompleteMe
# mkdir ycm_build
# git submodule update --init --recursive
# ./install.sh

