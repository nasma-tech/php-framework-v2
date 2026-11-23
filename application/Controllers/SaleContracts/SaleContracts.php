<?php

namespace App\Controllers\SaleContracts;

use App\Controllers\scheme\ControllerScheme;
use App\Models\SaleContractsModel\SaleContractsModel;

class SaleContracts extends ControllerScheme
{
    const string singleName = 'قرارداد';
    const string pluralName = 'قراردادها';
    protected string $defaultModel = SaleContractsModel::class;

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
            //'js/SaleContracts/SaleContracts'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'list'=>SaleContractsModel::query()
                    ->withCount('addendum')
                    ->get()
            ])->display('SaleContracts/SaleContracts.tpl');
    }

    public function saleContractDetail($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel($this->defaultModel::query()
            ->withCount('addendum')
            ->find($id));
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
            //'js/SaleContracts/SaleContracts'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [

            ])->display('SaleContracts/view-SaleContracts.tpl');
    }

    public function convertToContract(): void
    {
        $invoiceId = $this->requestArray()['invoiceId'];
        $makeData = [
            'proforma_invoice_id' => $invoiceId,
            'convert_to_contract' => time(),
            'user_id' => userObject()->userId,
        ];
        $contract = SaleContractsModel::query()->create($makeData);
        if ($contract)
            echo 'convertSuccess';
        else
            echo 'convertFailed';
    }


}
