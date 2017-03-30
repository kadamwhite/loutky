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

echo
echo "Next, let's gather a little information about your project."
echo
read -p "What should the project name be for this project? (no spaces) " PROJECTNAME
echo
read -p "Provide a description of this project for package.json: " PROJECTDESC
echo
read -p "Provide a project author for package.json: " AUTHOR
echo
# `-i ''` transforms in-place without making a backup
sed -i '' -e "s/INSERT_PROJECT_NAME/$PROJECTNAME/" \
          -e "s/INSERT_PROJECT_DESCRIPTION/$PROJECTDESC/" \
          -e "s/INSERT_AUTHOR_NAME/$AUTHOR/" \
          package.json

echo "package.json updated!"

echo
read -p "What should the HTML <title> attribute show? " HTMLTITLE
sed -i '' -e "s/INSERT_PROJECT_TITLE/$HTMLTITLE/" src/index.html

# `-i ''` transforms in-place without making a backup
sed -i '' -e "s/INSERT_PROJECT_DESCRIPTION/$PROJECTDESC/" \
          -e "s/INSERT_PROJECT_TITLE/$HTMLTITLE/" \
          BASICREADME.md
mv BASICREADME.md README.md

echo "README.md initialized!"

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
