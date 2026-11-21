<?php

namespace App\Controllers\brands;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;

class brands extends ControllerScheme
{
    const string singleName = 'برند';
    const string pluralName = 'برندها';
    protected string $defaultModel = brandsModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(brandsModel::all());
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
            //'js/brands/brands'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('brands/brands.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/brands/add-brands'
        ], [],
            [//vars
            ]
        )->display('brands/add-brands.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel(brandsModel::query()->find($id));
        view->ui([
            'js/brands/edit-brands'
        ], [], [
            //var
        ])->display('brands/edit-brands.tpl');
    }

    public function add()
    {
        $data = $this->requestArray();
        $makeData = [
            'label' => $data['label'],
            'user_id' => userObject()->userId
        ];
        $add = brandsModel::query()->create($makeData);
            $fileInfo = fileHelper->fileUpload('brands','logo_address');
        if ($add->save()) {
            $add->update([
                'logo_address' => $fileInfo,
            ]);
            $this->successCallBack("/brands/main");
        }
    }

    public function edit($id)
    {
        $data = $this->requestArray();
        $findData = brandsModel::query()->find($id);
        if ($_FILES['logo_address']) {
            $fileInfo = fileHelper->fileUpload('brands','logo_address');
            $findData = $findData->update([
                'logo_address' => $fileInfo,
                'label' => $data['label'] ?? $findData['label'],
            ]);
            $this->successCallBack("/brands/main",'ویرایش با موفقیت انجام شد');
        }else{
            $findData = $findData->update([
                'label' => $data['label'],
            ]);
            $this->successCallBack("/brands/main",'ویرایش با موفقیت انجام شد');
        }
    }
}
