<?php

namespace App\Controllers\Warehouses;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\CountryModel\CountryModel;
use App\Models\personTypeModel\personTypeModel;
use App\Models\UserModel\UserModel;
use App\Models\WarehousesModel\WarehousesModel;
use App\Models\warehouseTypeModel\warehouseTypeModel;

class Warehouses extends ControllerScheme
{
    const string singleName = 'انبار';
    const string pluralName = 'انبارها';
    protected string $defaultModel = WarehousesModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/tables/datatable/datatables.min',
            'vendors/js/tables/datatable/dataTables.bootstrap4.min',
            'vendors/js/tables/datatable/dataTables.buttons.min',
            'vendors/js/tables/datatable/buttons.html5.min',
            'vendors/js/tables/datatable/buttons.print.min',
            'vendors/js/tables/datatable/buttons.bootstrap.min',
            'vendors/js/tables/datatable/jszip.min',
            'vendors/js/tables/datatable/pdfmake.min',
            'vendors/js/tables/datatable/vfs_fonts',
            'vendors/js/tables/datatable/buttons.colVis.min',
            //'js/Warehouses/Warehouses'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('Warehouses/Warehouses.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/charts/valadart/go',
            'vendors/js/charts/valadart/data',
            'vendors/js/charts/valadart/lookup',
            'vendors/js/charts/valadart/model-helpers',
            'vendors/js/charts/valadart/editing',
            'vendors/js/charts/valadart/context-menu',
            'vendors/js/charts/valadart/node-template',
            'vendors/js/charts/valadart/dragging-tool',
            'vendors/js/charts/valadart/diagram-init',
            'vendors/js/charts/valadart/app',
            'js/Warehouses/add-Warehouses',
            'vendors/js/charts/apextree.min',
        ], ['css/Warehouses/add-Warehouses','vendors/css/charts/valadart/style'],
            [//vars
                'brands' => brandsModel::query()->get(),
                'warehouseType' => warehouseTypeModel::query()->get(),
                'countries' => countryModel::query()->get(),
                'personTypes' => personTypeModel::query()->get(),
            ]
        )->display('Warehouses/add-Warehouses.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/Warehouses/edit-Warehouses'
        ], [], [
            //var
        ])->display('Warehouses/edit-Warehouses.tpl');
    }

    public function getWarehouseKeepers()
    {
        $parentIds = $this->requestArray()['parentIds'] ?? [];

        $validUsers = userModel::query()
            ->whereNotIn('id', $parentIds)
            ->where('permission', '12')
            ->get(['id', 'name']);

        echo json_encode([
            "status" => "success",
            "users" => $validUsers
        ]);

        return;
    }

    public function addTeam()
    {
        $data = $this->requestArray();
        var_print($data);
        die();
    }

    public function add()
    {
        $data = $this->requestArray();
        var_print($data);
        die();
    }
}
