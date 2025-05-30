#!/usr/bin/env bash

echo "Copy to your own code, nothing to do."
exit 0

# install
git clone https://github.com/yantze/dotfiles ~/.dotfiles
ln -s ~/.dotfiles/bin ~/.bin

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle
brew bundle

# zsh
git clone https://github.com/zsh-users/antigen ~/.local/antigen
echo '. ~/.dotfiles/shell/zshrc' >> ~/.zshrc
chsh -s /bin/zsh

# bash
echo '. ~/.dotfiles/shell/zshrc' >> ~/.bashrc
ln -s ~/.dotfiles/shell/inputrc ~/.inputrc

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# !!! prefix + I Install plugiin
#
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# autojump / z for bash
git clone https://github.com/rupa/z ~/.local_tmp/z
cd ~/.local_tmp/z
make


# install tmux lastest manually
# git clone https://github.com/tmux/tmux.git ~/.local/tmux-build
# cd tmux
# sh autogen.sh
# ./configure && make

# hammerspoon
ln -s ~/.dotfiles/hammerspoon/ ~/.hammerspoon

# spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -s ~/.dotfiles/spacemacs/spacemacs ~/.spacemacs

# link xcopy , xpaste and cpaste
ln -sf ~/.dotfiles/usrbin/xcopy /usr/local/bin/
ln -sf ~/.dotfiles/usrbin/xpaste /usr/local/bin/
ln -sf ~/.dotfiles/usrbin/cpaste /usr/local/bin/

# link vscode
bash ~/.dotfiles/vscode/link_settings.sh

# git
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# mutt
git clone https://github.com/altercation/mutt-colors-solarized ~/.local/mutt-colors-solarized
ln -s ~/.dotfiles/mutt/muttrc ~/.muttrc

# npm
# Set only one bin
npm config set prefix ~/.npm-global
echo 'export PATH="~/.npm-global/bin:$PATH"' >> ~/.zshrc
# echo 'export PATH="~/.npm-global/bin:$PATH"' >> ~/.bashrc
npm install -g fixjson  # requirement by vim

# mac
# 支持快速重复按键
# defaults write -g ApplePressAndHoldEnabled 0

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# node
# node package manager
curl -L https://git.io/n-install | bash
n 14
export PATH="$HOME/n/bin:$PATH"
npm i -g pm2
