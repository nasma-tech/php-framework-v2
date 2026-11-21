<?php

namespace App\Controllers\ContactProjects;

use App\Controllers\CustomerContactInformation\CustomerContactInformation;
use App\Controllers\scheme\ControllerScheme;
use App\Models\ContactProjectRequestsModel\ContactProjectRequestsModel;
use App\Models\ContactProjectsModel\ContactProjectsModel;
use App\Models\ContactsGroupModel\ContactsGroupModel;
use App\Models\FollowUpActionsTitleModel\FollowUpActionsTitleModel;
use App\Models\IndustryTypeModel\IndustryTypeModel;
use App\Models\ProductModel\ProductModel;

class ContactProjects extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = ContactProjectsModel::class;

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
            //'js/ContactProjects/ContactProjects'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ContactProjects/ContactProjects.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ContactProjects/add-ContactProjects'
        ], [],
            [//vars

            ]
        )->display('ContactProjects/add-ContactProjects.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ContactProjects/edit-ContactProjects'
        ], [], [
            //var
        ])->display('ContactProjects/edit-ContactProjects.tpl');
    }

    public function ContactProjectDetail($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(ContactProjectsModel::query()
            ->with([
                'followUpData',
                'followUpData.priceSuggestionData',
            ])
            ->find($id));
        view->ui([
            'js/CustomerContactInformation/ContactProject',
            'js/CustomerContactInformation/ContactFollowUp',
            'js/CustomerContactInformation/ContactProjectDetail',
        ], [
            'css/CustomerContactInformation/ContactInfo',
        ], [
            'IndustryType' => IndustryTypeModel::query()->get(),
            'FollowUpActionsTitle' => FollowUpActionsTitleModel::query()->get(),
            'Products' => ProductModel::query()->get(),
        ])->display('CustomerContactInformation/ContactProjectDetail.tpl');
    }

    public function add(): void
    {
        $data = $this->requestArray();
        $customerContact = new CustomerContactInformation();
        $this->checkRequired([
            'payment_type' => 'نوع پرداخت',
            'purchase_type' => 'نوع خرید',
            'industry_type_id' => 'نوع صنعت',
        ], $data);
        $makeData = [
            'contact_id' => $data['contact_id'],
            'project_code' => $customerContact->createProjectCode($data['contact_id']),
            'payment_type' => $data['payment_type'],
            'purchase_type' => $data['purchase_type'],
            'industry_type_id' => $data['industry_type_id'],
            'user_id' => userObject()->userId,
        ];
        $addProject = ContactProjectsModel::query()->create($makeData);
        if (isset($data['projectRequest'])) {
            if ($addProject) {
                foreach ($data['projectRequest'] as $item) {
                    ContactProjectRequestsModel::query()->create([
                        'contact_project_id' => $addProject->id,
                        'product_id' => $item['product_id'],
                        'request_amount' => $item['request_amount'],
                        'user_id' => userObject()->userId,
                    ]);
                }
            }
        }
        if ($addProject) {
            $this->successCallBack("/CustomerContactInformation/contactDetail/{$data['contact_id']}", 'پروژه با موفقیت اضافه شد');
        } else {
            $this->failedCallBack("/CustomerContactInformation/contactDetail/{$data['contact_id']}", 'افزودن پروژه با خطا مواجه شد');
        }
    }


    public function edit($id)
    {
        $data = $this->requestArray();
        $delete = ContactProjectRequestsModel::query()->where('contact_project_id', $id)->update(['deleted_at' => date('Y-m-d H:i:s')]);
        if ($delete) {
            foreach ($data['projectRequest'] as $item) {
                ContactProjectRequestsModel::query()->create([
                    'contact_project_id' => $id,
                    'product_id' => $item['product_id'],
                    'request_amount' => $item['request_amount'],
                    'user_id' => userObject()->userId,
                ])->save();
            }
        }
        $this->successCallBack("/ContactProjects/ContactProjectDetail/{$id}", 'پروژه با موفقیت بروزرسانی شد ');
    }
}
