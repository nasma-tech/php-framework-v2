<?php

use App\Controllers\auth\auth;
use App\Controllers\CartableDefinition\cities\cities;
use App\Controllers\colors\colors;
use App\Controllers\countries\countries;
use App\Controllers\CustomerContactInformation\CustomerContactInformation;
use App\Controllers\dashboard\dashboard;
use App\Controllers\salesTeam\salesTeam;
use App\Controllers\login\login;
use App\Controllers\login\MenuList\MenuList;
use App\Controllers\roles\roles;
use App\Controllers\states\states;
use App\Controllers\Units\Units;
use App\Controllers\users\users;
use App\Controllers\WorkGroups\WorkGroups;
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
            'method' => 'POST',
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
    dynamicRoute($router, countries::class, [
        [
            'method' => 'GET',
            'path' => '/getCountryData(/\d+)',
            'action' => 'getCountryData'
        ],
    ]);
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
            'path' => '/getStates(/\d+)',
            'action' => 'getStates'
        ],
        [
            'method' => 'GET',
            'path' => '/getStatesFilterByCountry',
            'action' => 'getStatesFilterByCountry'
        ]
    ]);
});
$router->mount('/cities', function () use ($router) {
    dynamicRoute($router, cities::class, [
        [
            'method' => 'POST',
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
$router->mount('/Products', function () use ($router) {
    dynamicRoute($router, App\Controllers\Products\Products::class, [
        [
            'method' => 'GET',
            'path' => '/getProductData',
            'action' => 'getProductData'
        ],
        [
            'method' => 'POST',
            'path' => '/getProductsFilterForm',
            'action' => 'getProductsFilterForm'
        ]
    ]);
});
$router->mount('/ProductGroup', function () use ($router) {
    dynamicRoute($router, App\Controllers\ProductGroup\ProductGroup::class);
});
$router->mount('/ProductGrad', function () use ($router) {
    dynamicRoute($router, App\Controllers\ProductGrad\ProductGrad::class, [
        [
            'method' => 'GET',
            'path' => '/edit',
            'action' => 'edit'
        ]
    ]);
});
$router->mount('/brands', function () use ($router) {
    dynamicRoute($router, App\Controllers\brands\brands::class);
});

$router->mount('/ProductQualities', function () use ($router) {
    dynamicRoute($router, App\Controllers\ProductQualities\ProductQualities::class);
});

$router->mount('/ProductsPriceList', function () use ($router) {
    dynamicRoute($router, App\Controllers\ProductsPriceList\ProductsPriceList::class);
});
$router->mount('/ProformaInvoice', function () use ($router) {
    dynamicRoute($router, \App\Controllers\ProformaInvoice\ProformaInvoice::class, [
        [
            'method' => 'GET',
            'path' => "/process(/\d+)?",
            'action' => 'process'
        ],
        [
            'method' => 'GET',
            'path' => '/createProformaInvoice(/\d+)',
            'action' => 'createProformaInvoice'
        ],
        [
            'method' => 'POST',
            'path' => '/removeProductRow',
            'action' => 'removeProductRow'
        ]
    ]);
});
$router->mount('/Companies', function () use ($router) {
    dynamicRoute($router, App\Controllers\Companies\Companies::class, [
        [
            'method' => 'POST',
            'path' => '/addCompanies',
            'action' => 'addCompanies'
        ],
        [
            'method' => 'GET',
            'path' => '/findCompanies',
            'action' => 'findCompanies'
        ]
    ]);
});
$router->mount('/ProductCategories', function () use ($router) {
    dynamicRoute($router, App\Controllers\ProductCategories\ProductCategories::class);
});
$router->mount('/MeasurementUnit', function () use ($router) {
    dynamicRoute($router, App\Controllers\MeasurementUnit\MeasurementUnit::class);
});
$router->mount('/ContactPhoneLabel', function () use ($router) {
    dynamicRoute($router, App\Controllers\ContactPhoneLabel\ContactPhoneLabel::class, [
        [
            'method' => 'GET',
            'path' => "/getContactPhoneLabel",
            'action' => 'getContactPhoneLabel'
        ]
    ]);
});
$router->mount('/IndustryType', function () use ($router) {
    dynamicRoute($router, App\Controllers\IndustryType\IndustryType::class);
});
$router->mount('/CustomerContactInformation', function () use ($router) {
    dynamicRoute($router, CustomerContactInformation::class, [
        [
            'method' => 'GET',
            'path' => '/contactDetail(/\d+)?',
            'action' => 'contactDetail'
        ],
        [
            'method' => 'GET',
            'path' => '/contactDetailCall(/\w+)?',
            'action' => 'contactDetailCall'
        ]
    ]);
});
$router->mount('/CarsGroup', function () use ($router) {
    dynamicRoute($router, App\Controllers\CarsGroup\CarsGroup::class, [
        [
            'method' => 'GET',
            'path' => "/getCarGroups",
            'action' => 'getCarGroups'
        ]
    ]);
});
$router->mount('/CarsBrand', function () use ($router) {
    dynamicRoute($router, App\Controllers\CarsBrand\CarsBrand::class, [
        [
            'method' => 'GET',
            'path' => "/getCarBrands",
            'action' => 'getCarBrands'
        ]
    ]);
});
$router->mount('/CarsModel', function () use ($router) {
    dynamicRoute($router, App\Controllers\CarsModel\CarsModel::class, [
        [
            'method' => 'GET',
            'path' => "/getCarModel",
            'action' => 'getCarModel'
        ]
    ]);
});
$router->mount('/CarsTip', function () use ($router) {
    dynamicRoute($router, App\Controllers\CarsTip\CarsTip::class, [
        [
            'method' => 'GET',
            'path' => "/getCarTips",
            'action' => 'getCarTips'
        ]
    ]);
});
$router->mount('/FollowUpActionsTitle', function () use ($router) {
    dynamicRoute($router, App\Controllers\FollowUpActionsTitle\FollowUpActionsTitle::class);
});
$router->mount('/FollowUpActionsTitle', function () use ($router) {
    dynamicRoute($router, App\Controllers\FollowUpActionsTitle\FollowUpActionsTitle::class);
});
$router->mount('/ContactPhones', function () use ($router) {
    dynamicRoute($router, App\Controllers\ContactPhones\ContactPhones::class, [
        [
            'method' => 'POST',
            'path' => "/checkNumberInput",
            'action' => 'checkNumberInput'
        ]
    ]);
});
$router->mount('/Companies', function () use ($router) {
    dynamicRoute($router, App\Controllers\Companies\Companies::class, [
        [
            'method' => 'POST',
            'path' => "/addCompanies",
            'action' => 'addCompanies'
        ]
    ]);
});
$router->mount('/ContactProjects', function () use ($router) {
    dynamicRoute($router, App\Controllers\ContactProjects\ContactProjects::class, [
        [
            'method' => 'GET',
            'path' => "/ContactProjectDetail(/\d+)",
            'action' => 'ContactProjectDetail'
        ]
    ]);
});
$router->mount('/ContactProjectsFollowUp', function () use ($router) {
    dynamicRoute($router, App\Controllers\ContactProjectsFollowUp\ContactProjectsFollowUp::class, [
        [
            'method' => 'POST',
            'path' => '/followUpActionSubmit',
            'action' => 'followUpActionSubmit'
        ]
    ]);
});
$router->mount('/SocialNetworksList', function () use ($router) {
    dynamicRoute($router, App\Controllers\SocialNetworksList\SocialNetworksList::class, [
        [
            'method' => 'GET',
            'path' => "/getSocialNetworkList",
            'action' => 'getSocialNetworkList'
        ]
    ]);
});
$router->mount('/ContactsGroup', function () use ($router) {
    dynamicRoute($router, App\Controllers\ContactsGroup\ContactsGroup::class, [
        [
            'method' => 'GET',
            'path' => "/getContactsGroup",
            'action' => 'getContactsGroup'
        ]
    ]);
});
$router->mount('/ContactAcquisitionSources', function () use ($router) {
    dynamicRoute($router, App\Controllers\ContactAcquisitionSources\ContactAcquisitionSources::class, [
        [
            'method' => 'GET',
            'path' => "/getContactAcquisitionSources",
            'action' => 'getContactAcquisitionSources'
        ]
    ]);
});
$router->mount('/WorkGroups', function () use ($router) {
    dynamicRoute($router, WorkGroups::class, [
        [
            'method' => 'POST',
            'path' => '/getWorkGroupsIndex',
            'action' => 'getWorkGroupsIndex'
        ]
    ]);
});
$router->mount('/Warehouses', function () use ($router) {
    dynamicRoute($router, App\Controllers\Warehouses\Warehouses::class, [
        [
            'method' => 'POST',
            'path' => "/getWarehouseKeepers",
            'action' => 'getWarehouseKeepers'
        ],
        [
            'method' => 'POST',
            'path' => "/addTeam",
            'action' => 'addTeam'
        ],
    ]);
});
$router->mount('/PriceSuggestion', function () use ($router) {
    dynamicRoute($router, App\Controllers\PriceSuggestion\PriceSuggestion::class, [
        [
            'method' => 'GET',
            'path' => "/createPriceSuggestion/(\d+)/(\d+)",
            'action' => 'createPriceSuggestion'
        ],
        [
            'method' => 'GET',
            'path' => "/editPriceSuggestion/(\d+)",
            'action' => 'editPriceSuggestion'
        ],
        [
            'method' => 'POST',
            'path' => "/updatePriceSuggestion/(\d+)",
            'action' => 'updatePriceSuggestion'
        ],
        [
            'method' => 'POST',
            'path' => "/removeProductRow",
            'action' => 'removeProductRow'
        ]
    ]);
});
$router->mount('/ChargesDeductions', function () use ($router) {
    dynamicRoute($router, App\Controllers\ChargesDeductions\ChargesDeductions::class);
});
$router->mount('/ProformaInvoiceSettings', function () use ($router) {
    dynamicRoute($router, App\Controllers\ProformaInvoiceSettings\ProformaInvoiceSettings::class, [
        [
            'method' => 'GET',
            'path' => "/getChargesDeductionsSetting",
            'action' => 'getChargesDeductionsSetting'
        ],
        [
            'method' => 'GET',
            'path' => "/getProformaInvoiceSettings",
            'action' => 'getProformaInvoiceSettings'
        ]
    ]);
});
$router->mount('/salesTeam', function () use ($router) {
    dynamicRoute($router, App\Controllers\salesTeam\salesTeam::class, [
        [
            'method' => 'GET',
            'path' => "/permissions/(\d+)",
            'action' => 'permissionIndex'
        ],
        [
            'method' => 'POST',
            'path' => "/getSalePermissionBrands",
            'action' => 'getSalePermissionBrands'
        ],
        [
            'method' => 'POST',
            'path' => "/getSalePermissionProducts",
            'action' => 'getSalePermissionProducts'
        ],
        [
            'method' => 'POST',
            'path' => "/getSalePermissionProductsForTeam",
            'action' => 'getSalePermissionProductsForTeam'
        ],
        [
            'method' => 'GET',
            'path' => "/addGroupIndex",
            'action' => 'addGroupIndex'
        ],
        [
            'method' => 'POST',
            'path' => "/addGroup",
            'action' => 'addGroup'
        ],
        [
            'method' => 'GET',
            'path' => "/getGroupData/(\d+)",
            'action' => 'getGroupData'
        ],
        [
            'method' => 'GET',
            'path' => "/addTeamIndex/(\d+)",
            'action' => 'addTeamIndex'
        ],
        [
            'method' => 'POST',
            'path' => "/addTeam",
            'action' => 'addTeam'
        ],
        [
            'method' => 'POST',
            'path' => "/deleteSalesTeam",
            'action' => 'deleteSalesTeam'
        ],
        [
            'method' => 'POST',
            'path' => "/saveSalePermissions",
            'action' => 'saveSalePermissions'
        ],
        [
            'method' => 'GET',
            'path' => "/checkGroupTeam/(\d+)",
            'action' => 'checkGroupTeam'
        ],
        [
            'method' => 'GET',
            'path' => "/deleteGroup/(\d+)",
            'action' => 'deleteGroup'
        ],
        [
            'method' => 'GET',
            'path' => "/editGroupIndex/(\d+)",
            'action' => 'editGroupIndex'
        ],
        [
            'method' => 'GET',
            'path' => "/teamSetting/(\d+)",
            'action' => 'teamSetting'
        ],
        [
            'method' => 'GET',
            'path' => "/addSalesTeamSetting/(\d+)",
            'action' => 'addSalesTeamSetting'
        ]
    ]);
});
$router->mount('/PaymentManagement', function () use ($router) {
    dynamicRoute($router, App\Controllers\PaymentManagement\PaymentManagement::class, [
        [
            'method' => 'GET',
            'path' => '/getPayments',
            'action' => 'getPayments'
        ],
        [
            'method' => 'GET',
            'path' => '/getRemainingPayment',
            'action' => 'getRemainingPayment'
        ],
        [
            'method' => 'GET',
            'path' => '/viewIndex/(\d+)',
            'action' => 'viewIndex'
        ]
    ]);
});
$router->mount('/BankAccount', function () use ($router) {
    dynamicRoute($router, App\Controllers\BankAccount\BankAccount::class, [
        [
            'method' => 'GET',
            'path' => "/getAllBankAccountList",
            'action' => 'getAllBankAccountList'
        ]
    ]);
});
$router->mount('/PaymentMethod', function () use ($router) {
    dynamicRoute($router, App\Controllers\PaymentMethod\PaymentMethod::class, [
        [
            'method' => 'GET',
            'path' => "/getPaymentMethod",
            'action' => 'getPaymentMethod'
        ]
    ]);
});
$router->mount('/BankList', function () use ($router) {
    dynamicRoute($router, App\Controllers\BankList\BankList::class);
});
$router->mount('/WarehouseUsageTypes', function () use ($router) {
    dynamicRoute($router, App\Controllers\WarehouseUsageTypes\WarehouseUsageTypes::class);
});
$router->mount('/PaymentAllocation', function () use ($router) {
    dynamicRoute($router, App\Controllers\PaymentAllocation\PaymentAllocation::class, [
        [
            'method' => 'POST',
            'path' => '/submitPaymentAllocation',
            'action' => 'submitPaymentAllocation'
        ]
    ]);
});
$router->mount('/EntryWarehouse', function () use ($router) {
    dynamicRoute($router, App\Controllers\EntryWarehouse\EntryWarehouse::class,[
        [
            'method' => 'POST',
            'path' => '/EntryWarehouseEdit/(\d+)',
            'action' => 'EntryWarehouseEdit'
        ],
        [
            'method' => 'POST',
            'path' => '/EntryWarehouseDelete/(\d+)',
            'action' => 'EntryWarehouseDelete'
        ]
    ]);
});
$router->mount('/ExitWarehouse', function () use ($router) {
    dynamicRoute($router, App\Controllers\ExitWarehouse\ExitWarehouse::class);
});
$router->mount('/WarehouseInventory', function () use ($router) {
    dynamicRoute($router, App\Controllers\WarehouseInventory\WarehouseInventory::class);
});
$router->mount('/marketers', function () use ($router) {
    dynamicRoute($router, App\Controllers\marketers\marketers::class,[
        [
            'method' => 'GET',
            'path' => "/MarketerData",
            'action' => 'MarketerData'
        ],[
            'method' => 'POST',
            'path' => "/addMarketerGroup",
            'action' => 'addMarketerGroup'
        ],[
            'method' => 'GET',
            'path' => "/editMarketeGroup/(\d+)",
            'action' => 'editMarketeGroup'
        ]
    ]);
});

$router->get('/valad' , function (){

    $instance = new App\Controllers\Products\Products();

    var_print($instance->getRelatedProducts(2));
});