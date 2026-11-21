<?php

namespace App\Controllers\ContactProjectsFollowUp;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ContactProjectsFollowUpActionsModel\ContactProjectsFollowUpActionsModel;
use App\Models\ContactProjectsFollowUpModel\ContactProjectsFollowUpModel;

class ContactProjectsFollowUp extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = ContactProjectsFollowUpModel::class;

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
            //'js/ContactProjectsFollowUp/ContactProjectsFollowUp'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ContactProjectsFollowUp/ContactProjectsFollowUp.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ContactProjectsFollowUp/add-ContactProjectsFollowUp'
        ], [],
            [//vars
            ]
        )->display('ContactProjectsFollowUp/add-ContactProjectsFollowUp.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ContactProjectsFollowUp/edit-ContactProjectsFollowUp'
        ], [], [
            //var
        ])->display('ContactProjectsFollowUp/edit-ContactProjectsFollowUp.tpl');
    }

    public function add()
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $this->checkRequired([
            'FollowUp_action_id' => 'عنوان پیگیری بعد'
        ], $data);
        $makeData = [
            'contact_project_id' => $data['contact_project_id'],
            'FollowUp_action_id' => $data['FollowUp_action_id'],
            'next_followUp_date' => dateTimeHelper->convertDateToTimestamp($data['next_followUp_date']),
            'followUp_description' => $data['followUp_description'],
            'user_id' => userObject()->userId
        ];
        $add = ContactProjectsFollowUpModel::query()->create($makeData);
        if ($add) {
            $this->successCallBack("/ContactProjects/ContactProjectDetail/{$data['contact_project_id']}", 'پیگیری با موفقیت اضافه شد');
        } else {
            $this->failedCallBack("/ContactProjects/ContactProjectDetail/{$data['contact_project_id']}", 'افزودن پیگیری با خطا مواجه شد');
        }
    }

    public function followUpActionSubmit()
    {
        $data = $this->requestArray();
        try {
            $this->checkRequired([
                'contact_project_followUp_id' => 'پیشگیری مشخص نشده است',
                'followUp_description' => 'توضیحات اجباری است'
            ], $data);
            $makeData = [
                'contact_project_followUp_id'=>$data['contact_project_followUp_id'],
                'followUp_description'=>$data['followUp_description'],
                'action_time'=>time(),
                'user_id'=>userObject()->userId,
            ];
            ContactProjectsFollowUpActionsModel::query()->create($makeData);
            $this->successCallBack("/ContactProjects/ContactProjectDetail/{$data['contact_project_id']}",'نتیجه پیگیری با موفقیت ثبت شد');
        }catch (\Exception $exception){
            $this->failedCallBack("/ContactProjects/ContactProjectDetail/{$data['contact_project_id']}",'برای این پیگیری قبلا نتیجه ثبت شده است');
        }

    }
}
