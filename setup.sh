#!/usr/bin/env bash

cd $( dirname $0 )

# git modules
git submodule init
git submodule update

# compile gtkrcreload, colort
cd gtkrc-reload-src
make
cd ..

cd colort-src
make
cd ..

# copy acyl dir
[[ ! -d ~/.icons ]] && mkdir ~/.icons
cp -r acyl ~/.icons/acyl

echo "All done!"
