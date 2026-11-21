<?php

namespace App\Controllers\CarsGroup;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CarsGroupModel\CarsGroupModel;

class CarsGroup extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = CarsGroupModel::class;

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
            //'js/CarsGroup/CarsGroup'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('CarsGroup/CarsGroup.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/CarsGroup/add-CarsGroup'
        ], [],
            [//vars
            ]
        )->display('CarsGroup/add-CarsGroup.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/CarsGroup/edit-CarsGroup'
        ], [], [
            //var
        ])->display('CarsGroup/edit-CarsGroup.tpl');
    }

    public function getCarGroups()
    {
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'title' => $item['title']
            ];
        }, CarsGroupModel::query()->get()->toArray()), JSON_UNESCAPED_UNICODE);
    }
}
