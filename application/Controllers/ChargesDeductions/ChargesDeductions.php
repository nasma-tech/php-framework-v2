<?php

namespace App\Controllers\ChargesDeductions;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ChargesDeductionsModel\ChargesDeductionsModel;

class ChargesDeductions extends ControllerScheme
{
    const string singleName = 'هزینه و کسورات';
    const string pluralName = 'هزینه ها و کسورات';
    protected string $defaultModel = ChargesDeductionsModel::class;

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
            //'js/ChargesDeductions/ChargesDeductions'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'list'=>ChargesDeductionsModel::query()->get()
            ])->display('ChargesDeductions/ChargesDeductions.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/ChargesDeductions/add-ChargesDeductions'
        ], [],
            [//vars
            ]
        )->display('ChargesDeductions/add|edit-ChargesDeductions.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel(ChargesDeductionsModel::query()->find($id));
        view->ui([
            //'js/ChargesDeductions/edit-ChargesDeductions'
        ], [], [
            //var
        ])->display('ChargesDeductions/add|edit-ChargesDeductions.tpl');
    }
}
