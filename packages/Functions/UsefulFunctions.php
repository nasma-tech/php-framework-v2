<?php

use App\Controllers\users\users;
use JetBrains\PhpStorm\NoReturn;

function userObject($showKeys = false): object|array
{
    $user = new users();
    if ($showKeys) {
        $array = [];
        foreach (get_object_vars($user::userObject()) as $key => $item) {
            $array[] = $key;
        }
        return $array;
    } else {
        return $user::userObject();
    }
}

function var_print($value): void
{
    echo "<pre>";
    print_r($value);
    echo "</pre>";
}


function dynamicRoute($router, string $controllerClass, ?array $customRoutes = null): void
{
    if (!class_exists($controllerClass)) {
        throw new Exception("Controller class '{$controllerClass}' not found.");
    }

    $reflection = new ReflectionClass($controllerClass);

    $controllerParts = explode("\\", $reflection->name);
    unset($controllerParts[3]);

    $methods = $reflection->getMethods(ReflectionMethod::IS_PUBLIC);
    $routes = [];

    foreach ($methods as $method) {
        $methodName = $method->getName();

        if (in_array($methodName, [
            '__construct', '__call', 'getModel', 'setModel', 'jsonResponseSuccess', 'jsonResponseFailed',
            'requestArray', 'handleFileUpload', 'changeRequestValues', 'getModelInstance', 'runMigrate', 'validateCSRF'
        ])) continue;

        $httpMethod = match (true) {
            str_starts_with($methodName, 'main') => 'GET',
            str_starts_with($methodName, 'addIndex') => 'GET',
            str_starts_with($methodName, 'editIndex') => 'GET',
            str_starts_with($methodName, 'viewIndex') => 'GET',
            str_starts_with($methodName, 'add') => 'POST',
            str_starts_with($methodName, 'edit') => 'POST',
            str_starts_with($methodName, 'delete') => 'POST',
            default => null
        };

        $params = $method->getParameters();

        $paramPattern = '';
        if (count($params) > 0) {
            $paramPattern = str_repeat('/(\d+)', count($params));
        }

        $routes[] = [
            'method' => $httpMethod,
            'path' => "/{$methodName}{$paramPattern}",
            'action' => $methodName
        ];

        if (str_starts_with($methodName, 'edit')) {
            $routes[] = [
                'method' => $httpMethod,
                'path' => "/editIndex/edit{$paramPattern}",
                'action' => $methodName
            ];
        }
        if (str_starts_with($methodName, 'delete')) {
            $routes[] = [
                'method' => $httpMethod,
                'path' => "/deleteIndex/delete{$paramPattern}",
                'action' => $methodName
            ];
        }
    }

    if ($customRoutes) {
        foreach ($customRoutes as $custom) {
            $routes[] = [
                'method' => $custom['method'],
                'path' => $custom['path'],
                'action' => $custom['action']
            ];
        }
    }

    foreach ($routes as $route) {
        $router->match($route['method'], $route['path'], function (...$params) use ($controllerClass, $route) {
            $method = $route['action'];
            $controller = new $controllerClass();
            call_user_func_array([$controller, $method], $params);
//            try {
//                call_user_func_array([$controller, $method], $params);
//            } catch (Throwable $e) {
//                http_response_code(500);
//                echo json_encode(['error' => $e->getMessage()]);
//            }
        });
    }
}


function isAjaxRequest(): bool
{
    return isset($_SERVER['HTTP_X_REQUESTED_WITH'])
        && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';
}

function getAllModels(): array
{
    $models = [];

    $path = $_SERVER['DOCUMENT_ROOT'] . '/application/Models';

    $iterator = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($path, FilesystemIterator::SKIP_DOTS)
    );

    foreach ($iterator as $file) {
        if (!$file->isFile() || $file->getExtension() !== 'php') {
            continue;
        }

        $relativePath = substr($file->getPathname(), strlen($path) + 1);

        $class = 'App\\Models\\' . str_replace(
                ['/', '\\', '.php'],
                ['\\', '\\', ''],
                $relativePath
            );

        $models[] = $class;
    }

    return $models;
}

#[NoReturn]
function redirect(string $url, int $statusCode = 302): void
{
    header("Location: {$url}", true, $statusCode);
    exit;
}