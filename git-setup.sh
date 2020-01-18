#!/usr/bin/env bash
# Configure git to use youre username and email

echo
read -p "Enter git username: " username
while [ -z $username ]
do
        read -p "Error! Please enter your git username: " username
done
echo
echo "Git username set to $username"
echo

read -p "Enter git email: " gitemail
while [ -z $gitemail ]
do
        read -p "Error! Please enter git email: " gitemail
done
echo
echo "Computer name set as $gitemail"
echo

git config --global user.name "$username"
git config --global user.email "$gitemail"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=31536000'