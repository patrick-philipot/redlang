#! /bin/bash

function addcommitpush () {

current=$(git branch | grep "*" | cut -b 3-)
message=\'"$@"\'

clear
echo -------------------------------------------------
echo -------------------------------------------------
echo Commit to branch: $current with message: $message

read -p "Do you want to proceed? (y/n) " yn
case $yn in
    [Yy]* ) echo "Proceeding...";;
    [Nn]* ) echo "Exiting..."; exit;;
    * ) echo "Please answer yes or no.";;
esac

git add -A && git commit -a -m "$message"
git push origin main

# echo "Where to push?"
# read -i "$current" -e branch

# echo "You sure you wanna push? (y/n)"
# read -i "y" -e yn

# if [ "$yn" = y ]; then
#   git push origin "$branch"
# else
#   echo "Have a nice day!"
# fi

}

addcommitpush $1