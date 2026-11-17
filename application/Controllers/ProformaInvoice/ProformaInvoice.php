<?php

namespace App\Controllers\ProformaInvoice;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\PriceSuggestionModel\PriceSuggestionModel;
use App\Models\ProformaInvoiceModel\ProformaInvoiceModel;

class ProformaInvoice extends ControllerScheme
{
    const string singleName = 'پیشفاکتور';
    const string pluralName = 'پیشفاکتورها';
    protected string $defaultModel = ProformaInvoiceModel::class;

    public function main(): void
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

        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ProformaInvoice/ProformaInvoice.tpl');
    }


    public function createProformaInvoice($priceSuggestionId): void
    {
        $getPriceSuggestionData = PriceSuggestionModel::query()->find($priceSuggestionId);
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/ProformaInvoice/add|edit-ProformaInvoice',
            'js/ProformaInvoice/one',
            'js/ProformaInvoice/two'
        ], [
            'css/ProformaInvoice/add|edit-ProformaInvoice'
        ],
            [
                'priceSuggestionData'=>$getPriceSuggestionData,
                'brands' => brandsModel::query()->get(),
            ]
        )->display('ProformaInvoice/add|edit-ProformaInvoice.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ProformaInvoice/edit-ProformaInvoice'
        ], [], [
            //var
        ])->display('ProformaInvoice/edit-ProformaInvoice.tpl');
    }
}
