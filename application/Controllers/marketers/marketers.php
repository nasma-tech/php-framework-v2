<?php

namespace App\Controllers\marketers;

use App\Controllers\scheme\ControllerScheme;
use App\Models\marketerGroupModel\marketerGroupModel;
use App\Models\marketersModel\marketersModel;

class marketers extends ControllerScheme
{
    const string singleName = 'بازاریاب';
    const string pluralName = 'بازاریابان';
    protected string $defaultModel = marketersModel::class;

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
            //'js/marketers/marketers'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('marketers/marketers.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/marketers/add-marketers'
        ], [],
            [//vars
            ]
        )->display('marketers/add-marketers.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/marketers/edit-marketers'
        ], [], [
            //var
        ])->display('marketers/edit-marketers.tpl');
    }

    public function MarketerData()
    {
        $data = marketerGroupModel::query()->get();
        echo json_encode($data);
    }

    public function addMarketerGroup()
    {
        $data = $this->requestArray();
        $add = marketerGroupModel::query()->create([
            'title' => $data['title'],
            'user_id' => userObject()->userId,
        ]);
        if ($add) {
            echo "addSucess";
        } else {
            echo "addFailed";
        }
    }

    public function editMarketeGroup($id)
    {
        $data = $this->requestArray();
        $edit = marketerGroupModel::query()->where('id', $id)->update($data);
        if ($edit) {
            echo "editSucess";
        } else {
            echo "editFailed";
        }
    }
}
