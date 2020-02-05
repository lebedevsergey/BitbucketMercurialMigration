# Bitbucket Mercurial to Git migration kit #

### What is it? ###
As you perhaps know, Bitbucket withdraws Mercurial repositories support and pretty soon will remove all Mercurial repositories. In order to still  use Bitbucket service those of you who had been using Mercurial repositories have to convert them to Git. So I wrote a couple of Bash scripts that help to do that.

### Prerequisites ###
* [hggit](https://hg-git.github.io/) `Mercurial` plugin must be installed and set up
* SSH keys Bitbucket authentication must be [set up](https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html)

### How to use it? ###
Follow these steps:
1. Run: `migrate.sh yourBitbucketAccountName yourRepositoryName` - it will clone create Mercurial repository in `yourRepositoryName-hg` folder and convert it to a bare Git repository in  `yourRepositoryName-git` folder
2. Create Bitbucket Git repository called `git_yourRepositoryName`
3. Run * `push_to_remote_git.sh yourBitbucketAccountName yourRepositoryName` - it will push local Git repository from `yourRepositoryName-git` folder to a remote Bitbucket Git repository that you created on previous step (unfortunately it seems that Bitbucket doesn't allow to create repositories automatically with scripts - at least for free accounts)

For your convenience there is also `run.sh` script that runs sequentially `migrate.sh` and `push_to_remote_git.sh` with provided arguments. You can use it like this `run.sh yourBitbucketAccountName yourRepositoryName`, but do not forget to create Bitbucket Git `git_yourRepositoryName` repository before running it.  

* (c) 2020 Sergey Lebedev
* Feel free to contact me at:
    * https://habrahabr.ru/users/sunman/
    * http://stackoverflow.com/users/7135046/sergeylebedev
    * https://www.facebook.com/sergei.lebedev.5891
