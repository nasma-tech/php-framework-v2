<?php

namespace App\Controllers\marketers;

use App\Controllers\scheme\ControllerScheme;
use App\Models\BankModel\BankModel;
use App\Models\marketerGroupModel\marketerGroupModel;
use App\Models\marketersModel\marketersModel;
use App\Models\StateModel\StateModel;
use App\Models\UserModel\UserModel;

class marketers extends ControllerScheme
{
    const string singleName = 'بازاریاب';
    const string pluralName = 'بازاریابان';
    protected string $defaultModel = marketersModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(marketersModel::query()->get());
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
            //'js/marketers/marketers'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('marketers/marketers.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/marketers/add-marketers'
        ], [],
            [//vars
                'marketingGroups' => marketerGroupModel::query()->get(),
                'bankData' => bankModel::query()->get(),
                'states' => stateModel::query()->where('country_id', 102)->get(),
                'experts' => userModel::query()->get(),
            ]
        )->display('marketers/add-marketers.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/marketers/edit-marketers'
        ], [], [
            //var
        ])->display('marketers/edit-marketers.tpl');
    }

    public function MarketerData()
    {
        $data = marketerGroupModel::query()->get();
        echo json_encode($data);
    }

    public function addMarketerGroup()
    {
        $data = $this->requestArray();
        $add = marketerGroupModel::query()->create([
            'title' => $data['title'],
            'user_id' => userObject()->userId,
        ]);
        if ($add) {
            echo "addSucess";
        } else {
            echo "addFailed";
        }
    }

    public function editMarketeGroup($id)
    {
        $data = $this->requestArray();
        $edit = marketerGroupModel::query()->where('id', $id)->update($data);
        if ($edit) {
            echo "editSucess";
        } else {
            echo "editFailed";
        }
    }

    public function add()
    {
        $data = $this->requestArray();
        $makeData = [];
        switch ($data['marketer_type']) {
            case "person":
                $makeData = [
                    "marketer_type" => "person",
                    'marketer_gender' => $data['marketer_gender'],
                    "marketing_group_id" => $data['marketing_group_id'],
                    "marketer_full_name" => $data['marketer_full_name'],
                    "birth_date" => dateTimeHelper->convertDateToTimestamp($data['birth_date']),
                    "marketer_national_code" => $data['marketer_national_code'],
                    "marketing_group_id" => $data['marketing_group_id'],
                    "expert_id" => $data['expert_id'],
                    "city_id" => $data['city_id'],
                    "commissionPercentage" => $data['commissionPercentage'],
                    "marketer_cardNumber" => $data['marketer_cardNumber'],
                    "bank_id" => $data['bank_id'],
                    "marketer_accountNumber" => $data['marketer_accountNumber'],
                    "marketer_shebaNumber" => $data['marketer_shebaNumber'],
                    "marketer_address" => $data['marketer_address'],
                    "marketer_phones" => json_encode($data['marketer_phones']),
                    "marketer_mobiles" => json_encode($data['marketer_mobiles']),
                    "user_id" => userObject()->userId,
                ];
                break;
            case "legal":
                $makeData = [
                    "marketer_type" => "legal",
                    "company_national_code" => $data['company_national_code'],
                    "company_name" => $data['company_name'],
                    "registration_date" => dateTimeHelper->convertDateToTimestamp($data['registration_date']),
                    "ceo_full_name" => $data['ceo_full_name'],
                    "connector_full_name" => $data['connector_full_name'],
                    "marketing_group_id" => $data['marketing_group_id'],
                    "expert_id" => $data['expert_id'],
                    "city_id" => $data['city_id'],
                    "commissionPercentage" => $data['commissionPercentage'],
                    "marketer_cardNumber" => $data['marketer_cardNumber'],
                    "bank_id" => $data['bank_id'],
                    "marketer_accountNumber" => $data['marketer_accountNumber'],
                    "marketer_shebaNumber" => $data['marketer_shebaNumber'],
                    "marketer_address" => $data['marketer_address'],
                    "marketer_phones" => json_encode($data['marketer_phones']),
                    "marketer_mobiles" => json_encode($data['marketer_mobiles']),
                    "user_id" => userObject()->userId,
                ];
        }
        if ($makeData) {

            $add = marketersModel::query()->create($makeData);
            if ($add->save()) {
                switch ($data['marketer_type']) {
                    case "person":
                        $front_national_card_image = fileHelper->fileUpload("marketers", "front_national_card_image", $add->id);
                        $back_national_card_image = fileHelper->fileUpload("marketers", "back_national_card_image", $add->id);
                        $contract_image = fileHelper->fileUpload("marketers", "contract_image", $add->id);
                        $add->update([
                            "front_national_card_image" => $front_national_card_image,
                            "back_national_card_image" => $back_national_card_image,
                            "contract_image" => $contract_image,
                        ]);
                        if ($add->save()) {

                            $this->successCallBack('/marketers/main');
                        } else {

                            $this->failedCallBack('/marketers/main', "در مرحله ثبت فایل تداخلی پیش آمد");
                        }
                        break;
                    case "legal":
                        $contract_image_legal = fileHelper->fileUpload("marketer", "contract_image_legal", $add->id);
                        $official_newspaper_image = fileHelper->fileUpload("marketer", "official_newspaper_image", $add->id);
                        $last_changes_image = fileHelper->fileUpload("marketer", "last_changes_image", $add->id);
                        $add->update([
                            "contract_image_legal" => $contract_image_legal,
                            "official_newspaper_image" => $official_newspaper_image,
                            "last_changes_image" => $last_changes_image,
                        ]);
                        if ($add->save()) {

                            $this->successCallBack('/marketers/main');
                        } else {

                            $this->failedCallBack('/marketers/main', "در مرحله ثبت فایل تداخلی پیش آمد");
                        }
                }
            } else {

                $this->failedCallBack('/marketers/main');
            }
        }
    }
}
