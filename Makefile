#wget https://raw.github.com/yantze/dotfiles/master/Makefile -O - | make -- install
#please install first:
#yum install vim-common vim-enhanced vim-filesystem vim-minimal
#yum install zsh
#yum install git
#yum install tmux


master=git://github.com/yantze/dotfiles.git
dest=~/.dotfiles

all: install
install: download zsh vim

install-vim: download vim
install-zsh: download zsh
install-all: download zsh vim git tmux

download:
	@rm -rf $(dest)
	git clone $(master) $(dest)
	cd $(dest) && git submodule init && git submodule update

zsh:
	ln -fs $(dest)/zshrc/zshrc ~/.zshrc

vim:
	@$(dest)/vimrc/script/link-rc.sh

git:
	ln -s $(dest)/git/_gitconfig ~/.gitconfig
	ln -s $(dest)/git/_global_ignore ~/.global_ignore

tmux:
	ln -s $(dest)/tmux/tmux.conf ~/.tmux.conf
