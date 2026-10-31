<?php

namespace App\Controllers\states;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CountryModel\CountryModel;
use App\Models\StateModel\StateModel;
use Illuminate\Pagination\Paginator;

Paginator::useBootstrap();

class states extends ControllerScheme
{
    const string singleName = 'استان';
    const string pluralName = 'استان ها';
    protected string $defaultModel = StateModel::class;

    public function main(): void
    {
        $states = StateModel::query()->paginate(10);
        Paginator::useBootstrap();
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
            'js/states/states'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'states' => $states,
                'country' => new CountryModel()
            ])->display('states/states.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/states/add-states'
        ], [],
            [
                'countries' => CountryModel::all()
            ]
        )->display('states/add-states.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(StateModel::query()->find($id));
        view->ui([
            'js/states/edit-states'
        ], '', [
            'countries' => CountryModel::all()
        ])->display('states/edit-states.tpl');
    }

    public function getStates(): void
    {
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'title' => $item['title'],
            ];
        }, StateModel::query()->where('country_id', 102)->get()->toArray()), JSON_UNESCAPED_UNICODE);
    }

    public function getMapInfo(): void
    {
        $id = $this->requestArray()['id'];
        $get = StateModel::query()->find($id);
        $output = [];
        $output['latitude'] = $get->latitude;
        $output['longitude'] = $get->longitude;
        echo json_encode($output, JSON_UNESCAPED_UNICODE);
    }

}