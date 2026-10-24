<?php

use Packages\View\handleHttpErrorView;
use Whoops\Run;
use Whoops\Handler\PrettyPageHandler;

$whoops = new Run();
$handler = new PrettyPageHandler();
foreach (array_keys($_ENV) as $item) {
    $handler->blacklist('_ENV', $item);
}
foreach (array_keys($_SERVER) as $item) {
    $handler->blacklist('_SERVER', $item);
}

$whoops->pushHandler($handler);
set_exception_handler(function (\Throwable $e) use ($whoops) {
    $usersShowError = [1];
    $message = $e->getMessage();
    if (str_contains($message, 'Unable to load template') || str_contains($message, 'template not found')) {
        handleHttpErrorView::handle(404);
    }
    $userId = null;
    try {
        $userId = userObject()->userId ?? null;
    } catch (\Throwable $ignored) {

    }
    if ($_ENV['APP_DEBUG'] && in_array($userId, $usersShowError, true)) {
        $whoops->handleException($e);
        return;
    }
    handleHttpErrorView::handle(500);
});