# first argument - your Bitbucket account name, second argument - your repository name
if [ -z "$1" ] || [ -z "$2" ]
then
      echo "Please provide your Bitbucket account name, and repository name"
      exit
fi

./migrate.sh $1 $2
./push_to_remote_git.sh $1 $2