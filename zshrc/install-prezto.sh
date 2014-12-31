# // Zsh起動
zsh

# // リポジトリをclone
# git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# // 既存の設定ファイルを退避(必要な場合)
mkdir zsh_orig && mv zshmv .zlogin .zlogout .zprofile .zshenv .zshrc zsh_orig

# // 設定ファイルを作成
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# // Shellのデフォルトに設定
chsh -s /bin/zsh

# //install & update
# git pull && git submodule update --init --recursive
