#!/bin/bash
# pushes local Git repository to remote Bitbucket Git repository
# do not forget to create it manually in advance
# first argument - Bitbucket account name, second argument - Git repository to push

if [ -z "$1" ] || [ -z "$2" ]
then
      echo "Usage: $0 <bitbucket_user_name> <git_repository_to_push_name>"
      exit
fi

BitbucketAccount=$1
Repository=$2
REPOSITORY_PING_MAX_NUM=5

# create variables for the git and hg repository folder names
gitRepoLocalPath="$Repository-git"
gitRepoRemotePath="$BitbucketAccount/git_$Repository.git"

git-remote-url-reachable() { ## Returns errlvl 0 if $1 is a reachable git remote url
    git ls-remote "$1" CHECK_GIT_REMOTE_URL_REACHABILITY >/dev/null 2>&1
}

cd $gitRepoLocalPath

git remote rm origin
git remote add origin git@bitbucket.org:$gitRepoRemotePath


for i in `seq 1 $REPOSITORY_PING_MAX_NUM`
do
  if git-remote-url-reachable "origin";
  then
    break
  else
    if [ "$i" -ge "$REPOSITORY_PING_MAX_NUM" ]
    then
      echo "!!! Before pushing to remote git repository, please create it at path : $gitRepoRemotePath"
      exit
    fi
    echo "Probing remote git repository: $gitRepoRemotePath"
    sleep 2
  fi
done


git push -u origin master

cd ..