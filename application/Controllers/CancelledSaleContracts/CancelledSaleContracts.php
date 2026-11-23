<?php

namespace App\Controllers\CancelledSaleContracts;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CancelledSaleContractsModel\CancelledSaleContractsModel;
use App\Models\ProformaInvoiceModel\ProformaInvoiceModel;
use App\Models\SaleContractsModel\SaleContractsModel;

class CancelledSaleContracts extends ControllerScheme
{
    const string singleName = 'لغو قرارداد';
    const string pluralName = 'لغو قرارداد';
    protected string $defaultModel = CancelledSaleContractsModel::class;

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
            //'js/CancelledSaleContracts/CancelledSaleContracts'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('CancelledSaleContracts/CancelledSaleContracts.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/CancelledSaleContracts/add-CancelledSaleContracts'
        ], [],
            [//vars
            ]
        )->display('CancelledSaleContracts/add-CancelledSaleContracts.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/CancelledSaleContracts/edit-CancelledSaleContracts'
        ], [], [
            //var
        ])->display('CancelledSaleContracts/edit-CancelledSaleContracts.tpl');
    }

    public function cancelContract(): void
    {
        $invoiceId = $this->requestArray()['invoiceId'];
        $find = ProformaInvoiceModel::query()->find($invoiceId);
        if ($find){
            if ($find->contract){
                $contractId = $find->contract->id;
                $contract = SaleContractsModel::query()->find($contractId)->delete();
                if ($contract){
                    $makeData = [
                        'sale_contract_id'=>$contractId,
                        'cancel_date_time'=>time(),
                        'description'=>'',
                        'user_id'=>userObject()->userId,
                    ];
                    $cancelContract = CancelledSaleContractsModel::query()->create($makeData);
                    if ($cancelContract){
                        echo 'cancelSuccess';
                    }else{
                        echo 'cancelFailed';
                    }
                }
            }else{
                echo 'contractNotFound';
            }
        }else{
            echo 'proformaInvoiceNotFound';
        }

    }

}
