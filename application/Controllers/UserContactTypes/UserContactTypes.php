<?php

namespace App\Controllers\UserContactTypes;

use App\Controllers\scheme\ControllerScheme;
use App\Models\UserContactTypeModel\UserContactTypeModel;

class UserContactTypes extends ControllerScheme
{
    const string singleName = 'راه ارتباطی';
    const string pluralName = 'راه های ارتباطی';
    protected string $defaultModel = UserContactTypeModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(UserContactTypeModel::all());
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
            //'js/UserContactTypes/UserContactTypes'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('UserContactTypes/UserContactTypes.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/UserContactTypes/add-UserContactTypes'
        ], [],
            [//vars
            ]
        )->display('UserContactTypes/add-UserContactTypes.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/UserContactTypes/edit-UserContactTypes'
        ], [], [
            //var
        ])->display('UserContactTypes/edit-UserContactTypes.tpl');
    }
}
