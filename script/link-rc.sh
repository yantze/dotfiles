#!/bin/sh
cd "$(dirname $0)/.."

dir="$PWD"

#for rc in _*;
  #do ln -sf "$dir/$rc" "../.${rc:1}";
#done;


mv ~/.vimrc ~/.vimrc_orgi
mv ~/.vim ~/.vim_orgi
ln -s "$dir/_vimrc" ~/.vimrc
ln -s "$dir/vimfiles" ~/.vim

#install vundle plugin
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


#install Bundle's Plugin
vim +BundleInstall +qall


#DEFAULT : Not to install YCM plug-in
sed -i 's/^Plugin.*Valloric\/YouCompleteMe.$//' ~/.vim/_vimrc.bundles
# if you want to install & compile YCM
# cd ~/.vim/bundle/YouCompleteMe
# mkdir ycm_build
# git submodule update --init --recursive
# ./install.sh


