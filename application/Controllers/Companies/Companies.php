<?php

namespace App\Controllers\Companies;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CompaniesModel\CompaniesModel;

class Companies extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = CompaniesModel::class;

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
            //'js/Companies/Companies'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('Companies/Companies.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/Companies/add-Companies'
        ], [],
            [//vars
            ]
        )->display('Companies/add-Companies.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/Companies/edit-Companies'
        ], [], [
            //var
        ])->display('Companies/edit-Companies.tpl');
    }

    public function addCompanies()
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $makeRequest = [
            'national_ID' => numberHelper->persianNumberToEnglish($data['national_ID']),
            'company_name' => $data['company_name'],
            'establishment_date' => $data['establishment_date'] ?? date("Y-m-d", dateTimeHelper->convertDateToTimestamp($data['establishment_date'])),
            'company_status' => $data['company_status'],
            'registration_number' => numberHelper->persianNumberToEnglish($data['registration_number']),
            'economic_code' => numberHelper->persianNumberToEnglish($data['economic_code']),
            'address' => $data['address'],
            'postal_code' => numberHelper->persianNumberToEnglish($data['postal_code']),
            'lat' => $data['lat'] ?? null,
            'lang' => $data['lang'] ?? null,
        ];
        $companiesAdd = CompaniesModel::query()->create($makeRequest);
        if ($companiesAdd) {
            echo json_encode([
                'status' => true,
                'id' => $companiesAdd->id,
                'companyName' => $companiesAdd->company_name,
                'nationalID' => $companiesAdd->national_ID,
                'message' => 'با موفقیت ثبت شد'
            ], JSON_UNESCAPED_UNICODE);
        } else {
            echo json_encode([
                'status' => false,
                'message' => 'خطا در ثبت اطلاعات'
            ], JSON_UNESCAPED_UNICODE);
        }
    }
}
