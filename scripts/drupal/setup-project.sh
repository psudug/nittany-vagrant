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

# Store values passed to the script
choice=$1
email=$2

# Set default drupal path
drupalpath="/var/www/html/nittany"
pickinstall()
{
  options="1.)Create site within existing drupal instance (multisite configuration)\n2.)Create a new drupal instance with a vhost configuration\n3.)Delete current drupal instance and overwrite all files "
  read -p "$(echo -e 'You already have a site set up within nittany vagrant! How would you like to install this site?\n'"$options"'Please enter your choice (1,2,3)')" installprofile
  case "$installprofile" in
    1)  multisite
      # For simplicity and safety this option will currently not be available for existing sites. This option will be very limited, but additional functionality may be added later
      # This will currently only allow /var/www/html/nittany to become a multisite config.
      if [[ "$choice" != "1-core-drupal.sh" ]]; then
         dugwarn "You currently cannot pull an existing site into a multisite configuration. Please pick another option."
         pickinstall
      else
        multisite
      fi
        ;;
    2)  vhost
        ;;
    3)  overwrite
        ;;
    #If invalid input recieved
    *)  dugwarn "Invalid input recieved. Please select again. "
        pickinstall
        ;;
  esac
  edithosts
  drushalias
  bash $choice $email $drupalpath
}

multisite(){
  #perform multisite preconfig
  cd /var/www/html/nittany/sites
  read -p "You have chosen to set up a multisite configuration in /var/www/html/nittany/sites. Please the project name, which will be a subdirectory. You may use underscores, but no spaces." subdirectory
  drupalpath="$drupalpath/$subdirectory"
  mkdir $subdirectory
}
vhost(){
  #perform vhost preconfig

}
overwrite(){
  #perform overwrite preconfig
  dugwarn "You are about to recursively remove your site located in /var/www/html/nittany. This will be permanant!"
  read "Are you sure you wish to do this? " confirm
  if [[ confirm == "y" ]]; then
    cd /var/www/html
    sudo rm -Rf nittany
    mkdir nittany
  else
    pickinstall
  fi
}
edithosts(){
  # Scripts to edit the hosts files go here
}
drushalias(){
  # Scripts to create drush alias go here
}
