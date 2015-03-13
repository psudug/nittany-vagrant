#!/usr/bin/sh

yes | sudo npm install -g bower
yes | sudo npm install -g gulp
yes | sudo npm install -g gulp-hologram
yes | sudo npm install -g grunt-cli
yes | sudo gem install bundler
git clone https://github.com/heyMP/frontend-dev.git
cd frontend-dev
yes | sudo npm install
yes | bower install
yes | bundle install
yes | gulp build
