<?php

use Whoops\Handler\PrettyPageHandler;

require dirname(__DIR__) . '/vendor/autoload.php';

$whoops = new \Whoops\Run;
$handler = new PrettyPageHandler();
foreach (array_keys($_ENV) as $item) {
    $handler->blacklist('_ENV', $item);
}
foreach (array_keys($_SERVER) as $item) {
    $handler->blacklist('_SERVER', $item);
}
$whoops->pushHandler($handler);
$whoops->register();

$dotenv = Dotenv\Dotenv::createImmutable(dirname(__DIR__));
$dotenv->load();

require_once dirname(__DIR__) . '/packages/Database/Eloquent.php';
require_once dirname(__DIR__) . '/packages/Starter.php';
require dirname(__DIR__) . '/application/core/route.php';
require dirname(__DIR__) . '/application/core/API.php';








