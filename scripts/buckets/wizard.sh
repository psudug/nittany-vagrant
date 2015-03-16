#!/bin/bash
#@todo set up all the recipes to call based on this flow or better yet something more elegant...
read -p "Would you like a wizard to guide you through this process? (y/n) " WIZ
if [ "$WIZ" = "n" ]; then
  touch $HOME/wizard_ran.txt
  echo "Awesome enjoy building the future! :)"
  return
fi
# lets keep going with everything
if [ "$WIZ" = "y" ]; then
  touch $HOME/wizard_ran.txt
  echo "Glad to hear it, let's get started"
fi
# ask about SEO
question="Would you like your site to come equipped with Search Engine Goodness?"
run='drush -y @nittany cook seo'
read -p "$question (y/n) " answer
if [ "$answer" = "y" ]; then
  $run
else
  echo "run this in the future: $run"
fi

# ask about media handling
#question="Would you like your site to come equipped with our recommended media handling?"
#run='drush -y @nittany cook nittany_media'
#read -p "$question (y/n) " answer
#if [ "$answer" = "y" ]; then
#  $run
#else
#  echo "run this in the future: $run"
#fi

# ask about theme
#drush @nittany cook nittany_theme --skip-confirm

echo "that's all for now but trust us there's more to come... happy drupaling!"
