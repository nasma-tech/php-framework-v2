<?php

namespace App\Controllers\users;

use App\Controllers\scheme\ControllerScheme;
use App\Models\BloodTypeModel\BloodTypeModel;
use App\Models\MaritalStatusTypeModel\MaritalStatusTypeModel;
use App\Models\MilitaryStatusTypeModel\MilitaryStatusTypeModel;
use App\Models\RoleModel\RoleModel;
use App\Models\UserContactTypeModel\UserContactTypeModel;
use App\Models\UserModel\UserModel;
use Packages\Helpers\FileHelper;


class users extends ControllerScheme
{
    const string singleName = 'کاربر';
    const string pluralName = 'کاربران';
    protected string $defaultModel = UserModel::class;

    //user object
    public static function userObject(): object
    {
        return (object)$_SESSION;
    }

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
//            'js/appSettings/users/users'
        ],
            ['vendors/css/tables/datatable/datatables.min'], [
                'list' => UserModel::all()
            ])->display('users/users.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui(['js/users/add-users'], [], [
//            'userRole' => RoleModel::all(),
            "militaryStatusTypes" => MilitaryStatusTypeModel::all(),
            "bloodTypes" => BloodTypeModel::all(),
            "maritalStatusTypes" => MaritalStatusTypeModel::all(),
            "userContactTypes" => UserContactTypeModel::query()->where([
                'is_required' => 1
            ])->get()
        ])->display('users/add-users.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(UserModel::query()->find($id));
        view->ui([
            'js/users/edit-users'
        ], [], [
            'userRole' => RoleModel::all(),
        ])->display('users/edit-users.tpl');

    }

    public function add()
    {
        csrf->csrfValidate();
        $data = $this->requestArray();

        if ($data['national_code']) {
            $check = UserModel::query()->where(['national_code' => $data['national_code']])->first();
            if ($check) {
                $this->failedCallBack('addIndex', 'کاربر قبلا ثبت شده است');
            } else {
                $makeData = [
                    'username' => $data['user_name'],
                    'password' => sha1(md5($data['user_password'])),
                    'first_name' => trim($data['first_name']),
                    'last_name' => trim($data['last_name']),
                    'full_name' => trim($data['first_name']) . " " . trim($data['last_name']),
                    'national_code' => $data['national_code'],
                    'mobile' => $data['user_mobile'],
                    'email' => $data['user_email'],
                    'permission_id' => $data['permission_id'],
                    'user_id' => userObject()->userId
                ];
                $add = UserModel::query()->create($makeData);
                if ($add->save()) {
                    $fileHelper = new FileHelper();
                    $add->update(['image_address' => $fileHelper->fileUpload('Users', 'user_img', $add->id)]);
                    $this->successCallBack();
                }
            }
        } else {
            $this->failedCallBack('addIndex', 'کد ملی راپر کنید');
        }
    }

    public function edit($id)
    {
        $this->changeRequestValues('password', sha1(md5($this->requestArray()['password'])));

        if (!empty($_FILES['user_img']['name'])) {
            $image = fileHelper->fileUpload('Users', 'user_img', $id);
            UserModel::query()->where(['id' => $id])->update(['image_address' => $image]);
        }
        return parent::edit($id);
    }

    public function getUsersForm(): void
    {
        echo json_encode($this->getUsers(), JSON_UNESCAPED_UNICODE);
    }

    public function getUsers(): array
    {
        $get = UserModel::query()
            ->with([
                'staffPermissionData'
            ])
            ->get();

        return array_map(function ($item) {
            return [
                'id' => $item['id'],
                'fullname' => $item['full_name'],
                'avatar' => userHelper->getUserImage($item['id']),
                'position' => (($item['staff_permission_data']) ? $item['staff_permission_data']['per_name'] : ' - '),
            ];
        }, $get->toArray());
    }

}