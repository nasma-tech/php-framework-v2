<?php

namespace App\Controllers\CarsTip;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CarsTipModel\CarsTipModel;

class CarsTip extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = CarsTipModel::class;

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
            //'js/CarsTip/CarsTip'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('CarsTip/CarsTip.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/CarsTip/add-CarsTip'
        ], [],
            [//vars
            ]
        )->display('CarsTip/add-CarsTip.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/CarsTip/edit-CarsTip'
        ], [], [
            //var
        ])->display('CarsTip/edit-CarsTip.tpl');
    }

    public function getCarTips()
    {
        $carModelId = $this->requestArray()['carModelId'];
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'title' => $item['title']
            ];
        }, CarsTipModel::query()->get()->where('car_model_id', $carModelId)->toArray()), JSON_UNESCAPED_UNICODE);
    }
}
