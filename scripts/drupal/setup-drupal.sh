#!/usr/bin/sh
# go to web root
cd /var/www/html/
# vagrant user or passed in
if [ -z $1 ]; then
    owner='vagrant'
  else
    owner=$1
fi
# email address to use or example
if [ -z $2 ]; then
    email='example@example.example'
  else
    email=$2
fi

if [[ -z $drupalpath ]]; then
  drupalpath="nittany"
fi

# find all files that are bash scripts here
IFS=$'\r\n' GLOBIGNORE='*' :; files=($(find /vagrant/scripts/drupal/distros/*.sh))
echo $files
# render the menu options
menuitems() {
  echo "Available options:"
  for i in ${!files[@]}; do
   val=`sed -n '2p' ${files[i]}`
    echo $((i+1)) "$val"
  done
  [[ "$msg" ]] && echo "" && echo "$msg"; :
}

# prompt the user
prompt="Enter an option: "
while menuitems && read -rp "$prompt" num && [[ "$num" ]]; do
  (( num > 0 && num <= ${#files[@]} )) || {
      msg="Invalid option: $num"; continue
  }
  # if we got here it means we have valid input
  ((num--)); choice="${files[num]}"

  # Check to see if there is already an existing site
  if [[ ! "$(ls -A /var/www/html/nittany)" ]]; then
    read -p "Where would you like to install drupal? [ /var/www/html/nittany ] " drupalpath
    bash $choice $email $drupalpath
  else
    bash /vagrant/scripts/drupal/multisite/setup-project.sh $choice $email
  fi

  bash /vagrant/scripts/drupal/drupal-cleanup.sh
  exit
done
