#!/usr/bin/sh

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

choice=$1
email=$2
drupalpath=$3

pickinstall()
{
  options="1.)Create site within existing drupal instance (multisite configuration)\n2.)Create a new drupal instance with a vhost configuration\n3.)Delete current drupal instance and overwrite all files $(dugwarn "This will be permanant!")\n"
  read -p "$(echo -e 'You already have a site set up within nittany vagrant! How would you like to install this site?\n'"$options"'Please enter your choice (1,2,3)')" installprofile
  case "$installprofile" in
    1)  multisite
        ;;
    2)  vhost
        ;;
    3)  overwrite
        ;;
    #If invalid input recieved
    *)  pickinstall
        ;;
  esac
  bash $choice $email $drupalpath
}

multisite(){
  #perform multisite preconfig

}
vhost(){
  #perform vhost preconfig

}
overwrite(){
  #perform overwrite preconfig

}
