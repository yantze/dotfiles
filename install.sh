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
git clone https://github.com/zsh-users/antigen ~/.dotfiles/modules/antigen
echo '. ~/.dotfiles/zshrc/zshrc' >> ~/.zprofile
chsh -s /bin/zsh
# ui shell config should not put in ~/.zshrc

# tmux
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# slate
ln -s ~/.dotfiles/slate/slate ~/.slate

# spacemacs
ln -s ~/.dotfiles/spacemacs/spacemacs ~/.spacemacs
