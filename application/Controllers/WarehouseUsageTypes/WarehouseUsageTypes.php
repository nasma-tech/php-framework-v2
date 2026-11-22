<?php
namespace App\Controllers\WarehouseUsageTypes;
use App\Controllers\scheme\ControllerScheme;
use App\Models\WarehouseUsageTypeModel\WarehouseUsageTypeModel;

class WarehouseUsageTypes extends ControllerScheme{
        const string singleName = '';
        const string pluralName = '';
        protected string $defaultModel = WarehouseUsageTypeModel::class;
        
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
            //'js/WarehouseUsageTypes/WarehouseUsageTypes'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('WarehouseUsageTypes/WarehouseUsageTypes.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/WarehouseUsageTypes/add-WarehouseUsageTypes'
                ], [],
                    [//vars
                    ]
                )->display('WarehouseUsageTypes/add-WarehouseUsageTypes.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/WarehouseUsageTypes/edit-WarehouseUsageTypes'
        ],[], [
        //var
        ])->display('WarehouseUsageTypes/edit-WarehouseUsageTypes.tpl');
    }
}
