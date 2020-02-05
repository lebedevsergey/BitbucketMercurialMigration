# first argument - your Bitbucket account name, second argument - your repository name
if [ -z "$1" ] || [ -z "$2" ]
then
      echo "Please provide your Bitbucket account name, and repository name"
      exit
fi

BitbucketAccount=$1
Repository=$2

# create variables for the git and hg repository folder names
BitbucketPath="$BitbucketAccount@bitbucket.org/$BitbucketAccount"

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

# create a new bare git repository
git init --bare $gitRepoLocalPath

cd $hgRepoLocalPath
# create an hg branch
hg bookmark -r default master

# push the hg repository to the local git repository
hg push ../$gitRepoLocalPath

cd ..

