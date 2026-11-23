<?php
namespace App\Controllers\AddendumSaleContracts;
use App\Controllers\scheme\ControllerScheme;
use App\Models\AddendumSaleContractsModel\AddendumSaleContractsModel;

class AddendumSaleContracts extends ControllerScheme{
        const string singleName = 'الحاقیه قرارداد';
        const string pluralName = 'الحاقیه های قرارداد';
        protected string $defaultModel = AddendumSaleContractsModel::class;
        
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
            //'js/AddendumSaleContracts/AddendumSaleContracts'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('AddendumSaleContracts/AddendumSaleContracts.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/AddendumSaleContracts/add-AddendumSaleContracts'
                ], [],
                    [//vars
                    ]
                )->display('AddendumSaleContracts/add-AddendumSaleContracts.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/AddendumSaleContracts/edit-AddendumSaleContracts'
        ],[], [
        //var
        ])->display('AddendumSaleContracts/edit-AddendumSaleContracts.tpl');
    }
}
