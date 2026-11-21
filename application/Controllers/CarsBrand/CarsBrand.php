<?php
namespace App\Controllers\CarsBrand;
use App\Controllers\scheme\ControllerScheme;
use App\Models\CarsBrandModel\CarsBrandModel;

class CarsBrand extends ControllerScheme{
        const string singleName = '';
        const string pluralName = '';
        protected string $defaultModel = CarsBrandModel::class;
        
        public function main(){
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
            //'js/CarsBrand/CarsBrand'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('CarsBrand/CarsBrand.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/CarsBrand/add-CarsBrand'
                ], [],
                    [//vars
                    ]
                )->display('CarsBrand/add-CarsBrand.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/CarsBrand/edit-CarsBrand'
        ],[], [
        //var
        ])->display('CarsBrand/edit-CarsBrand.tpl');
    }

    public function getCarBrands()
    {
        echo json_encode(array_map(function ($item){
            return [
                'id'=>$item['id'],
                'title'=>$item['title']
            ];
        },CarsBrandModel::query()->get()->toArray()),JSON_UNESCAPED_UNICODE);
    }
}
