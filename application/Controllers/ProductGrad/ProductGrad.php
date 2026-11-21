<?php
namespace App\Controllers\ProductGrad;
use App\Controllers\scheme\ControllerScheme;
use App\Controllers\users\users;
use App\Models\ProductGradeModel\ProductGradeModel;

class ProductGrad extends ControllerScheme{
        const string singleName = 'گرید محصولات';
        const string pluralName = 'گرید محصولات';
        protected string $defaultModel = ProductGradeModel::class;
        
        public function main(){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(ProductGradeModel::all());
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
            //'js/ProductGrad/ProductGrad'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('ProductGrad/ProductGrad.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/ProductGrad/add-ProductGrad'
                ], [],
                    [//vars
                    ]
                )->display('ProductGrad/add-ProductGrad.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel(ProductGradeModel::query()->find($id));
        view->ui([
            //'js/ProductGrad/edit-ProductGrad'
        ],[], [
        //var
        ])->display('ProductGrad/edit-ProductGrad.tpl');
    }

    public function add()
    {
        $data = $this->requestArray();
        $add = ProductGradeModel::query()->insert([
            'label' => $data['label'],
            'user_id' => userObject()->userId,
        ]);
        if ($add) {
            $this->successCallBack("/ProductGrad/main", 'با موفقیت افزوده شد');
        }
    }

    public function edit($id)
    {
        $data = $this->requestArray();
        $editData = ProductGradeModel::query()->find($id)->update([
            'label' => $data['label'],
            'updated_at' => date("Y-m-d H:i:s")
        ]);
        if ($editData) {
            $this->successCallBack("/ProductGrad/main", 'با موفقیت بروزرسانی شد');
        }
    }
}
