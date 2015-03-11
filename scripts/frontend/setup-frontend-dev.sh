#!/usr/bin/sh

sudo npm install -g bower
sudo npm install -g gulp
sudo npm install -g gulp-hologram
sudo npm install -g grunt-cli
sudo gem install bundler
git clone https://github.com/heyMP/frontend-dev.git
cd frontend-dev
sudo npm install
bower install
bundle install
gulp build
