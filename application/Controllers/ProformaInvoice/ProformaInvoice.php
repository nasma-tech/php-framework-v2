<?php

namespace App\Controllers\ProformaInvoice;

use App\Controllers\CartableDefinition\cities\cities;
use App\Controllers\countries\countries;
use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\ChargesDeductionsModel\ChargesDeductionsModel;
use App\Models\CityModel\CityModel;
use App\Models\CountryModel\CountryModel;
use App\Models\PriceSuggestionModel\PriceSuggestionModel;
use App\Models\ProductModel\ProductModel;
use App\Models\ProformaInvoiceDetailsModel\ProformaInvoiceDetailsModel;
use App\Models\ProformaInvoiceLogModel\ProformaInvoiceLogModel;
use App\Models\ProformaInvoiceModel\ProformaInvoiceModel;
use App\Models\ProformaInvoiceProductsModel\ProformaInvoiceProductsModel;
use App\Models\ProformaInvoiceSettingsModel\ProformaInvoiceSettingsModel;
use App\Models\SalesTeamModel\SalesTeamModel;
use App\Models\StateModel\StateModel;
use JetBrains\PhpStorm\NoReturn;

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
                'list' => ProformaInvoiceModel::query()->get()
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
            'js/ProformaInvoice/two',
            'js/ProformaInvoice/three',
        ], [
            'css/ProformaInvoice/add|edit-ProformaInvoice'
        ],
            [
                'priceSuggestionData' => $getPriceSuggestionData,
                'brands' => brandsModel::query()->get(),
                'country' => CountryModel::query()->get(),
                'state' => StateModel::query()->where('country_id', $getPriceSuggestionData->country_id)->get(),
                'cities' => CityModel::query()->where('state_id', $getPriceSuggestionData->state_id)->get(),
                'salesTeam' => SalesTeamModel::query()->get(),
            ]
        )->display('ProformaInvoice/add|edit-ProformaInvoice.tpl');
    }

    public function editIndex($id): void
    {
        $getData = $this->defaultModel::query()->find($id);
        $invoiceSetting = ProformaInvoiceSettingsModel::query()->where('brand_id', $getData->brand_id)->first();
        $decodeInvoiceSetting = json_decode($invoiceSetting->charges_deductions_order, true);
        $result = [];
        foreach ($decodeInvoiceSetting as $item) {
            $chargesDeductions = ChargesDeductionsModel::query()->find($item['charges_deduction_id']);
            $result[] = [
                'charges_deduction_id' => $item['charges_deduction_id'],
                'title' => $chargesDeductions->title,
                'identifier' => $chargesDeductions->identifier,
                'coefficient' => $chargesDeductions->coefficient,
                'netSumMerge' => $item['netSumMerge'],
            ];
        }
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel($getData);
        view->ui([
            'js/ProformaInvoice/add|edit-ProformaInvoice',
            'js/ProformaInvoice/one',
            'js/ProformaInvoice/two',
            'js/ProformaInvoice/three',
        ], [], [
            'brands' => brandsModel::query()->get(),
            'country' => CountryModel::query()->get(),
            'state' => StateModel::query()->where('country_id', $getData->country_id)->get(),
            'cities' => CityModel::query()->where('state_id', $getData->state_id)->get(),
            'invoiceProduct' => ProformaInvoiceProductsModel::query()->where('proforma_invoice_id', $id)->get(),
            'invoiceDetail' => ProformaInvoiceDetailsModel::query()->where('proforma_invoice_id', $id)->first(),
            'products' => ProductModel::query()->get(),
            'salesTeam' => SalesTeamModel::query()->get(),
            'invoiceSettings' => $result
        ])->display('ProformaInvoice/add|edit-ProformaInvoice.tpl');
    }

    private function generateInvoiceNumber($id): string
    {
        $today = date('Y-m-d 00:00:00');
        $count = ProformaInvoiceModel::query()->where('created_at', '>=', $today)->count();
        return 'PI-' . jdate("Ymd") . $count . '-' . $id;
    }

    public function add(): void
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $makeProformaInvoiceData = [
            'price_suggestion_id' => $data['price_suggestion_id'],
            'contact_id' => $data['contact_id'],
            'company_id',
            'contact_project_followup_id' => $data['contact_project_followup_id'],
            'delivery_date' => $data['delivery_date'],
            'brand_id' => $data['brand_id'],
            'sale_team_id' => $data['sale_team_id'] ?? null,
            'country_id' => $data['country_id'],
            'state_id' => $data['state_id'],
            'city_id' => $data['city_id'],
            'marketer_id' => $data['marketer_id'] ?? null,
            'marketer_commission' => $data['marketer_commission'] ?? null,
            'day_validity' => $data['day_validity'],
            'day_validity_timestamp' => time() + ($data['day_validity'] * 86400),
            'user_id' => userObject()->userId,
        ];
        $addProformaInvoice = ProformaInvoiceModel::query()->create($makeProformaInvoiceData);
        if (!$addProformaInvoice) {
            $this->failedCallBack(`/ProformaInvoice/createProformaInvoice/{$data['price_suggestion_id']}`, 'خطا در ثبت پیشفاکتور');
        }
        if ($addProformaInvoice) {
            $addProformaInvoice->update([
                'invoice_number' => $this->generateInvoiceNumber($addProformaInvoice->id)
            ]);
            $brandId = $addProformaInvoice->brand_id;
            $proformaInvoiceSettings = ProformaInvoiceSettingsModel::query()->where('brand_id', $brandId)->first();
            $decodeChargesDeductions = json_decode($proformaInvoiceSettings->charges_deductions_order, true);
            $makeChargesDeductions = [];
            foreach ($decodeChargesDeductions as $item) {
                $chargesDeductionsInfo = ChargesDeductionsModel::query()->find($item['charges_deduction_id']);
                if (in_array($chargesDeductionsInfo->identifier, $data['chargesDeductionCheckBox'])) {
                    $makeChargesDeductions[] = [
                        'netSumMerge' => $item['netSumMerge'] ?? false,
                        'charges_deduction_id' => $item['charges_deduction_id'],
                        'title' => $chargesDeductionsInfo->title,
                        'coefficient' => $chargesDeductionsInfo->coefficient,
                        'identifier' => $chargesDeductionsInfo->identifier,
                    ];
                }
            }

            $invoice_sum = 0;
            $invoice_sum_discount = 0;
            $invoice_net_sum = 0;

            foreach ($data['productList'] as $item) {
                $productInfo = ProductModel::query()->find($item['product_id']);
                $unitDiscount = 0;
                if ($item['discount_type'] == 'percentage') {
                    $unitDiscount = (numberNormalizer->removePriceSeparator($item['discount_unit_amount']) * numberNormalizer->removePriceSeparator($item['product_unit_price']) / 100);
                } else if ($item['discount_type'] == 'cash') {
                    $unitDiscount = numberNormalizer->removePriceSeparator($item['discount_unit_amount']);
                }
                $invoiceProduct = [
                    'proforma_invoice_id' => $addProformaInvoice->id,
                    'product_id' => $item['product_id'],
                    'amount' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_amount'])),
                    'unit_price' => numberHelper->persianNumberToEnglish($productInfo->sale_price),
                    'unit_price_edit' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_unit_price'])),
                    'sum_unit_price' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_unit_price'])) * numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_amount'])),
                    'discount_type' => (($item['discount_type']) ?: 'noDiscount'),
                    'discount_unit_amount' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['discount_unit_amount'])),
                    'discount_unit_amount_cash' => $unitDiscount,
                    'discount_amount' => numberNormalizer->removePriceSeparator($item['discount_amount']),
                    'total_unit_price' => numberNormalizer->removePriceSeparator($item['unit_price_after_discount']),
                    'total_product_price' => numberNormalizer->removePriceSeparator($item['product_amount']) * (numberNormalizer->removePriceSeparator($item['unit_price_after_discount'])),
                ];

                $invoice_sum += $invoiceProduct['amount'] * $invoiceProduct['unit_price'];
                $invoice_sum_discount += $unitDiscount * $invoiceProduct['amount'];
                $invoice_net_sum += $invoiceProduct['total_unit_price'] * $invoiceProduct['amount'];
                ProformaInvoiceProductsModel::query()->create($invoiceProduct);
            }

            $invoice_sum_tax_details = [];
            $mergeToNetSum = 0;
            foreach ($makeChargesDeductions as $row) {
                if ($row['netSumMerge']) {
                    $mergeToNetSum += $invoice_net_sum * ($row['coefficient'] - 1);
                    $invoice_sum_tax_details[] = [
                        'charges_deduction_id' => $row['charges_deduction_id'],
                        'calculate' => $invoice_net_sum * ($row['coefficient'] - 1),
                        'coefficient' => round(($row['coefficient'] - 1), 2)
                    ];
                }
            }
            $sumTaxMergeToNetSum = $invoice_net_sum + $mergeToNetSum;
            $sumTaxAfterMerge = 0;
            foreach ($makeChargesDeductions as $row) {
                if (!$row['netSumMerge']) {
                    $sumTaxAfterMerge += $sumTaxMergeToNetSum * ($row['coefficient'] - 1);
                    $invoice_sum_tax_details[] = [
                        'charges_deduction_id' => $row['charges_deduction_id'],
                        'calculate' => $sumTaxMergeToNetSum * ($row['coefficient'] - 1),
                        'coefficient' => round(($row['coefficient'] - 1), 2)
                    ];
                }
            }
            $invoice_sum_tax = $mergeToNetSum + $sumTaxAfterMerge;
            $invoice_sum_total = $invoice_net_sum + $invoice_sum_tax;
            $makeProformaInvoiceDetail = [
                'proforma_invoice_id' => $addProformaInvoice->id,
                'expert_alias_name',
                'charges_deductions' => json_encode($makeChargesDeductions, JSON_UNESCAPED_UNICODE),
                'invoice_sum' => $invoice_sum,
                'invoice_sum_discount' => $invoice_sum_discount,
                'invoice_net_sum' => $invoice_net_sum,
                'invoice_sum_tax' => $invoice_sum_tax,
                'invoice_sum_tax_details' => json_encode($invoice_sum_tax_details, JSON_UNESCAPED_UNICODE),
                'invoice_sum_total' => $invoice_sum_total,
                'payment_terms' => $data['payment_terms'],
                'bottom_invoice_text' => $data['bottom_invoice_text'],
            ];
            $addProformaInvoiceDetail = ProformaInvoiceDetailsModel::query()->create($makeProformaInvoiceDetail);
            if ($addProformaInvoiceDetail) {
                $this->successCallBack('/ProformaInvoice/main', "پیشفاکتور با شماره {$addProformaInvoice->invoice_number} با موفقیت ثبت شد.");
            } else {
                $this->failedCallBack("/ProformaInvoice/createProformaInvoice/{$data['price_suggestion_id']}", 'خطا در ثبت اطلاعات پیشفاکتور');
            }
        }
    }

    private function invoiceLog($invoiceId): bool
    {
        $invoice = ProformaInvoiceModel::query()->findOrFail($invoiceId)->toArray();
        $invoiceProduct = ProformaInvoiceProductsModel::query()->where('proforma_invoice_id', $invoiceId)->get()->toArray();
        $invoiceDetail = ProformaInvoiceDetailsModel::query()->where('proforma_invoice_id', $invoiceId)->get()->toArray();
        $makeData = [
            'proforma_invoice_id' => $invoiceId,
            'ProformaInvoice' => json_encode($invoice, JSON_UNESCAPED_UNICODE),
            'ProformaInvoiceProducts' => json_encode($invoiceProduct, JSON_UNESCAPED_UNICODE),
            'ProformaInvoiceDetails' => json_encode($invoiceDetail, JSON_UNESCAPED_UNICODE),
            'user_id' => userObject()->userId,
        ];
        $addLog = ProformaInvoiceLogModel::query()->create($makeData);
        if ($addLog)
            return true;
        else
            return false;
    }

