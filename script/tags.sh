#!/bin/bash
exec ctags -f ~/.vim/vimfiles/resource/tags-php \
    -h ".php" -R \
    --exclude="\.svn" \
    --totals=yes \
    --tag-relative=yes \
    --PHP-kinds=+cf \
    --fields=+l \
    --regex-PHP='/abstract class ([^ ]*)/\1/c/' \
    --regex-PHP='/interface ([^ ]*)/\1/c/' \
    --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/' \
    # --regex-PHP='/(public |static )+function ([^ (]*)/\2/f/' \
    --exclude='*frontend/gesca/shared/frontend_data/*' \
    --exclude='*.js' \
    --exclude='*.html'
