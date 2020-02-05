# first argument - your Bitbucket account name, second argument - your repository name
if [ -z "$1" ] || [ -z "$2" ]
then
      echo "Please provide your Bitbucket account name, and repository name"
      exit
fi

BitbucketAccount=$1
Repository=$2

# create variables for the git and hg repository folder names
gitRepoLocalPath="$Repository-git"
gitRepoRemotePath="$BitbucketAccount/git_$Repository.git"

git-remote-url-reachable() { ## Returns errlvl 0 if $1 is a reachable git remote url
    git ls-remote "$1" CHECK_GIT_REMOTE_URL_REACHABILITY >/dev/null 2>&1
}

cd $gitRepoLocalPath

git remote rm origin
git remote add origin git@bitbucket.org:$gitRepoRemotePath

if ! git-remote-url-reachable "origin";
then
    echo "!!! Before pushing to remote git repository, please create it manually at path : $gitRepoRemotePath"
    exit
fi

git push -u origin master

cd ..