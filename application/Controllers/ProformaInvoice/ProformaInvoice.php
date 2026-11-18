<?php

namespace App\Controllers\ProformaInvoice;

use App\Controllers\scheme\ControllerScheme;
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

    public function addIndex(): void
    {
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

    public function process(int $invoiceId): void
    {
        $getData = true; //replace with invoiceData
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
                    'title' => 'پیش فاکتور',
                    'description' => 'اطلاعات اولیه پیش فاکتور صادر شده',
                    'icon' => 'bx-task',
                    'stepFile' => 'view/ProformaInvoice/processSteps/stepOne.tpl',
                    'scriptFile' => 'js/ProformaInvoice/processSteps/stepOne',
                ]
            ];

            //*********************** steps configs ***********************//

            //*********************** sections configs ***********************//
            $sectionsConfig = [
                "mainSections" => [
                    [
                        "name" => "salesProcess",
                        "title" => "فرآیند فروش",
                        "activeStep" => true,
                        "description" => "",
                        "icon" => "",
                        "sectionFile" => "view/ProformaInvoice/sectionsProcess/salesProcess-sectionsProcess.tpl",
                        "scriptFile" => "js/ProformaInvoice/sectionsProcess/salesProcess-sectionsProcess",
                        "variables" => []
                    ],
                ],
                "moreSections" => [
                    [
                        "name" => "cartables",
                        "title" => "کارتابل ها",
                        "description" => "",
                        "icon" => "",
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
                    "name" => "submit_guarantee",
                    "title" => "ثبت تضامین",
                    "description" => "",
                    "icon" => "bx-check-shield success",
                    "type" => 'button',
                    "scriptFile" => ''
                ],
                [
                    "name" => "edit_invoice",
                    "title" => "ویرایش پیش فاکتور",
                    "description" => "",
                    "href" => "#",
                    "icon" => "bx-edit warning",
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
                    "icon" => "bx-plus-circle danger",
                    "scriptFile" => ''
                ]
            ];

            //*********************** options configs ***********************//

            view->setPageTitle("فرآیند فروش روغن");
            view->setSingleName("فرآیند فروش روغن");
//            view->setModel($getData);
            view->ui(
                array_merge(
                    $scripts, //static
                    array_merge($sectionsScripts['mainSections'], $sectionsScripts['moreSections']), //sections
                    array_column($optionsConfig, 'scriptFile'), //options
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

