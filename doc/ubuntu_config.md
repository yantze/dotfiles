##一些快捷鍵
命令                    shortkey
command/terminal        CTRL+ALT+T

##必須裝的軟件

sudo apt-get install -y \
silversearcher-ag tmux vim gawk curl wget \
openssh-server

###install flu.x
sudo add-apt-repository ppa:kilian/f.lux
sudo apt-get update
sudo apt-get install fluxgui

###build-essential
sudo apt-get build-essential cmake python-dev


##一些配置

###開機進入命令行模式
sudo vim /etc/X11/default-display-manager
註釋裏面的gdm
在新的一行寫入false即可

sudo apt-get install fonts-ubuntu-font-family-console
setfont /usr/share/consolefonts/UbuntuMono-R-8x16.psf
幾款不錯的字體:
/usr/share/consolefonts/Ethiopian-Goha16.psf.gz
/usr/share/consolefonts/Uni3-Terminus22x11.psf.gz
