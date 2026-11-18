<?php

namespace App\Controllers\ProformaInvoiceSettings;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\ChargesDeductionsModel\ChargesDeductionsModel;
use App\Models\ProformaInvoiceSettingsModel\ProformaInvoiceSettingsModel;

class ProformaInvoiceSettings extends ControllerScheme
{
    const string singleName = 'تنظمات پیشفاکتور';
    const string pluralName = 'تنظیمات پیشفاکتورها';
    protected string $defaultModel = ProformaInvoiceSettingsModel::class;

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
            //'js/ProformaInvoiceSettings/ProformaInvoiceSettings'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'list' => ProformaInvoiceSettingsModel::query()->get()
            ])->display('ProformaInvoiceSettings/ProformaInvoiceSettings.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/Sortable/Sortable.min',
            'js/ProformaInvoiceSettings/add|edit-ProformaInvoiceSettings'
        ], [],
            [
                'brands' => brandsModel::query()->get(),
                'chargesDeductions' => ChargesDeductionsModel::query()->get()
            ]
        )->display('ProformaInvoiceSettings/add|edit-ProformaInvoiceSettings.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ProformaInvoiceSettings/edit-ProformaInvoiceSettings'
        ], [], [
            //var
        ])->display('ProformaInvoiceSettings/edit-ProformaInvoiceSettings.tpl');
    }

    public function add(): void
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $chargesDeductions = [];
        foreach ($data['chargesDeductions'] as $key => $item) {
            $chargesDeductions[] = [
                'charges_deduction_id' => $key,
                'netSumMerge' => isset($item['netSumMerge']),
            ];
        }
        $make = [
            'brand_id' => $data['brand_id'],
            'charges_deductions_order' => json_encode($chargesDeductions, JSON_UNESCAPED_UNICODE)];
        ProformaInvoiceSettingsModel::query()->create($make);
    }

    public function getChargesDeductionsSetting(): void
    {
        $brandId = $this->requestArray()['brandId'];
        $get = ProformaInvoiceSettingsModel::query()->where('brand_id', $brandId)->first();
        if ($get) {
            $decode = json_decode($get->charges_deductions_order, true);
            $result = [];
            foreach ($decode as $item) {
                $chargesDeductionInfo = ChargesDeductionsModel::query()->find($item['charges_deduction_id']);
                $result[] = [
                    'id' => $chargesDeductionInfo['id'],
                    'title' => $chargesDeductionInfo->title,
                    'identifier' => $chargesDeductionInfo->identifier,
                    'coefficient' => $chargesDeductionInfo->coefficient,
                    'netSumMerge' => $item['netSumMerge'],
                ];
            }
            echo json_encode($result, JSON_UNESCAPED_UNICODE);
        } else {
            echo 'notFound';
        }
    }
}
