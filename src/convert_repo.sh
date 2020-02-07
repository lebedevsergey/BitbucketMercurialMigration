#!/bin/bash
# semi-automatic script to convert Bitbucket Mercurial repository to Git
# first argument - Bitbucket account name, second argument - Mercurial repository to convert
# requres manually creating Git repository on Bitbucket with a name like: "git-<your_bitbucket_mercurial_repository_name>"

if [ -z "$1" ] || [ -z "$2" ]
then
      echo "Usage: $0 <bitbucket_user_name> <bitbucket_mercurial_repository_name>"
      exit
fi

./migrate.sh $1 $2
./push_to_remote_git.sh $1 $2

#cleanup temp local repos
hgRepoLocalPath="$2-hg"
gitRepoLocalPath="$2-git"
rm -rf ./$gitRepoLocalPath
rm -rf ./$hgRepoLocalPath