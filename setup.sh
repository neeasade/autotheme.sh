#!/usr/bin/env bash

cd $( dirname $0 )

# git modules
git submodule init
git submodule update

# compile gtkrcreload, colort
cd gtkrc-reload
make
cd ..

cd colort
make
cd ..

# copy acyl dir
[[ -d ~/.icons ]] && mkdir ~/.icons
cp -r acyl ~/icons/acyl

echo "All done!"
