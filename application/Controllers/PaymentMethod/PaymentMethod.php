<?php

namespace App\Controllers\PaymentMethod;

use App\Controllers\scheme\ControllerScheme;
use App\Models\PaymentMethodModel\PaymentMethodModel;

class PaymentMethod extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = PaymentMethodModel::class;

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
            //'js/PaymentMethod/PaymentMethod'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('PaymentMethod/PaymentMethod.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/PaymentMethod/add-PaymentMethod'
        ], [],
            [//vars
            ]
        )->display('PaymentMethod/add-PaymentMethod.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/PaymentMethod/edit-PaymentMethod'
        ], [], [
            //var
        ])->display('PaymentMethod/edit-PaymentMethod.tpl');
    }

    public function getPaymentMethod(): void
    {
        $get = PaymentMethodModel::all()->toArray();
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'title' => $item['title']
            ];
        }, $get), JSON_UNESCAPED_UNICODE);
    }
}
