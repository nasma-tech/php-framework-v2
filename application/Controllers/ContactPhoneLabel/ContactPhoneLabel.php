<?php

namespace App\Controllers\ContactPhoneLabel;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ContactPhoneLabelModel\ContactPhoneLabelModel;

class ContactPhoneLabel extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = ContactPhoneLabelModel::class;

    public function main(): void
    {
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
            //'js/ContactPhoneLabel/ContactPhoneLabel'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ContactPhoneLabel/ContactPhoneLabel.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ContactPhoneLabel/add-ContactPhoneLabel'
        ], [],
            [//vars
            ]
        )->display('ContactPhoneLabel/add-ContactPhoneLabel.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ContactPhoneLabel/edit-ContactPhoneLabel'
        ], [], [
            //var
        ])->display('ContactPhoneLabel/edit-ContactPhoneLabel.tpl');
    }

    public function getContactPhoneLabel(): void
    {
        echo json_encode(array_map(function ($item){
            return [
                'id'=>$item['id'],
                'title'=>$item['type'],
                'hasSocial'=>$item['has_social_network']
            ];
        },ContactPhoneLabelModel::query()->get()->toArray()),JSON_UNESCAPED_UNICODE);
    }
}
