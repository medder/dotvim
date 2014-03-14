#!/bin/bash

git clone https://github.com/gmarik/vundle.git bundle/vundle

ln -s vimrc ~/.vimrc 
ln -s gvimrc ~/.gvimrc

vim +BundleInstall +qall

