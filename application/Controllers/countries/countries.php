<?php

namespace App\Controllers\countries;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CountryModel\CountryModel;


class countries extends ControllerScheme
{
    const string singleName = 'کشور';
    const string pluralName = 'کشورها';
    protected string $defaultModel = CountryModel::class;

    public function main(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/tables/datatable/datatables.min',
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
            'js/countries/countries'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'countries' => CountryModel::all(),
            ])->display('countries/countries.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'assets/js/countries/add-countries'
        ])->display('countries/add-countries.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(CountryModel::query()->find($id));
        view->ui([
            'js/countries/edit-countries'
        ])->display('countries/edit-countries.tpl');
    }

    public function viewIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(CountryModel::query()->find($id));
        view->ui([
            'js/countries/view-countries'
        ])->display('countries/view-countries.tpl');
    }


}