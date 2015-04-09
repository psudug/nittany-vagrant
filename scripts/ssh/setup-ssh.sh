#!/bin/bash
# setup ssh or at least guide through doing so
read -p "What is your email you want to use with SSH?" email
ssh-keygen -t rsa -C "$email"
