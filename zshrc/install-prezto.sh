#!/usr/bin/env zsh
# // Zsh起動

# // リポジトリをclone
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# ln -sf ~/.dotfiles/module/prezto ~/.zprezto

# // 既存の設定ファイルを退避(必要な場合)
timeRd=$(date +%s)
mkdir ~/zsh_orig_$timeRd && mv zshmv .zlogin .zlogout .zprofile .zshenv .zshrc ~/zsh_orig_$timeRd


# // 設定ファイルを作成
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# // Shellのデフォルトに設定
# chsh -s /usr/bin/zsh
# ubuntu's zsh in /usr/bin/zsh

# //install & update
# git pull && git submodule update --init --recursive

# ln -sf ~/.dotfiles/zshrc/prezto_theme_sorin_for_putty ~/.zprezto/modules/prompt/functions/prompt_sorin_setup
# ln -sf ~/.dotfiles/zshrc/zshrc_prezto ~/.zshrc
ln -sf ~/.dotfiles/zshrc/zpreztorc ~/.zpreztorc
