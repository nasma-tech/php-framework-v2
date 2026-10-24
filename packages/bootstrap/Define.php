<?php
//bootstrap required
require 'Errors.php';


// define
define('APP_URL', $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST']);
define('__SOURCE__', $_SERVER['DOCUMENT_ROOT'] . '/');




// shared objects
const view = new \Packages\View\View();
const validator = new \Packages\Validation\Validator();
const csrf = new \Packages\Security\Csrf();
const permissionHelper = new \Packages\Helpers\PermissionHelper();
const fileHelper = new \Packages\Helpers\FileHelper();
const userHelper = new \Packages\Helpers\UserHelper();