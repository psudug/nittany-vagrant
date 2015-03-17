#!/bin/bash
# provide messaging colors for output to console
txtbld=$(tput bold)             # Bold
bldgrn=$(tput setaf 2) #  green
bldred=${txtbld}$(tput setaf 1) #  red
txtreset=$(tput sgr0)
dugecho(){
  echo "${bldgrn}$1${txtreset}"
}
dugwarn(){
  echo "${bldred}$1${txtreset}"
}

read -p "Would you like a wizard to guide you through this process? (y/n) " WIZ
# lets keep going with everything
if [ "$WIZ" = "y" ]; then
  touch $HOME/wizard_ran.txt
  dugecho "Glad to hear it, let's get started"
  # ask about SEO
  question="Would you like your site to come equipped with Search Engine Goodness?"
  run='drush @nittany cook seo --y'
  read -p "$question (y/n) " answer
  if [ "$answer" = "y" ]; then
    $run
    # issue with directory ownership run from here
    sudo chown -R $USER:apache /var/www/html/nittany/sites/default/files
  else
    dugwarn "To run this in the future you can issue: $run"
  fi

  # ask about wysiwyg
  question="Would you like your site to come with CKEditor 4.x setup already?"
  run='drush @nittany cook textbook --y'
  read -p "$question (y/n) " answer
  if [ "$answer" = "y" ]; then
    # we need to get textbook repos before running
    git clone https://github.com/psudug/quail4textbook.git /var/www/html/nittany/sites/all/libraries/quail
    git clone https://github.com/psudug/ckeditor4textbook.git /var/www/html/nittany/sites/all/libraries/ckeditor
    $run
  else
    dugwarn "To run this in the future you can issue: $run"
  fi

  # ask about media handling
  #question="Would you like your site to come equipped with our recommended media handling?"
  #run='drush -y @nittany cook nittany_media'
  #read -p "$question (y/n) " answer
  #if [ "$answer" = "y" ]; then
  #  $run
  #else
  #  dugwarn "To run this in the future you can issue: $run"
  #fi

  # ask about theme
  #question="Would you like to use Zurb foundation instead of the lame default drupal theme?"
  # @todo in the future we'll ask what theme
  #drush @nittany cook nittany_theme --skip-confirm
  #run='drush @nittany cook zurb_foundation --skip-confirm'
  #read -p "$question (y/n) " answer
  #if [ "$answer" = "y" ]; then
  #  $run
  #else
  #  dugwarn "To run this in the future you can issue: $run"
  #fi
else
  dugecho "Awesome enjoy building the future! :)"
fi
# file existing means this won't execute on ssh login
touch $HOME/wizard_ran.txt
# clear caches so everyone is happy
drush @nittany cc all
# print status so they know it lives
drush @nittany status
dugecho "If you ever want to run through this wizard again you can either delete ~/wizard_ran.txt or run: bash /vagrant/scripts/buckets/wizard.sh"
dugecho "That's all for now but trust us there's more to come... happy drupaling!"
dugecho ""
dugecho "http://nittany.psudug.dev/"
dugecho "Login: admin / admin"
dugecho ""
dugecho "WE ARE"
dugecho ":::::::::   ::::::::  :::    :::      :::::::::  :::    :::  ::::::::  "
dugecho ":+:    :+: :+:    :+: :+:    :+:      :+:    :+: :+:    :+: :+:    :+: "
dugecho "+:+    +:+ +:+        +:+    +:+      +:+    +:+ +:+    +:+ +:+        "
dugecho "+#++:++#+  +#++:++#++ +#+    +:+      +#+    +:+ +#+    +:+ :#:        "
dugecho "+#+               +#+ +#+    +#+      +#+    +#+ +#+    +#+ +#+   +#+# "
dugecho "#+#        #+#    #+# #+#    #+#      #+#    #+# #+#    #+# #+#    #+# "
dugecho "###         ########   ########       #########   ########   ########  "

