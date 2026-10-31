<?php

namespace App\Controllers\IssuingPlace;

use App\Controllers\scheme\ControllerScheme;
use App\Models\IssuingPlaceModel\IssuingPlaceModel;

class IssuingPlace extends ControllerScheme
{
    const string singleName = 'محل صدور';
    const string pluralName = 'محل های صدور';
    protected string $defaultModel = IssuingPlaceModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(IssuingPlaceModel::all());
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
            //'js/IssuingPlace/IssuingPlace'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
        )->display('IssuingPlace/IssuingPlace.tpl');
    }

    public function filter(): void
    {
        $data = $this->requestArray();

        $get = IssuingPlaceModel::query()
            ->select([
                'id',
                'code',
                'title'
            ])
            ->whereLike('code', "{$data['code']}%")
            ->get();

        echo json_encode($get, JSON_UNESCAPED_UNICODE);

    }

}
