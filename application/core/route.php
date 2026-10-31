<?php

use App\Controllers\auth\auth;
use App\Controllers\CartableDefinition\cities\cities;
use App\Controllers\colors\colors;
use App\Controllers\countries\countries;
use App\Controllers\dashboard\dashboard;
use App\Controllers\login\login;
use App\Controllers\login\MenuList\MenuList;
use App\Controllers\roles\roles;
use App\Controllers\states\states;
use App\Controllers\Units\Units;
use App\Controllers\users\users;
use Packages\View\handleHttpErrorView;


$router = new \Bramus\Router\Router();


//baseRoute
$router->before('GET|POST', '/.*', function () {
    $freeRoutes = ['/login', '/auth/authentication', '/webApi'];
    $uri = strtok($_SERVER['REQUEST_URI'], '?');
    $isFree = in_array($uri, $freeRoutes) || str_starts_with($uri, '/webApi');
    if (!isset($_SESSION['userId']) && !$isFree) {
        if (isAjaxRequest()) {
            header('Content-Type: application/json');
            echo json_encode(['error' => 'unauthorized']);
        } else {
            header('Location:/login');
        }
        exit();
    }
});
$router->get('/', function () {
    header('location: /dashboard/main');
});
$router->set404(function () {
    if (isAjaxRequest()) {
        http_response_code(404);
    } else {
        handleHttpErrorView::handle(404);
    }
});
$router->get('/login', function () {
    $main = new login();
    $main->main();
});
$router->get('/logout', function () {
    session_destroy();
    header('location:/login');
});
$router->get('/notAccess', function () {
    handleHttpErrorView::handle(403);
});
$router->get('/Profile', function () {
    view->ui()->display('view/Profile/Profile.tpl');
});

//baseRoute
$router->mount('/auth', function () use ($router) {
    dynamicRoute($router, auth::class, [
        [
            'method' => 'POST',
            'path' => '/authentication',
            'action' => 'authentication'
        ]
    ]);
});
$router->mount('/dashboard', function () use ($router) {
    dynamicRoute($router, dashboard::class);
});
$router->mount('/users', function () use ($router) {
    dynamicRoute($router, users::class, [
        [
            'method' => 'GET',
            'path' => '/getUsersForm',
            'action' => 'getUsersForm'
        ]
    ]);
});
$router->mount('/roles', function () use ($router) {
    dynamicRoute($router, roles::class);
});
$router->mount('/MenuList', function () use ($router) {
    dynamicRoute($router, MenuList::class, [
        [
            'method' => 'POST',
            'path' => 'getIconsList',
            'action' => 'getIconsList'
        ]
    ]);
});
$router->mount('/countries', function () use ($router) {
    dynamicRoute($router, countries::class);
});
$router->mount('/states', function () use ($router) {
    dynamicRoute($router, states::class, [
        [
            'method' => 'GET',
            'path' => '/getMapInfo',
            'action' => 'getMapInfo'
        ],
        [
            'method' => 'GET',
            'path' => '/getStates',
            'action' => 'getStates'
        ]
    ]);
});
$router->mount('/cities', function () use ($router) {
    dynamicRoute($router, cities::class, [
        [
            'method' => 'GET',
            'path' => '/getFilterCities',
            'action' => 'getFilterCities'
        ],
        [
            'method' => 'GET',
            'path' => '/getMapInfo',
            'action' => 'getMapInfo'
        ]
    ]);
});
$router->mount('/Units', function () use ($router) {
    dynamicRoute($router, Units::class, [
        [
            'method' => 'GET',
            'path' => "/findOneFilterUnit",
            'action' => 'findOneFilterUnit'
        ],
        [
            'method' => 'GET',
            'path' => "/getUnits",
            'action' => 'getUnits'
        ]
    ]);
});
$router->mount('/colors', function () use ($router) {
    dynamicRoute($router, colors::class);
});
$router->mount('/CartableDefinition', function () use ($router) {
    dynamicRoute($router, App\Controllers\CartableDefinition\CartableDefinition::class, [
        [
            'method' => 'POST',
            'path' => '/getPermissionList',
            'action' => 'getPermissionList'
        ]
    ]);
});
//baseRoute

$router->mount('/IssuingPlace', function () use ($router) {
    dynamicRoute($router, App\Controllers\IssuingPlace\IssuingPlace::class, [
        [
            'method' => 'GET',
            'path' => '/filter',
            'action' => 'filter'
        ]
    ]);
});

$router->mount('/UserContactTypes', function () use ($router) {
    dynamicRoute($router, App\Controllers\UserContactTypes\UserContactTypes::class);
});
