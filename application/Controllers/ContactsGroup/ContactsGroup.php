<?php

namespace App\Controllers\ContactsGroup;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ContactsGroupModel\ContactsGroupModel;

class ContactsGroup extends ControllerScheme
{
    const string singleName = 'گروه مشتری';
    const string pluralName = 'گروه مشتریان';
    protected string $defaultModel = ContactsGroupModel::class;

    public function main()
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
            //'js/ContactsGroup/ContactsGroup'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ContactsGroup/ContactsGroup.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ContactsGroup/add-ContactsGroup'
        ], [],
            [//vars
            ]
        )->display('ContactsGroup/add-ContactsGroup.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/ContactsGroup/edit-ContactsGroup'
        ], [], [
            //var
        ])->display('ContactsGroup/edit-ContactsGroup.tpl');
    }

    public function getContactsGroup()
    {
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'title' => $item['title']
            ];
        }, ContactsGroupModel::query()->get()->toArray()), JSON_UNESCAPED_UNICODE);
    }
}
