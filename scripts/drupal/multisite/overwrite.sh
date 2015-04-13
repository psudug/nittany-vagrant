#!/usr/bin/sh

#perform overwrite preconfig
cd /var/www/html
sitelist="$(find . -maxdepth 1 -type d)"
select site in "$sitelist"
do
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
