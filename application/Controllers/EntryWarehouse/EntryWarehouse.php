<?php

namespace App\Controllers\EntryWarehouse;

use App\Controllers\scheme\ControllerScheme;
use App\Models\EntryWarehouseModel\EntryWarehouseModel;
use App\Models\EntryWarehousePackageModel\EntryWarehousePackageModel;
use App\Models\ProductModel\ProductModel;
use App\Models\WarehousesModel\WarehousesModel;

class EntryWarehouse extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = EntryWarehouseModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(EntryWarehousePackageModel::query()->get());
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
            'js/EntryWarehouse/EntryWarehouse'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('EntryWarehouse/EntryWarehouse.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/EntryWarehouse/add-EntryWarehouse',
        ], ['/css/EntryWarehouse/add-EntryWarehouse'],
            [
                "warehouseData" => WarehousesModel::all()
            ]
        )->display('EntryWarehouse/add-EntryWarehouse.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/EntryWarehouse/edit-EntryWarehouse'
        ], [], [
            //var
        ])->display('EntryWarehouse/edit-EntryWarehouse.tpl');
    }



    public function add()
    {
        csrf->csrfValidate();

        $data = $this->requestArray();

        $needle = [
            "warehouse_id",
            "entryDateTime",
            "wareHousePartDescription",
            "product_data",
        ];

        if (!validator->validateRequestsData($needle)) {
            $this->failedCallBack("main");
            return;
        }

        $entrydatePackageData = [
            "title" => $data["title"],
            "warehouse_id" => $data["warehouse_id"],
            "description" => $data['wareHousePartDescription'],
            "entry_datetime" => $data['entryDateTime'],
            "driver_plaques" => json_encode($data['driver_plaques'] ?? []),
            "user_id" => userObject()->userId
        ];

        $add = EntryWarehousePackageModel::query()->create($entrydatePackageData);

        $rawFiles = fileHelper->normalizeUploadedFiles("files");
        $files = [];

        foreach (($data['files'] ?? []) as $key => $file) {

            if (
                !isset($rawFiles[$key]) ||
                $rawFiles[$key]['error'] === UPLOAD_ERR_NO_FILE
            ) {
                continue;
            }

            $uploadedFile = fileHelper->uploadMultipleFiles(
                "EntryWarehouse",
                [$rawFiles[$key]],
                (string) $add->id
            );

            if (!empty($uploadedFile)) {
                $uploaded = reset($uploadedFile);

                $files[] = [
                    'name' => $file['name'] ?? '',
                    'description' => $file['description'] ?? '',
                    'file' => $uploaded['name'],
                ];
            }
        }

        if (!empty($files)) {
            $add->update([
                "documents" => json_encode($files, JSON_UNESCAPED_UNICODE)
            ]);
        }

        foreach ($data['product_data'] as $key => $value) {

            $productData = productModel::query()->find($value["product_id"]);

            if (!$productData) {
                $this->failedCallBack("main");
                return;
            }

            $detailData = [
                "entry_package_id" => $add->id,
                "product_id" => $value["product_id"],
                "amount" => numberNormalizer->removePriceSeparator($value["amount"]),
                "unit_id" => $productData->measurement_unit_id,
                "user_id" => userObject()->userId,
            ];

            $addDetail = entrywarehouseModel::query()->create($detailData);

            if (!$addDetail) {
                $this->failedCallBack("main");
                return;
            }
        }

        $this->successCallBack("/EntryWarehouse/main");
    }


    public function viewIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(EntryWarehouseModel::query()->where('entry_package_id', $id)->get());
        view->ui([
            'js/EntryWarehouse/view-EntryWarehouse',
        ], [],
            [
                'packageData' => EntryWarehousePackageModel::query()->where('id', $id)->first()
            ]
        )->display('EntryWarehouse/view-EntryWarehouse.tpl');
    }

    public function EntryWarehouseEdit($id)
    {
        csrf->csrfValidate();

        $data = $this->requestArray();
        $output = $this->defaultOutput();

        $needle = ["amount"];

        if (validator->validateRequestsData($needle)) {

            $get = EntryWarehouseModel::query()->where('id', $id)->first();

            if ($get) {
                $amount = numberNormalizer->removePriceSeparator($data['amount']);

                if ($get->amount != $amount) {

                    $decode = json_decode($get->modify_log ?? "[]", true);

                    $decode[] = [
                        'userId' => userObject()->userId,
                        'datetime' => time(),
                        'description' => trim($data['description'] ?? ''),
                        'data' => $get->toArray()
                    ];

                    $get->update([
                        'amount' => $amount,
                        'modify_log' => json_encode($decode, JSON_UNESCAPED_UNICODE),
                        'updated_at' => date('Y-m-d H:i:s')
                    ]);

                    $output = [
                        'status' => 'success',
                        'message' => 'ویرایش با موفقیت انجام شد'
                    ];

                } else {
                    $output = [
                        'status' => 'warning',
                        'message' => 'ردیف بروز می باشد'
                    ];
                }

            } else {
                $output['message'] = 'ردیف یافت نشد';
            }
        }

        echo json_encode($output, JSON_UNESCAPED_UNICODE);
    }

    public function EntryWarehouseDelete($id)
    {
        csrf->csrfValidate();

        $data = $this->requestArray();
        $output = $this->defaultOutput();

        $get = EntryWarehouseModel::query()->where('id', $id)->first();

        if ($get) {

            $decode = json_decode($get->modify_log ?? "[]", true);

            $decode[] = [
                'userId' => userObject()->userId,
                'datetime' => time(),
                'description' => trim($data['description'] ?? ''),
                'action' => 'delete',
                'data' => $get->toArray()
            ];

            if ($get->update([
                'modify_log' => json_encode($decode, JSON_UNESCAPED_UNICODE),
                'deleted_at' => date('Y-m-d H:i:s')
            ])) {
                $output = [
                    'status' => 'success',
                    'message' => 'حذف با موفقیت انجام شد'
                ];
            }

        } else {
            $output['message'] = 'ردیف یافت نشد';
        }

        echo json_encode($output, JSON_UNESCAPED_UNICODE);
    }


}