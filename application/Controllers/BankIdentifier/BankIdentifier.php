<?php

namespace App\Controllers\BankIdentifier;

use App\Controllers\scheme\ControllerScheme;

class BankIdentifier extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = BankIdentifierModel::class;

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
            //'js/BankIdentifier/BankIdentifier'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('BankIdentifier/BankIdentifier.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/BankIdentifier/add-BankIdentifier'
        ], [],
            [//vars
            ]
        )->display('BankIdentifier/add-BankIdentifier.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/BankIdentifier/edit-BankIdentifier'
        ], [], [
            //var
        ])->display('BankIdentifier/edit-BankIdentifier.tpl');
    }
}
