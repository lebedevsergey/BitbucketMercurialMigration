# Bitbucket Mercurial to Git migration kit #

### What is it? ###
Bitbucket withdraws Mercurial repositories support and pretty soon will remove Mercurial repositories completely. In order to still  use Bitbucket service those of you who had been using Mercurial repositories have to convert them to Git. Here is a couple of Bash and PHP scripts that helps to migrate Bitbucket Mercurial repositories to Git.

**Warning**: This utility creates public git versions of your private hg repos. Do not forget to make them private in repo settings at [bitbucket.org](https://bitbucket.org).

### Prerequisites ###
* [hggit](https://hg-git.github.io/) `Mercurial` plugin must be installed and set up
* `PHP 7.*` and [Composer](https://getcomposer.org/) must be installed
* SSH keys Bitbucket authentication must be [set up](https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html)

### How to use it? ###
Follow these steps:
1. Run `composer install` in `src/php_scripts` folder - it will install libraries needed for PHP scripts
2. Run `convert.sh yourBitbucketAccount yourBitbucketPassword` - this will copy all your Bitbucket Mercurial repositories to Git repositories with names like "git_originalMercurialRepositoryName"
3. Thoroughly check all converted repositories on Bitbucket (with names like "git-git_yourMercurialRepositoryName"), and if everything is OK then (AND ONLY THEN) do whatever you want with your Bitbucket Mercurial repositories - for example, remove them 

You can also convert repositories in semi-automatized mode - follow these steps: 
1. Run: `migrate.sh yourBitbucketAccountName yourBitbucketAccountPassword` - it will clone create Mercurial repository in `yourRepositoryName-hg` folder and convert it to a bare Git repository in  `yourRepositoryName-git` folder
2. Manually create Bitbucket Git repository called `git_yourRepositoryName`
3. Run * `push_to_remote_git.sh yourBitbucketAccountName yourRepositoryName` - it will push local Git repository from `yourRepositoryName-git` folder to a remote Bitbucket Git repository that you created on previous step
Or just `convert_repo.sh` script that runs sequentially `migrate.sh` and `push_to_remote_git.sh` with provided arguments. You can use it like this `run.sh yourBitbucketAccountName yourRepositoryName`, but do not forget to create Bitbucket Git `git_yourRepositoryName` repository before running it.  

### Disclaimer ###
I do not take any responsibility for any harm that could be done with these scripts to your repositories, however I didn't included any intentionally harmful actions in them. Just carefully check that yours Mercurial repositories were correctly converted to Git before repositories removing originals repositories.

### Author ###
* (c) 2020 Sergey Lebedev, licensed under the Apache License, Version 2.0
* Feel free to contact me at:
    * https://habrahabr.ru/users/sunman/
    * http://stackoverflow.com/users/7135046/sergeylebedev
    * https://www.facebook.com/sergei.lebedev.5891   
