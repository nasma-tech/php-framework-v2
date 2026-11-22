<?php

namespace App\Controllers\EntryWarehouse;

use App\Controllers\scheme\ControllerScheme;
use App\Models\EntryWarehouseModel\EntryWarehouseModel;
use App\Models\WarehousesModel\WarehousesModel;

class EntryWarehouse extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = EntryWarehouseModel::class;

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
            //'js/EntryWarehouse/EntryWarehouse'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('EntryWarehouse/EntryWarehouse.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/EntryWarehouse/add-EntryWarehouse'
        ], [],
            [
                "warehouseData" => WarehousesModel::all()
            ]
        )->display('EntryWarehouse/add-EntryWarehouse.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/EntryWarehouse/edit-EntryWarehouse'
        ], [], [
            //var
        ])->display('EntryWarehouse/edit-EntryWarehouse.tpl');
    }
}
