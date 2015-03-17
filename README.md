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
vagrant ssh (This will run a setup script for your instance of Drupal.)
```
Point your browser to http://nittany.psudug.dev

Log into this with `user: admin | password: admin`

To connect to the console of your instance: `vagrant ssh`

###Update the vagrant instance
```
cd nittany-vagrant
vagrant up --provision
```

###SFTP method of management

Vagrant allows you to treat it like it’s a remote server (even though it’s running local to your machine). This allows you to SFTP files to the server using credentials provided in nittany/sftp-config.json.  This works OOTB with Sublime Text if you have the SFTP plugin.

###Why use this
This allows you to jump start development of a Drupal site using modules that the Penn State Drupal User’s Group recommends. While you won’t need everything included here, you will find that you end up using the same modules on almost all build outs. Nittany’s Vagrant server is a great place to learn both about how Drupal and Linux boxes are setup, but also to experiment and practice system administration in a setup similar to those services provided by the VMHosting group (or any other Virtual hosting cluster).

There are more modules then what’s provided here and we’ll be adding more recipes in the future but the intention of this script is to do the heavy lifting of getting a new site up and do so in a standardized manner.

###Bonus points
If you look in the scripts/_nonvagrant directory you’ll find a script called newserver.sh. This allows you to effectively provision the exact same setup onto *any* server running CentOS 6.x or RHEL 6.x. You can already most likely see why this would be useful (improve nittany-vagrant, get it working everywhere, deploy anywhere on anything using the same development tools you’ve come to use local in this script).