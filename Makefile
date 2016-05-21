#wget https://raw.github.com/yantze/dotfiles/master/Makefile -O - | make -- install


dotfiles=git://github.com/yantze/dotfiles.git
dest=~/.dotfiles
ohmyzsh=https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
autojump=git://github.com/joelthelion/autojump.git


all help: 
	@echo Dotfiles manual
	@echo
	@echo st-update    - subtree pull and push all prefix, vimrc,module/wiki.
	@echo pull         - pull current repo.
	@echo push         - push current repo.
	@echo tmux 		   - ln tmux.
	@echo zshrc 	   - ln zshrc.
	@echo vim   	   - ln vimrc.
	@echo git	 	   - ln git.
	@echo emacs	 	   - install emacs configs.

install:
	sudo yum install vim-common vim-enhanced vim-filesystem vim-minimal ctags
	sudo yum install emacs-common emacs-filesystem emacs-nox
	sudo yum install zsh
	sudo yum install tmux
	sudo yum install git

config: tmux git zshrc

zshrc:
	ln -s ~/.dotfiles/zshrc/zshrc ~/.zshrc

vim:
	# $(dest)/vimrc/script/install_rc.sh
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	#install Bundle's Plugin
	vim +BundleInstall +qall

emacs:
	git clone https://github.com/purcell/emacs.d ~/.emacs.d

git:
	ln -s $(dest)/git/_gitconfig ~/.gitconfig
	ln -s $(dest)/git/_global_ignore ~/.global_ignore


prezto:
	setopt EXTENDED_GLOB
	ls -s $(dest)/module/prezto ~/.zprezto
	for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
		ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
	done

tmux:
	ln -s $(dest)/tmux/tmux.conf ~/.tmux.conf

pull: repo-pull st-pull

push: repo-push st-push

pyenv:
	curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

repo-pull:
	git pull

repo-push:
	git add . -A
	git commit -a
	git push

st-update: st-pull st-push

st-pull:
	git subtree pull --prefix wiki https://github.com/yantze/wiki.git master --squash
	git subtree pull --prefix vimrc https://github.com/yantze/vimrc master --squash

st-push:
	git subtree push --prefix wiki https://github.com/yantze/wiki.git master --squash
	git subtree push --prefix vimrc https://github.com/yantze/vimrc master --squash


ohmyzsh:
	wget -O - $(ohmyzsh) | sh

