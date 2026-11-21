<?php

namespace App\Controllers\ProductGroup;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ProductCategoriesModel\ProductCategoriesModel;
use App\Models\ProductGroupModel\ProductGroupModel;
use productGroupsModel;

class ProductGroup extends ControllerScheme
{
    const string singleName = 'گروه محصول';
    const string pluralName = 'گروه محصول';
    protected string $defaultModel = ProductGroupModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(ProductGroupModel::all());
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
            //'js/ProductGroup/ProductGroup'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
                'categories' => ProductCategoriesModel::all()
            ])->display('ProductGroup/ProductGroup.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ProductGroup/add-ProductGroup'
        ], [],
            [//vars
                'categories' => ProductCategoriesModel::all()
            ]
        )->display('ProductGroup/add-ProductGroup.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel(ProductGroupModel::query()->find($id));
        view->ui([
            //'js/ProductGroup/edit-ProductGroup'
        ], [], [
            //var
            'categories' => ProductCategoriesModel::all()
        ])->display('ProductGroup/edit-ProductGroup.tpl');
    }

    public function add()
    {
        $data = $this->requestArray();
        $add = ProductGroupModel::query()->insert([
            "label" => $data['title'],
            "category_id" => $data['category_id'],
            "user_id" => userObject()->userId,
        ]);
        if ($add) {
            $this->successCallBack("/ProductGroup/main");
        }
    }

    public function edit($id)
    {
        $data = $this->requestArray();
        $edit = ProductGroupModel::query()->find($id)->update([
            "label" => $data['title'],
            "category_id" => $data['category_id'],
            'updated_at' => date("Y-m-d H:i:s"),
        ]);
        if ($edit) {
            $this->successCallBack("/ProductGroup/main",'با موفقیت بروزرسانی شد');
        }
    }
}
