<?php

namespace App\Controllers\Units;

use App\Controllers\scheme\ControllerScheme;
use App\Models\UnitModel\UnitModel;

class Units extends ControllerScheme
{
    const string singleName = 'واحد';
    const string pluralName = 'واحدها';

    protected string $defaultModel = UnitModel::class;

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
            'js/Units/Units'
        ], [
            'vendors/css/tables/datatable/datatables.min'
        ], [
            'units' => UnitModel::all()
        ])->display('Units/Units.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/Units/add-Units'
        ])->display('Units/add-Units.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(UnitModel::query()->find($id));
        view->ui([
            'js/Units/edit-Units'
        ])->display('Units/edit-Units.tpl');
    }


    public function getUnits()
    {
        $output = [];
        foreach (UnitModel::all() as $item) {
            $output[] = [
                'id' => $item->id,
                'title' => $item->unit_name,
                'symbol' => $item->unit_symbol
            ];
        }
        echo json_encode($output, JSON_UNESCAPED_UNICODE);
    }

    public function findOneFilterUnit()
    {
        $id = $this->requestArray()['value'];
        $service_unit = ServicesModel::query()->findOrFail($id);
        $find = UnitModel::query()->findOrFail($service_unit->unit_id);

        echo json_encode([
            'id' => $find->id,
            'title' => $find->unit_name,
            'symbol' => $find->unit_symbol
        ], JSON_UNESCAPED_UNICODE);
    }

}