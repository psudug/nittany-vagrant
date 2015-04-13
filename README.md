Nittany Vagrant package
==============
###What is this
This is a Vagrant profile for installing a fully functioning Drupal system that mirrors what people at Penn state use to jump start development of new and existing systems.

###Why use this
This allows you to jump start development of a Drupal site using modules that the Penn State Drupal User’s Group recommends. While you won’t need everything included here, you will find that you end up using the same modules on almost all build outs. Nittany’s Vagrant server is a great place to learn both about how Drupal and Linux boxes are setup, but also to experiment and practice system administration in a setup similar to those services provided by the VMHosting group (or any other Virtual hosting cluster).

There are more modules then what’s provided here and we’ll be adding more recipes in the future but the intention of this script is to do the heavy lifting of getting a new site up and do so in a standardized manner.

###How to use this to bring up Nittany Vagrant
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (ensure you are on the latest version 4.3+)
2. Install [Vagrant](http://www.vagrantup.com/downloads.html) (you'll need Vagrant 1.7+)
3. Install [git](http://git-scm.com/downloads) (recommended) (you may need to authorize installation on Mac OSX)
4. Add the below statement to your /etc/hosts (or [windows equivalent](http://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/)) so you can access it "over the web" - you _may_ need administrator rights to do this

on OSX:
###Nittany host file addition
Open Terminal
type `sudo vi /etc/hosts` hit `enter`
type `i`
copy and paste below
```
# Nittany Vagrant development address
192.168.18.55      nittany.psudug.dev
```
type `:wq` hit `enter`

If you can't install git (older versions of OSX prevent this):
1. Download this project's zip file and place it in your home directory / move it to the directory just below Downloads
2. double click to Unzip
3. Open terminal
4. type 

###Spin up the vagrant instance
```
git clone https://github.com/psudug/nittany-vagrant.git
cd nittany-vagrant
vagrant up
vagrant ssh
```

The first time you SSH in it will ask you a series of questions trying to drive at the type of site you are building, building out configuration based on your answers.

Now copy and paste this into your browser: http://nittany.psudug.dev

Log in with `user: admin | password: admin`

###SFTP method of management

Vagrant allows you to treat it like it’s a remote server (even though it’s running local to your machine). This allows you to SFTP files to the server using credentials provided in nittany/sftp-config.json.  This works OOTB with Sublime Text if you have the SFTP plugin.

###Git method of management
Nittany puts everything in version control for you (if you tell it to) but it doesn't actually put this on a git server. To do that, you can issue commands like the following (after selecting bitbucket, github or some other git server):
```
# local machine
vagrant ssh

# now logged in
cd nittany
git remote add origin YOURREPOHERE
# make sure we have everything in version control to get up there
git push origin master
```

###Bonus points
If you look in the scripts/_nonvagrant directory you’ll find a script called newserver.sh. This allows you to effectively provision the exact same setup onto *any* server running CentOS 6.x or RHEL 6.x. You can already most likely see why this would be useful (improve nittany-vagrant, get it working everywhere, deploy anywhere on anything using the same development tools you’ve come to use local in this script).
