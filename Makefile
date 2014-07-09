# wget https://raw.github.com/yantze/dotfiles/master/Makefile -O - | make -- install
master=git://github.com/yantze/dotfiles.git
dest=~/.dotfiles

all: install
install: download zsh vim

install-vim: download vim
install-zsh: download zsh

download:
	@rm -rf $(dest)
	git clone $(master) $(dest)

zsh:
	ln -fs $(dest)/zshrc ~/.zshrc

vim:
	@$(dest)/vimrc/script/link-rc.sh
