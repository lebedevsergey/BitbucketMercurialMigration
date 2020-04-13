<?php

include "vendor/autoload.php";

use Bitbucket\Api\Repositories;
use Bitbucket\Client;

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
    /**
     * @param array $params
     *
     * @return array
     * @throws \Http\Client\Exception
     *
     */
    public function listWorkspace(string $workspaceName, array $params = [])
    {
        $path = $this->buildRepositoriesPath($workspaceName);
        return $this->get($path, $params);
    }
}

if (count($argv) < 3) {
    echo "Not enough arguments num!\nUsage: " . $argv[0] . " bitbucket_user_name bitbucket_user_password\n";
    die();
}

$bitbucketUserName = $argv[1];
$bitbucketUserPassword = $argv[2];

$client = new ExtendedClient();
$client->authenticate(Client::AUTH_HTTP_PASSWORD, $bitbucketUserName, $bitbucketUserPassword);
$repositories = $client->repositories()->listWorkspace($bitbucketUserName);

foreach ($repositories['values'] as $item) {
    if ($item['scm'] !== 'hg') {
        continue;
    }

    echo strtolower($item['name']) . ' ';
}

