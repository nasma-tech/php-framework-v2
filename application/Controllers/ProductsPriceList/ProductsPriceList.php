<?php

namespace App\Controllers\ProductsPriceList;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ProductsPriceListModel\ProductsPriceListModel;

class ProductsPriceList extends ControllerScheme
{
    const string singleName = 'لیست قیمت محصول';
    const string pluralName = 'لیست قیمت محصولات';
    protected string $defaultModel = ProductsPriceListModel::class;

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
            //'js/ProductsPriceList/ProductsPriceList'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ProductsPriceList/ProductsPriceList.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ProductsPriceList/add-ProductsPriceList'
        ], [],
            [//vars
            ]
        )->display('ProductsPriceList/add-ProductsPriceList.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ProductsPriceList/edit-ProductsPriceList'
        ], [], [
            //var
        ])->display('ProductsPriceList/edit-ProductsPriceList.tpl');
    }
}
