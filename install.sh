#!/usr/bin/env bash

echo "Copy to your own code, nothing to do."
exit 0

# install
git clone https://github.com/yantze/dotfiles ~/.dotfiles
ln -s ~/.dotfiles/bin ~/.bin

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle
brew tap caskroom/versions
brew bundle

# zsh
git clone https://github.com/zsh-users/antigen ~/.local/antigen
echo '. ~/.dotfiles/zshrc/zshrc' >> ~/.zshrc
# echo '. ~/.dotfiles/zshrc/zshrc' >> ~/.bashrc
chsh -s /bin/zsh

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

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
npm install -g eslint eslint-plugin-standard eslint-plugin-promise eslint-config-standard  # requirement by vim and vscode
