#wget https://raw.github.com/yantze/dotfiles/master/Makefile -O - | make -- install
#please install below first:
#yum install vim-common vim-enhanced vim-filesystem vim-minimal ctags
#yum install zsh
#yum install git
#yum install tmux


dotfiles=git://github.com/yantze/dotfiles.git
dest=~/.dotfiles
ohmyzsh=https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
autojump=git://github.com/joelthelion/autojump.git

all: install-all

install-vim: download vim
install-zsh: download ohmyzsh autojump zsh
install-all: download zsh vim git tmux

download:
	@rm -rf $(dest)
	git clone $(dotfiles) $(dest)
	cd $(dest) && git submodule update --init

zsh:
	ln -s $(dest)/zshrc/zshrc ~/.zshrc

ohmyzsh:
	wget -O - $(ohmyzsh) | sh

autojump:
	git clone $(autojump) ~/.autojump
	cd .autojump && ./install.py


vim:
	@$(dest)/vimrc/script/link-rc.sh

git:
	ln -s $(dest)/git/_gitconfig ~/.gitconfig
	ln -s $(dest)/git/_global_ignore ~/.global_ignore

tmux:
	ln -s $(dest)/tmux/tmux.conf ~/.tmux.conf

prezto:
	setopt EXTENDED_GLOB
	ls -s $(dest)/module/prezto ~/.zprezto
	for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
		ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
	done

