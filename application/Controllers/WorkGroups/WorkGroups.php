<?php

namespace App\Controllers\WorkGroups;

use App\Controllers\scheme\ControllerScheme;
use App\Models\WorkGroupsModel\WorkGroupsModel;

class WorkGroups extends ControllerScheme
{
    const string singleName = 'گروه کاری';
    const string pluralName = 'گروه های کاری';

    protected string $defaultModel = WorkGroupsModel::class;

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
//            'js/WorkGroups/WorkGroups'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'list' => WorkGroupsModel::all()
            ])->display('WorkGroups/WorkGroups.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
//            'js/WorkGroups/add-WorkGroups'
        ], [],
            [//vars
            ]
        )->display('WorkGroups/add-WorkGroups.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel(WorkGroupsModel::query()->find($id));
        view->ui([
//            'js/WorkGroups/edit-WorkGroups'
        ], [], [
            //var
        ])->display('WorkGroups/edit-WorkGroups.tpl');
    }

    public function getWorkGroupsIndex(): void
    {
        echo json_encode($this->getWorkGroups(), JSON_UNESCAPED_UNICODE);
    }

    public function getWorkGroups(): array
    {
        return WorkGroupsModel::query()
            ->select([
                'id',
                'work_group_title as title'
            ])
            ->get()->toArray();
    }
}
