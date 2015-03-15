#!/bin/bash
#@todo set up all the recipes to call based on this flow or better yet something more elegant...
read -p "Would you like a wizard to guide you through this process? (y/n) " WIZ
if [ "$WIZ" = "n" ];then
  touch $HOME/wizard_ran.txt
  echo "Awesome you must really know what you are doing. :)"
  return
fi

if [ "$WIZ" = "y" ];then
  touch $HOME/wizard_ran.txt
  echo "Glad to hear it, let's get started"
fi

read -p "Would you like your site to come equipped with Search Engine Goodness? (y/n) " SEO
if [ "$SEO" = "y" ];then
  drush -y @nittany cook seo
fi

if [ "$SEO" = "n" ];then
  echo "yeah who cares about search engines anyway"
fi

echo "that's all for now but trust us there's more to come... happy drupaling!"
