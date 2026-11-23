<?php

namespace App\Controllers\ExitWarehouse;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ExitWarehouseModel\ExitWarehouseModel;
use App\Models\ExitWarehousePackageModel\ExitWarehousePackageModel;
use App\Models\ProductModel\ProductModel;

class ExitWarehouse extends ControllerScheme
{
    const string singleName = 'خروج از انبار';
    const string pluralName = 'خروج از انبار';
    protected string $defaultModel = ExitWarehouseModel::class;

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
            //'js/ExitWarehouse/ExitWarehouse'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('ExitWarehouse/ExitWarehouse.tpl');
    }

    public function addExitPackage(int $warehouseId, string $title, int|null $allocationId = null)
    {
        return ExitWarehousePackageModel::query()->create([
            'warehouse_id' => $warehouseId,
            'allocation_id' => $allocationId,
            'title' => $title,
            'user_id' => userObject()->userId
        ]);
    }

    public function addExitProduct(
        int         $exitPackageId,
        int         $product_id,
        int         $amount,
        string|null $exit_datetime = null,
        bool        $exit_status = false
    )
    {
        $getProduct = ProductModel::query()->find($product_id);
        if ($product_id) {
            return ExitWarehouseModel::query()->create([
                "exit_package_id" => $exitPackageId,
                "product_id" => $product_id,
                "amount" => $amount,
                "unit_id" => $getProduct->measurementUnit->id,
                "exit_datetime" => $exit_datetime ?: date("Y-m-d H:i:s"),
                "exit_status" => $exit_status,
                "user_id" => userObject()->userId,
            ]);
        }
        return false;
    }
}
