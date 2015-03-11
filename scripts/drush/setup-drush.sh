#!/usr/bin/sh
# setup drush via composer
cd $HOME
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
php /usr/local/bin/composer global require drush/drush:6.*
# symlink into drush
sudo ln -sf $HOME/.composer/vendor/drush/drush /usr/bin/drush
# add to local path
echo 'export PATH="$PATH:/usr/bin/drush"' >> $HOME/.bashrc
# get drush recipes, honestly how can you do work without it?
drush dl drush_recipes-7.x
# snag drush plugins
drush cook drush_devel --y
