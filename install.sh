#!/usr/bin/env bash

echo "Copy to yourself code, Nothing to do."
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
# git clone https://github.com/tmux/tmux.git
# cd tmux
# sh autogen.sh
# ./configure && make

# hammerspoon
ln -s ~/.dotfiles/hammerspoon/ ~/.hammerspoon

# spacemacs
ln -s ~/.dotfiles/spacemacs/spacemacs ~/.spacemacs

# link xcopy , xpaste and cpaste
ln -sf ~/.dotfiles/usrbin/xcopy /usr/local/bin/
ln -sf ~/.dotfiles/usrbin/xpaste /usr/local/bin/
ln -sf ~/.dotfiles/usrbin/cpaste /usr/local/bin/

# link vscode
bash ~/.dotfiles/vscode/link_settings.sh
