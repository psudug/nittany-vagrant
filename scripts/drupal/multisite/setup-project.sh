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
sitedir="nittany"


# Allow user to choose how to install new Drupal site
pickinstall()
{
  options="1.)Create site within existing drupal instance (multisite configuration)\n2.)Create a new drupal instance at your webroot with a vhost configuration\n3.)Delete current drupal instance and overwrite all files "
  read -p "$(echo -e 'You already have a site set up within nittany vagrant! How would you like to install this site?\n'"$options"'Please enter your choice (1,2,3)')" installprofile
  case "$installprofile" in
    1)  multisite
      # For simplicity and safety this option will currently not be available for existing sites. This option will be very limited, but additional functionality may be added later
      # This will currently only allow /var/www/html/nittany to become a multisite config.
      if [[ "$choice" != "1-core-drupal.sh" ]]; then
         dugwarn "You currently cannot pull an existing site into a multisite configuration. Please pick another option."
         pickinstall
      else
        bash multisite.sh drupalpath sitedir
      fi
        ;;
    2)  bash vhost.sh drupalpath sitedir
        ;;
    3)  bash overwrite.sh
        ;;
    #If invalid input recieved
    *)  dugwarn "Invalid input recieved. Please select again. "
        pickinstall
        ;;
  esac
  bash edithosts.sh sitedir
  bash drushalias.sh
  bash $choice $email $drupalpath
}

pickinstall