//    public function edit($id): void
//    {
//        csrf->csrfValidate();
//        $find = ProformaInvoiceModel::query()->findOrFail($id);
//        if (!$this->invoiceLog($find->id)){
//            $this->failedCallBack("/ProformaInvoice/editIndex/{$id}", 'خطا در ذخیره سازی اطلاعات اولیه پیشفاکتور');
//        }
//        $data = $this->requestArray();
//        $makeProformaInvoiceData = [
//            'company_id',
//            'contact_project_followup_id' => $data['contact_project_followup_id'],
//            'delivery_date' => $data['delivery_date'],
//            'brand_id' => $data['brand_id'],
//            'sale_team_id' => $data['sale_team_id'] ?? null,
//            'country_id' => $data['country_id'],
//            'state_id' => $data['state_id'],
//            'city_id' => $data['city_id'],
//            'marketer_id' => $data['marketer_id'] ?? null,
//            'marketer_commission' => $data['marketer_commission'] ?? null,
//            'day_validity' => $data['day_validity'],
//            'day_validity_timestamp' => time() + ($data['day_validity'] * 86400),
//            'user_id' => userObject()->userId,
//        ];
//        $update = $find->update($makeProformaInvoiceData);
//        if (!$update) {
//            $this->failedCallBack(`/ProformaInvoice/editIndex/{$id}`, 'خطا در ویرایش پیشفاکتور');
//        } else {
//            $brandId = $find->brand_id;
//            $proformaInvoiceSettings = ProformaInvoiceSettingsModel::query()->where('brand_id', $brandId)->first();
//            $decodeChargesDeductions = json_decode($proformaInvoiceSettings->charges_deductions_order, true);
//            $makeChargesDeductions = [];
//            foreach ($decodeChargesDeductions as $item) {
//                $chargesDeductionsInfo = ChargesDeductionsModel::query()->find($item['charges_deduction_id']);
//                if (in_array($chargesDeductionsInfo->identifier, $data['chargesDeductionCheckBox'])) {
//                    $makeChargesDeductions[] = [
//                        'netSumMerge' => $item['netSumMerge'] ?? false,
//                        'charges_deduction_id' => $item['charges_deduction_id'],
//                        'title' => $chargesDeductionsInfo->title,
//                        'coefficient' => $chargesDeductionsInfo->coefficient,
//                        'identifier' => $chargesDeductionsInfo->identifier,
//                    ];
//                }
//            }
//            $invoice_sum = 0;
//            $invoice_sum_discount = 0;
//            $invoice_net_sum = 0;
//            $invoiceProducts = [];
//            foreach ($data['productList'] as $item) {
//                $productInfo = ProductModel::query()->find($item['product_id']);
//                $unitDiscount = 0;
//                if ($item['discount_type'] == 'percentage') {
//                    $unitDiscount = (numberNormalizer->removePriceSeparator($item['discount_unit_amount']) * numberNormalizer->removePriceSeparator($item['product_unit_price']) / 100);
//                } else if ($item['discount_type'] == 'cash') {
//                    $unitDiscount = numberNormalizer->removePriceSeparator($item['discount_unit_amount']);
//                }
//                $invoiceProducts[] = [
//                    'id' => $item['productId']??null,
//                    'proforma_invoice_id' => $find->id,
//                    'product_id' => $item['product_id'],
//                    'amount' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_amount'])),
//                    'unit_price' => numberHelper->persianNumberToEnglish($productInfo->sale_price),
//                    'unit_price_edit' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_unit_price'])),
//                    'sum_unit_price' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_unit_price'])) * numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_amount'])),
//                    'discount_type' => (($item['discount_type']) ?: 'noDiscount'),
//                    'discount_unit_amount' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['discount_unit_amount'])),
//                    'discount_unit_amount_cash' => $unitDiscount,
//                    'discount_amount' => numberNormalizer->removePriceSeparator($item['discount_amount']),
//                    'total_unit_price' => numberNormalizer->removePriceSeparator($item['unit_price_after_discount']),
//                    'total_product_price' => numberNormalizer->removePriceSeparator($item['product_amount']) * (numberNormalizer->removePriceSeparator($item['unit_price_after_discount'])),
//                ];
//                $invoice_sum += numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_amount'])) * numberHelper->persianNumberToEnglish($productInfo->sale_price);
//                $invoice_sum_discount += $unitDiscount * numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_amount']));
//                $invoice_net_sum += numberNormalizer->removePriceSeparator($item['unit_price_after_discount']) * numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_amount']));
//            }
//            ProformaInvoiceProductsModel::query()->upsert($invoiceProducts,
//                ['id'], [
//                'proforma_invoice_id',
//                'product_id',
//                'amount',
//                'unit_price',
//                'unit_price_edit',
//                'sum_unit_price',
//                'discount_type',
//                'discount_unit_amount',
//                'discount_unit_amount_cash',
//                'discount_amount',
//                'total_unit_price',
//                'total_product_price',
//            ]);
//            $invoice_sum_tax_details = [];
//            $mergeToNetSum = 0;
//            foreach ($makeChargesDeductions as $row) {
//                if ($row['netSumMerge']) {
//                    $mergeToNetSum += $invoice_net_sum * ($row['coefficient'] - 1);
//                    $invoice_sum_tax_details[] = [
//                        'charges_deduction_id' => $row['charges_deduction_id'],
//                        'calculate' => $invoice_net_sum * ($row['coefficient'] - 1),
//                        'coefficient' => round(($row['coefficient'] - 1), 2)
//                    ];
//                }
//            }
//            $sumTaxMergeToNetSum = $invoice_net_sum + $mergeToNetSum;
//            $sumTaxAfterMerge = 0;
//            foreach ($makeChargesDeductions as $row) {
//                if (!$row['netSumMerge']) {
//                    $sumTaxAfterMerge += $sumTaxMergeToNetSum * ($row['coefficient'] - 1);
//                    $invoice_sum_tax_details[] = [
//                        'charges_deduction_id' => $row['charges_deduction_id'],
//                        'calculate' => $sumTaxMergeToNetSum * ($row['coefficient'] - 1),
//                        'coefficient' => round(($row['coefficient'] - 1), 2)
//                    ];
//                }
//            }
//            $invoice_sum_tax = $mergeToNetSum + $sumTaxAfterMerge;
//            $invoice_sum_total = $invoice_net_sum + $invoice_sum_tax;
//            $makeProformaInvoiceDetail = [
//                'expert_alias_name' => $data['expert_alias_name'] ?? null,
//                'charges_deductions' => json_encode($makeChargesDeductions, JSON_UNESCAPED_UNICODE),
//                'invoice_sum' => $invoice_sum,
//                'invoice_sum_discount' => $invoice_sum_discount,
//                'invoice_net_sum' => $invoice_net_sum,
//                'invoice_sum_tax' => $invoice_sum_tax,
//                'invoice_sum_tax_details' => json_encode($invoice_sum_tax_details, JSON_UNESCAPED_UNICODE),
//                'invoice_sum_total' => $invoice_sum_total,
//                'payment_terms' => $data['payment_terms'],
//                'bottom_invoice_text' => $data['bottom_invoice_text'],
//            ];
//            $editProformaInvoiceDetail = ProformaInvoiceDetailsModel::query()->where('proforma_invoice_id', $id)->first();
//            if ($editProformaInvoiceDetail) {
//                $editProformaInvoiceDetail->update($makeProformaInvoiceDetail);
//                $this->successCallBack("/ProformaInvoice/main", 'پیشفاکتور ویرایش شد');
//            } else {
//                $this->failedCallBack("/ProformaInvoice/editIndex/{$id}", 'خطا در ثبت اطلاعات پیشفاکتور');
//            }
//        }
//    }


    public function edit($id): void
    {
        csrf->csrfValidate();
        try {
            $find = ProformaInvoiceModel::query()->findOrFail($id);
            $data = $this->requestArray();
            $toNumber = static function ($value): float {
                $value = $value ?? 0;
                return (float) numberHelper->persianNumberToEnglish(
                    numberNormalizer->removePriceSeparator((string) $value)
                );
            };
            $connection = $find->getConnection();
            $connection->beginTransaction();
            try {
                if (!$this->invoiceLog($find->id)) {
                    throw new \RuntimeException(
                        'خطا در ثبت تاریخچه پیش‌فاکتور.'
                    );
                }
                $dayValidity = (int) ($data['day_validity'] ?? 0);
                $makeProformaInvoiceData = [
                    'company_id' => $data['company_id'] ?? null,
                    'contact_project_followup_id' => $data['contact_project_followup_id'] ?? null,
                    'delivery_date' => $data['delivery_date'] ?? null,
                    'brand_id' => $data['brand_id'],
                    'sale_team_id' => $data['sale_team_id'] ?? null,
                    'country_id' => $data['country_id'] ?? null,
                    'state_id' => $data['state_id'] ?? null,
                    'city_id' => $data['city_id'] ?? null,
                    'marketer_id' => $data['marketer_id'] ?? null,
                    'marketer_commission' => $data['marketer_commission'] ?? null,
                    'day_validity' => $dayValidity,
                    'day_validity_timestamp' => time() + ($dayValidity * 86400),
                    'user_id' => userObject()->userId,
                ];

                if (!$find->update($makeProformaInvoiceData)) {
                    throw new \RuntimeException(
                        'خطا در ویرایش اطلاعات اصلی پیش‌فاکتور.'
                    );
                }
                $proformaInvoiceSettings = ProformaInvoiceSettingsModel::query()
                    ->where('brand_id', $find->brand_id)
                    ->first();

                $decodeChargesDeductions = json_decode(
                    $proformaInvoiceSettings->charges_deductions_order ?? '[]',
                    true
                ) ?? [];
                $chargesDeductionCheckBox = $data['chargesDeductionCheckBox'] ?? [];
                $makeChargesDeductions = [];
                foreach ($decodeChargesDeductions as $item) {
                    $chargesDeductionId = $item['charges_deduction_id'] ?? null;
                    if (!$chargesDeductionId) {
                        continue;
                    }
                    $chargesDeductionsInfo = ChargesDeductionsModel::query()
                        ->find($chargesDeductionId);
                    if (!$chargesDeductionsInfo) {
                        continue;
                    }
                    if (in_array(
                        $chargesDeductionsInfo->identifier,
                        $chargesDeductionCheckBox,
                        true
                    )) {
                        $makeChargesDeductions[] = [
                            'netSumMerge' => filter_var(
                                $item['netSumMerge'] ?? false,
                                FILTER_VALIDATE_BOOLEAN
                            ),
                            'charges_deduction_id' => $chargesDeductionId,
                            'title' => $chargesDeductionsInfo->title,
                            'coefficient' => (float) $chargesDeductionsInfo->coefficient,
                            'identifier' => $chargesDeductionsInfo->identifier,
                        ];
                    }
                }

                // محاسبه مبالغ محصولات
                $invoice_sum = 0;
                $invoice_sum_discount = 0;
                $invoice_net_sum = 0;
                $savedProductIds = [];
                foreach ($data['productList'] ?? [] as $item) {
                    $productId = $item['product_id'] ?? null;
                    if (!$productId) {
                        throw new \RuntimeException(
                            'شناسه یکی از محصولات معتبر نیست.'
                        );
                    }
                    $productInfo = ProductModel::query()->find($productId);
                    if (!$productInfo) {
                        throw new \RuntimeException(
                            "محصول با شناسه {$productId} پیدا نشد."
                        );
                    }
                    $amount = $toNumber($item['product_amount'] ?? 0);

                    if ($amount <= 0) {
                        throw new \RuntimeException(
                            'تعداد محصولات باید بیشتر از صفر باشد.'
                        );
                    }
                    $unitPrice = $toNumber(
                        $item['product_unit_price'] ?? 0
                    );
                    $originalUnitPrice = $toNumber(
                        $productInfo->sale_price
                    );
                    $discountType = $item['discount_type'] ?? 'noDiscount';
                    $discountUnitAmount = $toNumber(
                        $item['discount_unit_amount'] ?? 0
                    );
                    $unitDiscount = 0;
                    if ($discountType === 'percentage') {
                        $unitDiscount = $unitPrice * $discountUnitAmount / 100;
                    } elseif ($discountType === 'cash') {
                        $unitDiscount = $discountUnitAmount;
                    } else {
                        $discountType = 'noDiscount';
                    }
                    $unitDiscount = min(
                        max($unitDiscount, 0),
                        $unitPrice
                    );
                    $unitPriceAfterDiscount = $unitPrice - $unitDiscount;
                    $sumUnitPrice = $unitPrice * $amount;
                    $discountAmount = $unitDiscount * $amount;
                    $totalProductPrice = $unitPriceAfterDiscount * $amount;
                    $invoice_sum += $sumUnitPrice;
                    $invoice_sum_discount += $discountAmount;
                    $invoice_net_sum += $totalProductPrice;
                    $productData = [
                        'proforma_invoice_id' => $find->id,
                        'product_id' => $productId,
                        'amount' => $amount,
                        'unit_price' => $originalUnitPrice,
                        'unit_price_edit' => $unitPrice,
                        'sum_unit_price' => $sumUnitPrice,
                        'discount_type' => $discountType,
                        'discount_unit_amount' => $discountUnitAmount,
                        'discount_unit_amount_cash' => $unitDiscount,
                        'discount_amount' => $discountAmount,
                        'total_unit_price' => $unitPriceAfterDiscount,
                        'total_product_price' => $totalProductPrice,
                    ];
                    $existingProductId = $item['productId'] ?? null;
                    if (!empty($existingProductId)) {
                        $invoiceProduct = ProformaInvoiceProductsModel::query()
                            ->where('id', $existingProductId)
                            ->where('proforma_invoice_id', $find->id)
                            ->first();
                        if (!$invoiceProduct) {
                            throw new \RuntimeException(
                                'محصول ارسالی متعلق به این پیش‌فاکتور نیست.'
                            );
                        }
                        if (!$invoiceProduct->update($productData)) {
                            throw new \RuntimeException(
                                'خطا در ویرایش محصول پیش‌فاکتور.'
                            );
                        }

                    } else {

                        $invoiceProduct = ProformaInvoiceProductsModel::query()
                            ->create($productData);

                        if (!$invoiceProduct) {
                            throw new \RuntimeException(
                                'خطا در ثبت محصول جدید.'
                            );
                        }
                    }

                    $savedProductIds[] = $invoiceProduct->id;
                }
                $deletedProductsQuery = ProformaInvoiceProductsModel::query()
                    ->where('proforma_invoice_id', $find->id);

                if (!empty($savedProductIds)) {

                    $deletedProductsQuery->whereNotIn(
                        'id',
                        $savedProductIds
                    );
                }

                $deletedProductsQuery->delete();
                $invoice_sum_tax_details = [];
                $mergeToNetSum = 0;
                foreach ($makeChargesDeductions as $row) {

                    if ($row['netSumMerge']) {

                        $calculate = $invoice_net_sum * (
                                $row['coefficient'] - 1
                            );

                        $mergeToNetSum += $calculate;

                        $invoice_sum_tax_details[] = [
                            'charges_deduction_id' => $row['charges_deduction_id'],
                            'calculate' => $calculate,
                            'coefficient' => round(
                                $row['coefficient'] - 1,
                                2
                            ),
                        ];
                    }
                }
                $sumTaxMergeToNetSum = $invoice_net_sum + $mergeToNetSum;
                $sumTaxAfterMerge = 0;
                foreach ($makeChargesDeductions as $row) {
                    if (!$row['netSumMerge']) {
                        $calculate = $sumTaxMergeToNetSum * (
                                $row['coefficient'] - 1
                            );
                        $sumTaxAfterMerge += $calculate;
                        $invoice_sum_tax_details[] = [
                            'charges_deduction_id' => $row['charges_deduction_id'],
                            'calculate' => $calculate,
                            'coefficient' => round(
                                $row['coefficient'] - 1,
                                2
                            ),
                        ];
                    }
                }
                $invoice_sum_tax = $mergeToNetSum + $sumTaxAfterMerge;
                $invoice_sum_total = $invoice_net_sum + $invoice_sum_tax;
                $makeProformaInvoiceDetail = [
                    'expert_alias_name' => $data['expert_alias_name'] ?? null,
                    'charges_deductions' => json_encode(
                        $makeChargesDeductions,
                        JSON_UNESCAPED_UNICODE
                    ),
                    'invoice_sum' => $invoice_sum,
                    'invoice_sum_discount' => $invoice_sum_discount,
                    'invoice_net_sum' => $invoice_net_sum,
                    'invoice_sum_tax' => $invoice_sum_tax,
                    'invoice_sum_tax_details' => json_encode(
                        $invoice_sum_tax_details,
                        JSON_UNESCAPED_UNICODE
                    ),
                    'invoice_sum_total' => $invoice_sum_total,
                    'payment_terms' => $data['payment_terms'] ?? null,
                    'bottom_invoice_text' => $data['bottom_invoice_text'] ?? null,
                ];
                $editProformaInvoiceDetail = ProformaInvoiceDetailsModel::query()
                    ->where('proforma_invoice_id', $find->id)
                    ->first();
                if ($editProformaInvoiceDetail) {
                    if (!$editProformaInvoiceDetail->update(
                        $makeProformaInvoiceDetail
                    )) {
                        throw new \RuntimeException(
                            'خطا در ویرایش جزئیات پیش‌فاکتور.'
                        );
                    }
                } else {

                    $makeProformaInvoiceDetail['proforma_invoice_id'] = $find->id;

                    $newDetail = ProformaInvoiceDetailsModel::query()
                        ->create($makeProformaInvoiceDetail);

                    if (!$newDetail) {
                        throw new \RuntimeException(
                            'خطا در ثبت جزئیات پیش‌فاکتور.'
                        );
                    }
                }

                $connection->commit();

            } catch (\Throwable $e) {

                $connection->rollBack();

                throw $e;
            }

            $this->successCallBack(
                "/ProformaInvoice/main",
                'پیش‌فاکتور با موفقیت ویرایش شد.'
            );

        } catch (\Throwable $e) {

            error_log(
                'ProformaInvoice Edit Error: ' .
                $e->getMessage() .
                ' | Line: ' . $e->getLine() .
                ' | File: ' . $e->getFile()
            );

            $this->failedCallBack(
                "/ProformaInvoice/editIndex/{$id}",
                'خطا در ویرایش پیش‌فاکتور: ' . $e->getMessage()
            );
        }
    }



    public function process(int $invoiceId): void
    {
        $_ENV['APP_DEBUG'] = 1;
        $getData = ProformaInvoiceModel::query()
            ->with([
                'invoiceDetail',
                'invoiceProduct',
                'invoiceLog',
            ])
            ->withCount('invoiceProduct')
            ->withCount('invoiceLog')
            ->find($invoiceId);
        if ($getData) {

            $scripts = [
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
                'vendors/js/charts/apexcharts4.min',
                'js/ProformaInvoice/process-ProformaInvoice',
            ];

            //*********************** steps configs ***********************//

            $stepsConfig = [
                [
                    'title' => 'خلاصه پیش فاکتور',
                    'description' => 'مشاهده اطلاعات و جزئیات پیش فاکتور صادر شده',
                    'icon' => 'bx-file',
                    'stepFile' => 'view/ProformaInvoice/processSteps/stepOne.tpl',
                    'scriptFile' => 'js/ProformaInvoice/processSteps/stepOne',
                ],
                [
                    'title' => 'تخصیص محصول',
                    'description' => 'تعیین و تخصیص محصولات به پیش فاکتور',
                    'icon' => 'bx-package',
                    'stepFile' => 'view/ProformaInvoice/processSteps/stepTwo.tpl',
                    'scriptFile' => 'js/ProformaInvoice/processSteps/stepTwo',
                ],
                [
                    'title' => 'اعلام خروج',
                    'description' => 'ثبت درخواست خروج و اعلام آمادگی بار برای ارسال',
                    'icon' => 'bx-log-out',
                    'stepFile' => 'view/ProformaInvoice/processSteps/stepThree.tpl',
                    'scriptFile' => 'js/ProformaInvoice/processSteps/stepThree',
                ],
                [
                    'title' => 'اعلام آدرس',
                    'description' => 'ثبت آدرس مقصد جهت ارسال و تحویل بار',
                    'icon' => 'bx-map',
                    'stepFile' => 'view/ProformaInvoice/processSteps/stepFour.tpl',
                    'scriptFile' => 'js/ProformaInvoice/processSteps/stepFour',
                ],
                [
                    'title' => 'خروج بار',
                    'description' => 'ثبت و پیگیری عملیات خروج و ارسال بار',
                    'icon' => 'bx-truck',
                    'stepFile' => 'view/ProformaInvoice/processSteps/stepFive.tpl',
                    'scriptFile' => 'js/ProformaInvoice/processSteps/stepFive',
                ],
            ];

            //*********************** steps configs ***********************//

            //*********************** sections configs ***********************//
            $sectionsConfig = [
                "mainSections" => [
                    [
                        "name" => "summaryProcess",
                        "title" => "خلاصه وضعیت",
                        "activeStep" => true,
                        "description" => "نمای کلی از وضعیت پیش فاکتور و میزان پیشرفت فرآیند",
                        "icon" => "bx-dashboard info",
                        "sectionFile" => "view/ProformaInvoice/sectionsProcess/summaryProcess-sectionsProcess.tpl",
                        "scriptFile" => "js/ProformaInvoice/sectionsProcess/summaryProcess-sectionsProcess",
                        "variables" => [
                            "invoiceLog"=>$getData->invoiceLog
                        ]
                    ],
                    [
                        "name" => "salesProcess",
                        "title" => "فرآیند فروش",
                        "description" => "مشاهده و مدیریت مراحل اجرایی فرآیند فروش",
                        "icon" => "bx-shopping-bag success",
                        "sectionFile" => "view/ProformaInvoice/sectionsProcess/salesProcess-sectionsProcess.tpl",
                        "scriptFile" => "js/ProformaInvoice/sectionsProcess/salesProcess-sectionsProcess",
                        "variables" => [
                            "contact" => $getData->contact ?? [],
                            "company" => $getData->company ?? [],
                            "expert" => $getData->expert ?? [],
                            "saleTeam" => $getData->saleTeam ?? [],
                            "brand" => $getData->brand ?? [],
                            "state" => $getData->state ?? [],
                            "city" => $getData->city ?? [],
                        ]
                    ],
                    [
                        "name" => "financialProcess",
                        "title" => "فرآیند مالی",
                        "description" => "مشاهده و پیگیری وضعیت مالی و تراکنش‌های پیش فاکتور",
                        "icon" => "bx-wallet warning",
                        "sectionFile" => "view/ProformaInvoice/sectionsProcess/financialProcess-sectionsProcess.tpl",
                        "scriptFile" => "js/ProformaInvoice/sectionsProcess/financialProcess-sectionsProcess",
                        "variables" => []
                    ],
                ],
                "moreSections" => [
                    [
                        "name" => "cartables",
                        "title" => "کارتابل‌ها",
                        "description" => "مشاهده و پیگیری کارهای ارجاع‌شده و اقدامات مورد نیاز",
                        "icon" => "bx-task",
                        "appendAfterDivider" => false,
                        "sectionFile" => "view/ProformaInvoice/sectionsProcess/cartable-sectionsProcess.tpl",
                        "scriptFile" => "js/ProformaInvoice/sectionsProcess/cartable-sectionsProcess",
                        "variables" => []
                    ]
                ]
            ];
            $sectionsVariables = call_user_func(function () use ($sectionsConfig) {
                foreach ($sectionsConfig as $sectionKey => $sectionData) {
                    $output[$sectionKey] = [];

                    foreach ($sectionData as $item) {
                        if (!empty($item['variables'])) {
                            $output[$sectionKey] += $item['variables'];
                        }
                    }
                }
                return $output ?? [];
            });
            $sectionsScripts = array_map(function ($data) {
                return array_column($data, 'scriptFile');
            }, $sectionsConfig);

            //*********************** sections configs ***********************//

            //*********************** options configs ***********************//

            $optionsConfig = [
                //[
                //    "name" => ..., //englishName
                //    "title" => ..., //persianTitle
                //    "description" => "",
                //    "icon" => "bx-check-shield",
                //    "type" => ..., //button , a   default = a
                //    "href" => ...,
                //    "target" => ..., //default:_self
                //    "class" => ...,
                //    "scriptFile" => ... //js file
                //]
                [
                    "name" => "edit_invoice",
                    "title" => "ویرایش پیش فاکتور",
                    "description" => "",
                    "href" => "/ProformaInvoice/editIndex/{$invoiceId}",
                    "icon" => "bx-edit warning",
                    "scriptFile" => ''
                ],
                [
                    "name" => "submit_guarantee",
                    "title" => "ثبت تضامین",
                    "description" => "",
                    "icon" => "bx-check-shield success",
                    "type" => 'button',
                    "scriptFile" => ''
                ],
                [
                    "name" => "payment_allocation",
                    "title" => "تخصیص واریزی",
                    "description" => "",
                    "type" => 'button',
                    "icon" => "bx-check-shield primary",
                    "scriptFile" => 'js/ProformaInvoice/options/paymentAllocation'
                ],
                [
                    "name" => "submit_addendum",
                    "title" => "ثبت الحاقیه",
                    "description" => "",
                    "type" => 'button',
                    "icon" => "bx-plus-circle info",
                    "scriptFile" => ''
                ],
                [
                    "name" => "cancel_contract",
                    "title" => "لغو قرارداد",
                    "description" => "",
                    "type" => 'button',
                    "icon" => "bx-x-circle danger",
                    "scriptFile" => ''
                ]
            ];

            //*********************** options configs ***********************//
            view->setPageTitle("فرآیند فروش");
            view->setSingleName("فرآیند فروش");
            view->setModel($getData);
            view->ui(
                array_merge(
                    $scripts, //static
                    array_merge($sectionsScripts['mainSections'], $sectionsScripts['moreSections']), //sections
                    array_filter(array_column($optionsConfig, 'scriptFile')), //options
                    array_map(
                        fn($item) => $item['scriptFile'],
                        array_filter($stepsConfig, function ($item) {
                            if (!isset($item['conditions'])) {
                                return true;
                            }
                            return !in_array(false, array_column((array)$item['conditions'], 'condition'), true);
                        })
                    ), //steps
                ),
                ['vendors/css/tables/datatable/datatables.min'],
                array_merge(
                    [
                        "stepsConfig" => $stepsConfig,
                        "sectionsConfig" => $sectionsConfig,
                    ],
                    $sectionsVariables['mainSections'] ?? [], //sections
                    $sectionsVariables['moreSections'] ?? [], //sections
                    [
                        'cartables' => [
                            //cartables data
                        ],
                        'optionsConfig' => $optionsConfig
                    ]
                )
            )->display('ProformaInvoice/process-ProformaInvoice.tpl');
        } else {
            header('location: /notAccess');
        }
    }
}