<?php
namespace App\Controllers\IndustryType;
use App\Controllers\scheme\ControllerScheme;
class IndustryType extends ControllerScheme{
        const string singleName = '';
        const string pluralName = '';
        protected string $defaultModel = IndustryTypeModel::class;
        
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
            //'js/IndustryType/IndustryType'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('IndustryType/IndustryType.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/IndustryType/add-IndustryType'
                ], [],
                    [//vars
                    ]
                )->display('IndustryType/add-IndustryType.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/IndustryType/edit-IndustryType'
        ],[], [
        //var
        ])->display('IndustryType/edit-IndustryType.tpl');
    }
}
