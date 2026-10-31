<?php

namespace App\Controllers\roles;

use App\Controllers\scheme\ControllerScheme;
use App\Models\MenuModel\MenuModel;
use App\Models\RoleModel\RoleModel;


class roles extends ControllerScheme
{
    const string singleName = 'دسترسی';
    const string pluralName = 'دسترسی ها';
    protected string $defaultModel = RoleModel::class;

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
            'js/roles/roles'
        ], [
            'vendors/css/tables/datatable/datatables.min'
        ], [
            'permission' => RoleModel::all(),
        ])->display('roles/roles.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/roles/add-roles'
        ], '', [
            'permissions' => RoleModel::all(),
            'menuList' => new MenuModel()
        ])->display('roles/add-roles.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(RoleModel::query()->find($id));
        view->ui([
            'js/roles/edit-roles'
        ], '', [
            'permissions' => RoleModel::all(),
            'menuList' => new MenuModel()
        ])->display('roles/edit-roles.tpl');
    }

    public function add(): void
    {
        csrf->csrfValidate();
        $array = array_map(function ($item) {
            return $item;
        }, $this->requestArray()['parentMenu']);

        $add = RoleModel::query()->create([
            "title" => $this->requestArray()['title'],
            "status" => $this->requestArray()['status'],
            "access_json" => json_encode($array, JSON_UNESCAPED_UNICODE),
            "user_id" => userObject()->userId
        ]);
        if ($add->save()) {
            $this->successCallBack('addIndex');
        } else {
            $this->failedCallBack('/main');
        }
    }


    public function edit($id): void
    {
        $array = array_map(function ($item) {
            return $item;
        }, $this->requestArray()['parentMenu']);
        csrf->csrfValidate();
        $edit = RoleModel::query()->find($id);
        if ($edit) {
            $edit->update([
                "title" => $this->requestArray()['title'],
                "status" => $this->requestArray()['status'],
                "access_json" => json_encode($array, JSON_UNESCAPED_UNICODE),
                "updated_at" => date("Y-m-d H:i:s")
            ]);

            if ($edit->save()) {
                $this->successCallBack("/roles/editIndex/$id");
            } else {
                $this->failedCallBack('/main');
            }
        }
    }

}