<?php
namespace App\Controllers\ContactAcquisitionSources;
use App\Controllers\scheme\ControllerScheme;
use App\Models\ContactAcquisitionSourcesModel\ContactAcquisitionSourcesModel;

class ContactAcquisitionSources extends ControllerScheme{
        const string singleName = '';
        const string pluralName = '';
        protected string $defaultModel = ContactAcquisitionSourcesModel::class;
        
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
            //'js/ContactAcquisitionSources/ContactAcquisitionSources'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('ContactAcquisitionSources/ContactAcquisitionSources.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/ContactAcquisitionSources/add-ContactAcquisitionSources'
                ], [],
                    [//vars
                    ]
                )->display('ContactAcquisitionSources/add-ContactAcquisitionSources.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ContactAcquisitionSources/edit-ContactAcquisitionSources'
        ],[], [
        //var
        ])->display('ContactAcquisitionSources/edit-ContactAcquisitionSources.tpl');
    }

    public function getContactAcquisitionSources()
    {
        echo json_encode(array_map(function ($item){
            return [
                'id'=>$item['id'],
                'title'=>$item['title']
            ];
        },ContactAcquisitionSourcesModel::query()->get()->toArray()),JSON_UNESCAPED_UNICODE);
    }
}
