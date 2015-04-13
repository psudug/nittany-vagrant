#!/usr/bin/sh
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
txtreset=$(tput sgr0)
dugwarn(){
  echo "${bldred}$1${txtreset}"
}

#perform overwrite preconfig
cd /var/www/html
sitelist=$(find . -maxdepth 1 -type d)
PS3="Type a number or 'q' to quit: "
select site in $sitelist; do
  dugwarn "You are about to recursively remove your site located in /var/www/html/$site. This will be permanant!"
  read "Are you sure you wish to do this? " confirm
  if [[ confirm == "y" ]]; then
    sudo rm -Rf "$site"
    mkdir "$site"
  else
    source setup-project.sh
    pickinstall
  fi
done
