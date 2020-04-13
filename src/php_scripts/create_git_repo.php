<?php

include "vendor/autoload.php";

use Bitbucket\Api\Repositories;
use Bitbucket\Client;
use Bitbucket\Exception\BadRequestException;

class ExtendedClient extends Client
{
    /**
     * @return \Bitbucket\Api\Repositories
     */
    public function repositories()
    {
        return new ExtendedRepositories($this->getHttpClient());
    }
}

class ExtendedRepositories extends Repositories
{
    public function create(string $workspaceName, string $repoName, array $params = [])
    {
        $path = $this->buildRepositoriesPath($workspaceName, $repoName);

        return $this->post($path, $params);
    }
}

if (count($argv) < 4) {
    echo "Not enough arguments num!\nUsage: " . $argv[0] . " <repository_to_create_name>  <bitbucket_user_name> <bitbucket_user_password>\n";
    die();
}

$repoToCreateName = $argv[1];
$bitbucketUserName = $argv[2];
$bitbucketUserPassword = $argv[3];

$client = new ExtendedClient();
$client->authenticate(Client::AUTH_HTTP_PASSWORD, $bitbucketUserName, $bitbucketUserPassword);

echo "Trying to create Git repository: $repoToCreateName\n";
try {
    $client->repositories()->create($bitbucketUserName, $repoToCreateName, ['scm' => 'git']);
} catch (BadRequestException $e) {
    echo "Error: " . $e->getMessage() . ": $repoToCreateName" . $e->getTraceAsString() . "\n";
    return;
}

echo "Created Git repository: $repoToCreateName\n";


