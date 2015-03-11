Nittany Vagrant package
==============
###What is this
This is a Vagrant profile for installing a fully functioning Drupal system that mirrors what people at Penn state use to jump start development of new and existing systems.

###How to use this to bring up Nittany Vagrant
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (ensure you are on the latest version 4.3+)
2. Install [Vagrant](http://www.vagrantup.com/downloads.html) (you'll need Vagrant 1.7+)
3. Install [git](http://git-scm.com/downloads) (recommended)
4. Download or Clone (`git clone https://github.com/psudug/nittany-vagrant.git`) this project
5. Add this line to your /etc/hosts (or [windows equivalent](http://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/)) so you can access it "over the web":
```
###Nittany development

# front facing addresses
192.168.18.55      nittany.psudug.dev
```

###Spin up the vagrant instance the first time
```
cd nittany-vagrant
vagrant up
```

###Update the vagrant instance
```
cd nittany-vagrant
vagrant up --provision
```

You can log into this with `user: admin | password: admin`

To connect to the console of your instance: `vagrant ssh`

###Why use this

This project is based on the [Vagrant Project](http://drupal.org/project/vagrant) on Drupal.org, but includes a number of tweaks.

###Other projects of interest / that this is based on

*  [https://github.com/msonnabaum/drupalcon-training-chef-repo](https://github.com/msonnabaum/drupalcon-training-chef-repo)
*  [http://drupal.org/sandbox/mbutcher/1356522](http://drupal.org/sandbox/mbutcher/1356522)
*  [http://drupal.org/project/drush-vagrant](http://drupal.org/project/drush-vagrant)
