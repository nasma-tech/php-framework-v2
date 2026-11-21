<?php

namespace App\Controllers\CarsModel;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CarsModelModel\CarsModelModel;

class CarsModel extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = CarsModelModel::class;

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
            //'js/CarsModel/CarsModel'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('CarsModel/CarsModel.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/CarsModel/add-CarsModel'
        ], [],
            [//vars
            ]
        )->display('CarsModel/add-CarsModel.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/CarsModel/edit-CarsModel'
        ], [], [
            //var
        ])->display('CarsModel/edit-CarsModel.tpl');
    }

    public function getCarModel()
    {
        $carBrandId = $this->requestArray()['carBrandId'];
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'title' => $item['title']
            ];
        }, CarsModelModel::query()->get()->where('car_brand_id', $carBrandId)->toArray()), JSON_UNESCAPED_UNICODE);
    }


}
