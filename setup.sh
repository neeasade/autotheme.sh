#!/usr/bin/env bash
# setup things for autotheme.sh

cd $( dirname $0 )/auto

# git modules
git submodule init
git submodule update

# setup urnn
cd urnn
./setup.sh
cd ..

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
