# Bitbucket Mercurial to Git migration kit #

### What is it? ###
As you perhaps know, Bitbucket withdraws Mercurial repositories support and pretty soon will remove all Mercurial repositories. In order to still  use Bitbucket service those of you who had been using Mercurial repositories have to convert them to Git. So I wrote a couple of Bash scripts that help to do that.

### Prerequisites ###
* [hggit](https://hg-git.github.io/) `Mercurial` plugin must be installed and set up
* SSH keys Bitbucket authentication must be [set up](https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html)

### How to use it? ###
Follow these steps:
1. Setup `PHP 7.*` and [Composer](https://getcomposer.org/) on your workstation
2. Run `composer install` in `src/php_scripts` folder - it will install libraries needed for PHP scripts
3. Run `convert.sh yourBitbucketAccountPassword`  - it will copy all your Bitbucket Mercurial repositories to Git repositories with names like "git-git_yourMercurialRepositoryName"
4. Check all converted repositories on Bitbucket (with names like "git-git_yourMercurialRepositoryName"), and if everything is Ok then (AND ONLY THEN) do whatever you want with your Bitbucket Mercurial repositories - for example, remove them 

You can also convert repositories in semi-automatized mode - then follow these steps: 
1. Run: `migrate.sh yourBitbucketAccountName yourBitbucketAccountPassword` - it will clone create Mercurial repository in `yourRepositoryName-hg` folder and convert it to a bare Git repository in  `yourRepositoryName-git` folder
2. Create Bitbucket Git repository called `git_yourRepositoryName`
3. Run * `push_to_remote_git.sh yourBitbucketAccountName yourRepositoryName` - it will push local Git repository from `yourRepositoryName-git` folder to a remote Bitbucket Git repository that you created on previous step (unfortunately it seems that Bitbucket doesn't allow to create repositories automatically with scripts - at least for free accounts)
Or just `convert_repo.sh` script that runs sequentially `migrate.sh` and `push_to_remote_git.sh` with provided arguments. You can use it like this `run.sh yourBitbucketAccountName yourRepositoryName`, but do not forget to create Bitbucket Git `git_yourRepositoryName` repository before running it.  

### Disclaimer ###
I do not take responsilbility for any harm or wrong that could be done with these scripts, and I didn't included any intentionally harmful actions there. Just check that yours Mercurial repositories were converted to Git correctly before removing them completely.

### Author ###
* (c) 2020 Sergey Lebedev, licensed under the Apache License, Version 2.0
* Feel free to contact me at:
    * https://habrahabr.ru/users/sunman/
    * http://stackoverflow.com/users/7135046/sergeylebedev
    * https://www.facebook.com/sergei.lebedev.5891   