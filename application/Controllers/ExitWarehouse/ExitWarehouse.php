<?php

namespace App\Controllers\ExitWarehouse;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ExitWarehouseModel\ExitWarehouseModel;

class ExitWarehouse extends ControllerScheme
{
    const string singleName = 'خروج از انبار';
    const string pluralName = 'خروج از انبار';
    protected string $defaultModel = ExitWarehouseModel::class;
        
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
            //'js/ExitWarehouse/ExitWarehouse'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ExitWarehouse/ExitWarehouse.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ExitWarehouse/add-ExitWarehouse'
        ], [],
            [//vars
            ]
        )->display('ExitWarehouse/add-ExitWarehouse.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ExitWarehouse/edit-ExitWarehouse'
        ], [], [
            //var
        ])->display('ExitWarehouse/edit-ExitWarehouse.tpl');
    }
}
