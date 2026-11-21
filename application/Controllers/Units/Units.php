<?php

namespace App\Controllers\Units;

use App\Controllers\scheme\ControllerScheme;
use App\Models\MeasurementUnitModel\MeasurementUnitModel;

class Units extends ControllerScheme
{
    const string singleName = 'واحد';
    const string pluralName = 'واحدها';

    protected string $defaultModel = MeasurementUnitModel::class;

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
            'js/Units/Units'
        ], [
            'vendors/css/tables/datatable/datatables.min'
        ], [
            'units' => MeasurementUnitModel::all()
        ])->display('Units/Units.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/Units/add-Units'
        ])->display('Units/add-Units.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(MeasurementUnitModel::query()->find($id));
        view->ui([
            'js/Units/edit-Units'
        ])->display('Units/edit-Units.tpl');
    }


    public function getUnits(): void
    {
        $output = [];
        foreach (MeasurementUnitModel::all() as $item) {
            $output[] = [
                'id' => $item->id,
                'title' => $item->unit_name,
            ];
        }
        echo json_encode($output, JSON_UNESCAPED_UNICODE);
    }

}