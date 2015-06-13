#!/bin/bash

# Useful helper function, adapted from of https://gist.github.com/dciccale/5560837
function parse_git_hash() {
  git rev-parse --short HEAD 2> /dev/null | sed "s/\(.*\)/\1/"
}

read -p "What should the folder name be for this project?" $dirname
echo "Creating directory '$dirname'..."
mv loutky $dirname
cd $dirname

echo "Creating Sublime project files..."
mv loutky.sublime-project $dirname.sublime-project

echo "Creating Git repository..."
GIT_HASH=$(parse_git_hash)
rm -rf .git
git init

echo "Ignoring Sublime project files..."
echo "" >> .git/info/exclude
echo "*.sublime-project" >> .git/info/exclude
echo "*.sublime-workspace" >> .git/info/exclude

echo "Creating first commit..."
git add .
git commit -m 'Loutky boilerplate @ ${GIT_HASH}'

echo "Removing setup script..."
rm init.sh

echo "Installing package dependencies..."
npm install

echo ""
echo "Loutky project installed!"
