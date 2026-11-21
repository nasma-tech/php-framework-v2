<?php
namespace App\Controllers\BankList;
use App\Controllers\scheme\ControllerScheme;
class BankList extends ControllerScheme{
        const string singleName = '';
        const string pluralName = '';
        protected string $defaultModel = BankListModel::class;
        
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
            //'js/BankList/BankList'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('BankList/BankList.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/BankList/add-BankList'
                ], [],
                    [//vars
                    ]
                )->display('BankList/add-BankList.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/BankList/edit-BankList'
        ],[], [
        //var
        ])->display('BankList/edit-BankList.tpl');
    }
}
