<?php

namespace App\Controllers\Warehouses;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\CountryModel\CountryModel;
use App\Models\personTypeModel\personTypeModel;
use App\Models\UserModel\UserModel;
use App\Models\WarehousesModel\WarehousesModel;
use App\Models\warehouseTypeModel\warehouseTypeModel;
use App\Models\WarehouseUsageTypeModel\WarehouseUsageTypeModel;

class Warehouses extends ControllerScheme
{
    const string singleName = 'انبار';
    const string pluralName = 'انبارها';
    protected string $defaultModel = WarehousesModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel($this->defaultModel::all());
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
            //'js/Warehouses/Warehouses'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            )->display('Warehouses/Warehouses.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            '/vendors/js/charts/valadart/go',
            '/vendors/js/charts/valadart/data',
            '/vendors/js/charts/valadart/lookup',
            '/vendors/js/charts/valadart/model-helpers',
            '/vendors/js/charts/valadart/editing',
            '/vendors/js/charts/valadart/context-menu',
            '/vendors/js/charts/valadart/node-template',
            '/vendors/js/charts/valadart/dragging-tool',
            '/vendors/js/charts/valadart/diagram-init',
            '/vendors/js/charts/valadart/app',
            '/js/salesTeam/add-salesTeam',
            '/js/Warehouses/add-Warehouses',
            '/js/Warehouses/warehouseDefinision',
            '/js/Warehouses/warehouseOwnership',
            '/js/Warehouses/warehousePhysicalAddress',
            '/js/Warehouses/warehouseTeam',
        ], ['vendors/css/charts/valadart/style'
        ],
            [
                'brands' => brandsModel::query()->get(),
                'warehouseType' => warehouseTypeModel::query()->get(),
                'countries' => countryModel::query()->get(),
                'personTypes' => personTypeModel::query()->get(),
                'warehouseUsageTypes' => WarehouseUsageTypeModel::all()
            ]
        )->display('Warehouses/add-Warehouses.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/Warehouses/edit-Warehouses'
        ], [], [
            //var
        ])->display('Warehouses/edit-Warehouses.tpl');
    }

    public function getWarehouseKeepers()
    {
        $parentIds = $this->requestArray()['parentIds'] ?? [];

        $validUsers = userModel::query()
            ->whereNotIn('id', $parentIds)
            ->where('permission', '12')
            ->get(['id', 'name']);

        echo json_encode([
            "status" => "success",
            "users" => $validUsers
        ]);

        return;
    }

    public function addTeam()
    {
        $data = $this->requestArray();
        var_print($data);
        die();
    }

    public function add()
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $files = $_FILES;

        $needle = [
            'ware_house_name',
            'warehouse_brand_id',
            'warehouse_type_id',
            'warehouse_usage_id',
            'country_id',
            'state_id',
            'city_id',
            'post_code',
            'owners_data',
            'warehouse_phone_number',
            'warehouse_full_address',
            'person_type',
            'jsonOutput'
        ];

        if (validator->validateRequestsData($needle)) {
            $data['team_data'] = json_encode(json_decode($data['jsonOutput'], true)['nodeDataArray'], JSON_UNESCAPED_UNICODE);
            $data['nodes_data'] = $data['jsonOutput'];
            unset($data['jsonOutput']);

            $data['user_id'] = userObject()->userId;
            $data['owners_data'] = json_encode(reset($data['owners_data']), JSON_UNESCAPED_UNICODE);

            $add = WarehousesModel::query()->create($data);

            if ($files && isset($files['owner_document'])) {
                $add->update([
                    'owners_data' => json_encode(
                        array_merge(
                            json_decode($add->owners_data, true),
                            ["owner_document" => fileHelper->fileUpload('warehouses', 'owner_document', $add->id)]
                        )
                        , JSON_UNESCAPED_UNICODE)
                ]);
            }

            $this->successCallBack('/Warehouses/main');
        }
        $this->failedCallBack('/Warehouses/main','نقص اطلاعات ورودی');
    }
}
