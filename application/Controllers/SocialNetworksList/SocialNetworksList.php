<?php
namespace App\Controllers\SocialNetworksList;
use App\Controllers\scheme\ControllerScheme;
use App\Models\SocialNetworksListModel\SocialNetworksListModel;

class SocialNetworksList extends ControllerScheme{
        const string singleName = 'شبکه اجتماعی';
        const string pluralName = 'شبکه های اجتماعی';
        protected string $defaultModel = SocialNetworksListModel::class;
        
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
            //'js/SocialNetworksList/SocialNetworksList'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('SocialNetworksList/SocialNetworksList.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/SocialNetworksList/add-SocialNetworksList'
                ], [],
                    [//vars
                    ]
                )->display('SocialNetworksList/add-SocialNetworksList.tpl');
            }
            
        public function editIndex($id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/SocialNetworksList/edit-SocialNetworksList'
        ],[], [
        //var
        ])->display('SocialNetworksList/edit-SocialNetworksList.tpl');
    }

    public function getSocialNetworkList()
    {
        echo json_encode(array_map(function ($item){
            return [
                'id'=>$item['id'],
                'title'=>$item['title'],
                'icon'=>'/Storage/socialNetworkIcons/'.$item['icon']
            ];
        },SocialNetworksListModel::query()->get()->toArray()),JSON_UNESCAPED_UNICODE);
    }
}
