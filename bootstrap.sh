#!/usr/bin/env sh

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}

echo "Thanks for installing pw-vim"

# Backup existing .vim stuff
echo "backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done

endpath="$( cd "$( dirname "$0" )" && pwd)"

if [ ! -e $endpath/.git ]; then
    endpath="$HOME/.pw-vim"
    echo "cloning pw-vim"
    git clone --recursive git://github.com/perfectworks/pw-vim.git $endpath
else
    echo "updating pw-vim"
    cd $endpath && git pull
fi


echo "setting up symlinks"
lnif $endpath/.vimrc $HOME/.vimrc
lnif $endpath/.vimrc.fork $HOME/.vimrc.fork
lnif $endpath/.vimrc.bundles $HOME/.vimrc.bundles
lnif $endpath/.vimrc.bundles.fork $HOME/.vimrc.bundles.fork
lnif $endpath/.vim $HOME/.vim
if [ ! -d $endpath/.vim/bundle ]; then
    mkdir -p $endpath/.vim/bundle
fi

if [ ! -e $HOME/.vim/bundle/neobundle ]; then
    echo "Installing NeoBundle"
    git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
fi

echo "update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $endpath/.vimrc.bundles +NeoBundleInstall! +NeoBundleClean +qall
(cd $HOME/.vim/bundle/vimproc.vim && make)
export SHELL=$system_shell
