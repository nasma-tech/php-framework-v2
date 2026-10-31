<?php

namespace App\Controllers\login\MenuList;

use App\Controllers\scheme\ControllerScheme;
use App\Models\IconModel\IconModel;
use App\Models\MenuModel\MenuModel;

class MenuList extends ControllerScheme
{
    const string singleName = 'مدیریت منو';
    const string pluralName = 'مدیریت منوها';
    protected string $defaultModel = MenuModel::class;

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
//            'js/MenuList/MenuList'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'menuList' => MenuModel::all(),
                'menuListInstance' => new MenuModel()
            ])->display('MenuList/MenuList.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/MenuList/add-MenuList'
        ], [],
            [
                'menuList' => MenuModel::all()
            ]
        )->display('MenuList/add-MenuList.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(MenuModel::query()->find($id));
        view->ui([
            'js/MenuList/edit-MenuList'
        ], [], [
            'menuList' => MenuModel::all()
        ])->display('MenuList/edit-MenuList.tpl');
    }

    public function getIconsList(): void
    {
        $get = IconModel::all()->toArray();
        echo json_encode(array_map(function ($item){
            return $item['title'];
        },$get));
    }


}

