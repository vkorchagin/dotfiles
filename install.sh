#!/bin/sh
FILES="dircolors.256dark .vimrc .zshrc.local"

DIR=`dirname $0`
for f in $FILES
do
	ln -bfs $DIR/$f ~/$f
done

ln -bfs $DIR/.tmux.conf ~/.byobu/.tmux.conf
