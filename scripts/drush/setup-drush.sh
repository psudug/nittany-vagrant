#!/usr/bin/sh
# setup drush via composer
cd $HOME
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
php /usr/local/bin/composer global require drush/drush:6.*
# symlink into drush
sudo ln -sf $HOME/.composer/vendor/drush/drush /usr/bin/drush
# add to local path
echo 'export PATH="$PATH:/usr/bin/drush"' >> $HOME/.bashrc
# reload bashrc so drush calls can function
source .bashrc
# get drush recipes so it can do most of the heavy lifting / boring parts
drush dl drush_recipes-7.x-1.x
drush cc drush
# snag drush plugins
drush cook devel_drush --y
# pull in the alias file
cp /vagrant/scripts/drush/files/nittany.aliases.drushrc.php .drush/nittany.aliases.drushrc.php
