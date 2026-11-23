<?php

namespace App\Controllers\ProductPart;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ProductPartItemModel\ProductPartItemModel;
use App\Models\ProductPartModel\ProductPartModel;

class ProductPart extends ControllerScheme
{
    const string singleName = 'تخصیص پارت';
    const string pluralName = 'تخصیص پارت';
    protected string $defaultModel = ProductPartModel::class;

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
            //'js/ProductPart/ProductPart'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ProductPart/ProductPart.tpl');
    }

    public function addProductPart(int $invoiceId, int $warehouseId)
    {
        return ProductPartModel::query()->create([
            'proforma_invoice_id' => $invoiceId,
            'warehouse_id' => $warehouseId,
            'user_id' => userObject()->userId
        ]);
    }

    public function addProductPartItem(int $partId, int $proformaInvoiceProductId, int $amount)
    {
        return ProductPartItemModel::query()->create([
            "part_id" => $partId,
            "invoice_product_id" => $proformaInvoiceProductId,
            "amount" => numberNormalizer->removePriceSeparator($amount),
            "user_id" => userObject()->userId,
        ]);
    }
}
