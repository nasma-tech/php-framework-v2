<?php

namespace App\Controllers\ProductExitParts;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ProductExitPartItemsModel\ProductExitPartItemsModel;
use App\Models\ProductExitPartsModel\ProductExitPartsModel;

class ProductExitParts extends ControllerScheme
{
    const string singleName = 'خروج پارت';
    const string pluralName = 'خروج پارت ها';
    protected string $defaultModel = ProductExitPartsModel::class;

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
            //'js/ProductExitParts/ProductExitParts'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ProductExitParts/ProductExitParts.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ProductExitParts/add-ProductExitParts'
        ], [],
            [//vars
            ]
        )->display('ProductExitParts/add-ProductExitParts.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ProductExitParts/edit-ProductExitParts'
        ], [], [
            //var
        ])->display('ProductExitParts/edit-ProductExitParts.tpl');
    }

    public function add(): void
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $makeExitPart = [
            'proforma_invoice_id' => $data['proforma_invoice_id'],
            'product_part_id' => $data['part_id'],
            'user_id' => userObject()->userId,
        ];
        $addExitPart = ProductExitPartsModel::query()->create($makeExitPart);
        if ($addExitPart) {
            $get = json_decode($addExitPart->productParts->proformaInvoice->invoiceDetail->charges_deductions, true);
            $sumTax = [];
            $sumTaxTotal = 0;
            $exit_part_total_sum = 0;
            if (isset($data['exitData'])) {
                foreach ($data['exitData'] as $item) {
                    $exit_amount = numberNormalizer->removePriceSeparator($item['exit_amount']);
                    $sum_unit_price = $item['total_unit_price'] * $exit_amount;
                    foreach ($get as $row) {
                        if ($row['netSumMerge']) {
                            $sumTax[] = [
                                'title' => $row['title'],
                                'charges_deduction_id' => $row['charges_deduction_id'],
                                'coefficient' => round($row['coefficient'] - 1, 2),
                                'netSumMerge' => $row['netSumMerge'],
                                'sum' => $sum_unit_price * ($row['coefficient'] - 1)
                            ];
                            $sumTaxTotal += $sum_unit_price * ($row['coefficient'] - 1);
                            $exit_part_total_sum += $sum_unit_price * ($row['coefficient'] - 1);
                        } else {
                            $sumTax[] = [
                                'title' => $row['title'],
                                'charges_deduction_id' => $row['charges_deduction_id'],
                                'coefficient' => round($row['coefficient'] - 1, 2),
                                'netSumMerge' => $row['netSumMerge'],
                                'sum' => ($sumTaxTotal + $sum_unit_price) * ($row['coefficient'] - 1)
                            ];
                            $exit_part_total_sum += ($sumTaxTotal + $sum_unit_price) * ($row['coefficient'] - 1);
                        }
                    }
                    $makeExitPartItems = [
                        'product_exit_part_id' => $addExitPart->id,
                        'product_exit_part_item_id' => $item['part_item_id'],
                        'exit_amount' => $exit_amount,
                        'unit_price' => $item['total_unit_price'],
                        'sum_unit_price' => $sum_unit_price,
                        'invoice_sum_tax_details' => json_encode($sumTax, JSON_UNESCAPED_UNICODE),
                        'exit_part_total_sum' => $exit_part_total_sum + $sum_unit_price,
                    ];
                    ProductExitPartItemsModel::query()->create($makeExitPartItems);
                }
                $this->successCallBack("/ProformaInvoice/process/{$data['proforma_invoice_id']}", "ثبت خروج پارت با موفقیت انجام شد");
            }
        } else {
            $this->failedCallBack("/ProformaInvoice/process/{$data['proforma_invoice_id']}", "خطا در ثبت پارت خروج");
        }
    }
}
