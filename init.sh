#!/bin/bash

# Useful helper function, adapted from of https://gist.github.com/dciccale/5560837
function parse_git_hash() {
  git rev-parse HEAD 2> /dev/null | sed "s/\(.*\)/\1/"
}

echo
read -p "What should the folder name be for this project? " DIRNAME
echo "Creating directory '$DIRNAME'..."
mv loutky $DIRNAME
cd $DIRNAME

echo "Creating Sublime project files..."
mv loutky.sublime-project $DIRNAME.sublime-project

echo "Creating Git repository..."
GIT_HASH=$(parse_git_hash)
rm -rf .git
git init

echo "Ignoring Sublime project files..."
echo >> .git/info/exclude
echo "*.sublime-project" >> .git/info/exclude
echo "*.sublime-workspace" >> .git/info/exclude

echo "Removing setup script..."
rm init.sh

echo "Creating first commit..."
git add .
git commit -am "Loutky boilerplate @ ${GIT_HASH}"

echo
read -p "Install package dependencies now? [y/n] " -n 1 -r INSTALL_NOW
echo
if [[ $INSTALL_NOW =~ ^[Yy]$ ]]
then
  echo "Installing package dependencies..."
  npm install
fi

echo
echo "Loutky project installed to ./$DIRNAME!"
