<?php

namespace App\Controllers\WarehouseInventory;

use App\Controllers\scheme\ControllerScheme;
use App\Models\EntryWarehouseModel\EntryWarehouseModel;
use App\Models\EntryWarehousePackageModel\EntryWarehousePackageModel;
use App\Models\ExitWarehouseModel\ExitWarehouseModel;
use App\Models\ProductModel\ProductModel;

class WarehouseInventory extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string|bool $defaultModel = false;

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
            //'js/WarehouseInventory/WarehouseInventory'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('WarehouseInventory/WarehouseInventory.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/WarehouseInventory/add-WarehouseInventory'
        ], [],
            [//vars
            ]
        )->display('WarehouseInventory/add-WarehouseInventory.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/WarehouseInventory/edit-WarehouseInventory'
        ], [], [
            //var
        ])->display('WarehouseInventory/edit-WarehouseInventory.tpl');
    }

    public function inventoryInquiry(int $productId, array|null $warehouseIds = null): array
    {
        $getProducts = ProductModel::query()->find($productId);

        if ($getProducts) {

            $getEntry = EntryWarehouseModel::query()
                ->with(['package'])
                ->when($warehouseIds, fn($query) => $query->whereHas('package.warehouse', fn($query) => $query->whereIn('id', $warehouseIds)))
                ->where([
                    'product_id' => $productId,
                    'unit_id' => $getProducts->measurement_unit_id,
                ])->get();
            $getReserve = ExitWarehouseModel::query()
                ->with(['package'])
                ->when($warehouseIds, fn($query) => $query->whereHas('package.warehouse', fn($query) => $query->whereIn('id', $warehouseIds)))
                ->where([
                    'product_id' => $productId,
                    'unit_id' => $getProducts->measurement_unit_id,
                    'exit_status' => 0
                ])->get();
            $getExit = ExitWarehouseModel::query()
                ->with(['package'])
                ->when($warehouseIds, fn($query) => $query->whereHas('package.warehouse', fn($query) => $query->whereIn('id', $warehouseIds)))
                ->where([
                    'product_id' => $productId,
                    'unit_id' => $getProducts->measurement_unit_id,
                    'exit_status' => 1
                ])->get();

            $totalEntry = $getEntry->sum('amount');
            $totalReserve = $getReserve->sum('amount');
            $totalExit = $getExit->sum('amount');

            $totalRemaining = $totalEntry - ($totalReserve + $totalExit);

            $output = [
                "entry_packages" => $getEntry
                    ->pluck('package')
                    ->select([
                        'id',
                        'title',
                        'description',
                        'entry_datetime',
                    ])
                    ->toArray(),
                "reserve_packages" => $getReserve
                    ->pluck('package')
                    ->select([
                        'id',
                        'title',
                        'created_at'
                    ])
                    ->toArray(),
                "exit_packages" => $getExit
                    ->pluck('package')
                    ->select([
                        'id',
                        'title',
                        'created_at'
                    ])
                    ->toArray(),
                "summary" => [
                    'total_entry' => $totalEntry,
                    'total_reserved' => $totalReserve,
                    'total_exit' => $totalExit,
                    'total_remaining' => $totalRemaining
                ]
            ];
        }

        return $output ?? [];

    }
}