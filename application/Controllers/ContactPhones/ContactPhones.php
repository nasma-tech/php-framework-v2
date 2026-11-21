<?php

namespace App\Controllers\ContactPhones;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ContactPhonesModel\ContactPhonesModel;

class ContactPhones extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = ContactPhonesModel::class;

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
            //'js/ContactPhones/ContactPhones'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ContactPhones/ContactPhones.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ContactPhones/add-ContactPhones'
        ], [],
            [//vars
            ]
        )->display('ContactPhones/add-ContactPhones.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ContactPhones/edit-ContactPhones'
        ], [], [
            //var
        ])->display('ContactPhones/edit-ContactPhones.tpl');
    }

    public function add()
    {
        $data = $this->requestArray('contactPhone', []);
        if (!empty($data)) {
            foreach ($data as $item) {
                $this->checkRequired([
                    'contact_phone_label_id' => 'عنوان تماس',
                    'phone_number' => 'شماره تماس',
                ], $item);
                $socialList = $item['socialList'] ?? [];
                unset($item['socialList']);
                $item['contact_id'] = $this->requestArray()['contact_id'];
                $item['user_id'] = userObject()->userId;
                $addPhoneContact = ContactPhonesModel::query()->create($item);
                if (!empty($socialList)) {
                    $addPhoneContact->socialNetworks()->attach($socialList);
                }
            }
            $this->successCallBack("/CustomerContactInformation/contactDetail/{$this->requestArray()['contact_id']}", 'شماره تماس با موفقیت اضافه شد');
        } else {
            $this->failedCallBack("/CustomerContactInformation/contactDetail/{$this->requestArray()['contact_id']}", 'شماره ای جهت افزودن یافت نشد');

        }

    }

    public function checkNumberInput()
    {
        $data = $this->requestArray();
        $checkData = ContactPhonesModel::query()->with('contactDetail')->where('phone_number', $data['phone_number'])->first();
//        dd($checkData);
        if (!empty($checkData)) {
            echo json_encode([
                "status" => 'exist',
                'contactFirstName' => $checkData->contactDetail->first_name,
                'contactLastName' => $checkData->contactDetail->last_name,
            ]);
        } else {
            echo json_encode([
                "status" => 'Nont_exist',
            ]);
        }
    }
}
