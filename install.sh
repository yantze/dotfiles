#!/bin/sh

echo Dotfiles manual
echo
echo \\t push     \\t  - push current repo.
echo \\t tmux 		\\t  - ln tmux.
echo \\t zshrc 	  \\t  - ln zshrc.
echo \\t vim   	  \\t  - ln vimrc.
echo \\t git	 	  \\t  - ln git.
echo \\t emacs	 	\\t  - install emacs configs.
echo

ohmyzsh_script=https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
nvm_script=https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh
pyenv_script=https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer

emacs_repo=https://github.com/purcell/emacs.d

zshrc() {
  ln -s ~/.dotfiles/zshrc/zshrc ~/.zshrc
}

vimrc() {
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  #install Bundle's Plugin
  vim +BundleInstall +qall
}

tmux() {
  ln -s $(dest)/tmux/tmux.conf ~/.tmux.conf
}

git() {
  ln -s $(dest)/git/_gitconfig ~/.gitconfig
  ln -s $(dest)/git/_global_ignore ~/.global_ignore
}

emacs() {
  git clone $(emacs_repo) ~/.emacs.d
}

nvm() {
  wget -qO- $(nvm_script) | sh
}

pyenv() {
  curl -L $(pyenv_script) | bash
}

ohmyzsh() {
  wget -O - $(ohmyzsh) | sh
}

