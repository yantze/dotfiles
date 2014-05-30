#!/bin/bash
cd /var/www/trunkcard
/usr/bin/ctags-exuberant -f ~/.vim/tags \
-h \".php\" -R \
--exclude=\"\.svn\" \
--totals=yes \
--tag-relative=yes \
--PHP-kinds=+cf \
--regex-PHP='/abstract class ([^ ]*)/\1/c/' \
--regex-PHP='/interface ([^ ]*)/\1/c/' \
--regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/'
