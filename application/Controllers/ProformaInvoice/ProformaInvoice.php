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
use App\Models\ProformaInvoiceDetailsModel\ProformaInvoiceDetailsModel;
use App\Models\ProformaInvoiceModel\ProformaInvoiceModel;
use App\Models\ProformaInvoiceProductsModel\ProformaInvoiceProductsModel;
use App\Models\ProformaInvoiceSettingsModel\ProformaInvoiceSettingsModel;
use App\Models\StateModel\StateModel;

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
        $_ENV['APP_DEBUG'] = 1;
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

    private function generateInvoiceNumber($id): string
    {
        $today = date('Y-m-d 00:00:00');
        $count = ProformaInvoiceModel::query()->where('created_at', '>=', $today)->count();
        return 'PI-' . jdate("Ymd") . $count . '-' . $id;
    }

    public function add(): void
    {
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
            $invoice_sum_tax = 0;
            $invoice_sum_tax_details = 0;
            $invoice_sum_total = 0;


            foreach ($data['productList'] as $item) {
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
                    'unit_price' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['product_unit_price'])),
                    'discount_type' => (($item['discount_type']) ?: 'noDiscount'),
                    'discount_unit_amount' => numberHelper->persianNumberToEnglish(numberNormalizer->removePriceSeparator($item['discount_unit_amount'])),
                    'discount_unit_amount_cash' => $unitDiscount,
                    'discount_amount' => numberNormalizer->removePriceSeparator($item['discount_amount']),
                    'total_unit_price' => numberNormalizer->removePriceSeparator($item['unit_price_after_discount']),
                    'total_product_price' => numberNormalizer->removePriceSeparator($item['product_amount']) * (numberNormalizer->removePriceSeparator($item['unit_price_after_discount'])),
                ];

                //test
                $invoice_sum += $invoiceProduct['amount'] * $invoiceProduct['unit_price'];
                $invoice_sum_discount += $unitDiscount * $invoiceProduct['amount'];
                $invoice_net_sum += $invoiceProduct['total_unit_price'] * $invoiceProduct['amount'];

                //test
                ProformaInvoiceProductsModel::query()->create($invoiceProduct);
            }

            $firstSum = 0;
            foreach ($makeChargesDeductions as $row) {
                if ($row['netSumMerge']) {
                    $firstSum += $invoice_net_sum * ($row['coefficient'] - 1);
                }
            }
            $secondSum = $invoice_net_sum + $firstSum;
//            $thirdSum = 0;
//            foreach ($makeChargesDeductions as $row) {
//                if (!$row['netSumMerge']) {
//                    $secondSum
//                }
//            }
            var_print($invoice_sum_tax);


            $makeProformaInvoiceDetail = [
                'proforma_invoice_id' => $addProformaInvoice->proforma_invoice_id,
                'expert_alias_name',
                'charges_deductions' => json_encode($makeChargesDeductions, JSON_UNESCAPED_UNICODE),
                'invoice_sum' => $invoice_sum,
                'invoice_sum_discount' => $invoice_sum_discount,
                'invoice_net_sum' => $invoice_net_sum,
                'invoice_sum_tax'=>$invoice_sum_tax,
                'invoice_sum_tax_details',
                'invoice_sum_total',
                'payment_terms' => $data['payment_terms'],
                'bottom_invoice_text' => $data['bottom_invoice_text'],
            ];
            $addProformaInvoiceDetail = ProformaInvoiceDetailsModel::query()->create($makeProformaInvoiceDetail);
        }
    }

    public function process(int $invoiceId): void
    {
        $getData = $this->defaultModel::query()->find($invoiceId);
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
                        "variables" => []
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
                    "href" => "#",
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
                    "scriptFile" => ''
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