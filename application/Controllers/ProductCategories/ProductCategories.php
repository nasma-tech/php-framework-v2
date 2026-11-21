<?php

namespace App\Controllers\ProductCategories;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ProductCategoriesModel\ProductCategoriesModel;

class ProductCategories extends ControllerScheme
{
    const string singleName = 'کتگری';
    const string pluralName = 'کتگری';
    protected string $defaultModel = ProductCategoriesModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(ProductCategoriesModel::all());
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
            //'js/ProductCategories/ProductCategories'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ProductCategories/ProductCategories.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ProductCategories/add-ProductCategories'
        ], [],
            [//vars
            ]
        )->display('ProductCategories/add-ProductCategories.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(ProductCategoriesModel::query()->find($id));
        view->ui([
            //'js/ProductCategories/edit-ProductCategories'
        ], [], [
            //var
        ])->display('ProductCategories/edit-ProductCategories.tpl');
    }

    public function add()
    {
        $data = $this->requestArray();
        $add = ProductCategoriesModel::query()->create([
            'label' => $data['label'],
            'user_id' => userObject()->userId
        ]);
        if ($add->save()) {
            $this->successCallBack('/ProductCategories/main');
        }
    }
    public function edit($id){
        $data = $this->requestArray();
        $edit = ProductCategoriesModel::query()->find($id)->update([
            'label' => $data['label'],
            'update_at' => date('Y-m-d H:i:s')
        ]);
        if ($edit) {
            $this->successCallBack('/ProductCategories/main','با موفقیت بروزرسانی شد');
        }
    }

}
