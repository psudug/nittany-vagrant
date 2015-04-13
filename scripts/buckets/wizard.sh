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
# SSH
question="Would you like to setup SSH keys? This will allow your Vagrant instance to talk to servers in the future. This can be important if getting code from remote servers, cloning projects or issuing commands from this server to another."
run='bash /vagrant/scripts/ssh/setup-ssh.sh'
read -p "$question (y/n) " answer
if [ "$answer" = "y" ]; then
  read -p "What is your email you want to use with SSH? " email
  ssh-keygen -t rsa -C "$email"
  dugecho "Now that you have an SSH key, you can run:"
  dugwarn 'ssh-copy-id -i ~/.ssh/id_rsa.pub "-p PORT USER@SERVER"'
  dugecho "enter your password, and bind this VM with a server to help with provisioning in the future (potentially in the next step)"
else
  dugwarn "To run this in the future you can issue: $run"
fi
read -p "Would you like to install drupal? (y/n) " WIZ
# lets keep going with everything
if [ "$WIZ" = "y" ]; then
  touch $HOME/wizard_ran.txt
  # establish drupaling
  dugecho "Glad to hear it, let's get started by installing drupal"
  bash /vagrant/scripts/drupal/setup-drupal.sh $USER $email
  # establish nittany
  question="Would you like to install the nittany baseline? These are a list of community modules and themes that the PSU Drupal User's Group recommends for most sites."
  run='bash /vagrant/scripts/nittany/setup-nittany.sh'
  read -p "$question (y/n) " answer
  if [ "$answer" = "y" ]; then
    $run
  else
    dugwarn "To run this in the future you can issue: $run"
  fi
  # ask about SEO
  question="Would you like some Search Engine Optimization (SEO) enabled? This is important if this site will be publicly accessible and search ranking matters."
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
  question="Would you like a well configured 'What You See Is What You Get' (WYSIWYG) editor? This will install and configure the popular, accessibility minded text editor called CKEditor (4.x)"
  run='drush @nittany cook textbook --y'
  read -p "$question (y/n) " answer
  if [ "$answer" = "y" ]; then
    # we need to get textbook repos before running
    git clone https://github.com/psudug/quail4textbook.git /var/www/html/nittany/sites/all/libraries/quail
    git clone https://github.com/psudug/ckeditor4textbook.git /var/www/html/nittany/sites/all/libraries/ckeditor
    $run
    # add section here to ask about setting Full and/or Filtered HTML Text Formats to CKEditor?
    # or add note that only Textbook format gets setup.
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
  # ask about git
  question="Would you like to start putting all this work in version control? (You really should)"
  run='bash /vagrant/scripts/git/setup-repo.sh'
  read -p "$question (y/n) " answer
  if [ "$answer" = "y" ]; then
    $run
  else
    dugwarn "To run this in the future you can issue: $run"
  fi

  # clear caches so everyone is happy
  drush @nittany cc all
  drupalran="yes"
  else
  drupalran="no"
fi
# ask about front end dev
question="Are you going to be doing front-end development like theme development? If so would you like to install our recommended front end development stack for SASS development?"
run='sudo bash /vagrant/scripts/frontend/setup-frontend-dev.sh'
read -p "$question (y/n) " answer
if [ "$answer" = "y" ]; then
  $run
else
  dugwarn "To run this in the future you can issue: $run"
fi
# ask about phantomjs/access_lint
question="Would you like the ability to create accessibility reports via access_lint? This can help with ensuring you maintain accessibility compliance to keep your website working well for users with disabilities."
run='sudo bash /vagrant/scripts/access_lint/access.sh'
read -p "$question (y/n) " answer
if [ "$answer" = "y" ]; then
  $run
else
  dugwarn "To run this in the future you can issue: $run"
fi
# file existing means this won't execute on ssh login
touch $HOME/wizard_ran.txt

# ask about automatic backups
question="Would you like to set up your site to be automatically backed up? These back ups still live on this server but this can help protect you from yourself :)"
run='sudo bash /vagrant/scripts/backup/backup-setup.sh'
read -p "$question (y/n) " answer
if [ "$answer" = "y" ]; then
  $run
else
  dugwarn "To run this in the future you can issue: $run"
fi

dugecho ""
dugecho "WE ARE"
dugecho "      ___         ___           ___                _____          ___           ___      "
dugecho "     /  /\       /  /\         /__/\              /  /::\        /__/\         /  /\     "
dugecho "    /  /::\     /  /:/_        \  \:\            /  /:/\:\       \  \:\       /  /:/_    "
dugecho "   /  /:/\:\   /  /:/ /\        \  \:\          /  /:/  \:\       \  \:\     /  /:/ /\   "
dugecho "  /  /:/~/:/  /  /:/ /::\   ___  \  \:\        /__/:/ \__\:|  ___  \  \:\   /  /:/_/::\  "
dugecho " /__/:/ /:/  /__/:/ /:/\:\ /__/\  \__\:\       \  \:\ /  /:/ /__/\  \__\:\ /__/:/__\/\:\ "
dugecho " \  \:\/:/   \  \:\/:/~/:/ \  \:\ /  /:/        \  \:\  /:/  \  \:\ /  /:/ \  \:\ /~~/:/ "
dugecho "  \  \::/     \  \::/ /:/   \  \:\  /:/          \  \:\/:/    \  \:\  /:/   \  \:\  /:/  "
dugecho "   \  \:\      \__\/ /:/     \  \:\/:/            \  \::/      \  \:\/:/     \  \:\/:/   "
dugecho "    \  \:\       /__/:/       \  \::               \__\/        \  \::/       \  \::/    "
dugecho "     \__\/       \__\/         \__\/                             \__\/         \__\/     "

dugecho ""
dugecho "If you ever want to run through this wizard again you can either delete ~/wizard_ran.txt or run: bash /vagrant/scripts/buckets/wizard.sh"
dugecho "That's all for now but trust us there's more to come... happy drupaling!"
if [ "$drupalran" = "yes" ]; then
  # print status so they know it lives
  drush @nittany status
  dugecho "==============================="
  dugecho "Now you can login to the site you just created"
  dugwarn "URL: http://nittany.psudug.dev/"
  dugecho "Login details:"
  dugwarn "Username: admin"
  dugwarn "Password: admin"
  dugecho "==============================="
fi
