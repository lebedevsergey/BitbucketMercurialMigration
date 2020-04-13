#!/bin/bash
# migrates remote Mercurial repository to local Git repository
# first argument - Bitbucket account name, second argument - Mercurial repository to convert

if [ -z "$1" ] || [ -z "$2" ]
then
      echo "Usage: $0 <bitbucket_user_name> <bitbucket_mercurial_repository_name>"
      exit
fi

BitbucketAccount=$1
Repository=$2

# create variables for the git and hg repository folder names
BitbucketPath="hg@bitbucket.org/$BitbucketAccount"

gitRepoLocalPath="$Repository-git"

hgRepoLocalPath="$Repository-hg"
hgRepoRemotePath="ssh://$BitbucketPath/$Repository"

# check if hg repository exists
hg identify $hgRepoRemotePath;
if [ $? -eq 255 ] 
then
  exit
fi

# clone the hg repository from Bitbucket
hg clone $hgRepoRemotePath $hgRepoLocalPath
cd $hgRepoLocalPath

# create .gitignore from .hgignore
cp .hgignore .gitignore
hg add .gitignore --config ui.username=$0
#rm .hgignore
#hg forget .hgignore --config ui.username=$0
hg commit -m'.gitignore file added' --config ui.username=$0

# create an hg branch
hg bookmark -r default master

# create a new bare git repository
git init --bare ../$gitRepoLocalPath

# push the hg repository to the local git repository
hg push ../$gitRepoLocalPath

cd ..

