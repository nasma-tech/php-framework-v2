<?php

namespace App\Controllers\CargoExit;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CargoExitCarInfoModel\CargoExitCarInfoModel;
use App\Models\CargoExitModel\CargoExitModel;

class CargoExit extends ControllerScheme
{
    const string singleName = '';
    const string pluralName = '';
    protected string $defaultModel = CargoExitModel::class;

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
            //'js/CargoExit/CargoExit'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('CargoExit/CargoExit.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/CargoExit/add-CargoExit'
        ], [],
            [//vars
            ]
        )->display('CargoExit/add-CargoExit.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/CargoExit/edit-CargoExit'
        ], [], [
            //var
        ])->display('CargoExit/edit-CargoExit.tpl');
    }

    public function add(): void
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $this->checkRequired([
            'driverInfo' => 'اطلاعات رانندگان وارد نشده است',
        ], $data);
        $addCargoExit = CargoExitModel::query()->create([
            'address_announcement_id' => $data['address_announcement_id'],
            'user_id' => userObject()->userId
        ]);
        if ($addCargoExit) {
            if (isset($data['driverInfo'])) {
                foreach ($data['driverInfo'] as $item) {
                    $makeData = [
                        'cargo_exit_id' => $addCargoExit->id,
                        'driver_full_name' => $item['driver_full_name'],
                        'driver_phone' => $item['driver_phone'],
                        'driver_national_id' => $item['driver_national_id'],
                        'two_left_digit_plate' => $item['plate']['two_left_digit_plate'] ?? '',
                        'license_plate_letter' => $item['plate']['license_plate_letter'] ?? '',
                        'three_digit_plate' => $item['plate']['three_digit_plate'] ?? '',
                        'two_right_digit_plate' => $item['plate']['two_right_digit_plate'] ?? '',
                    ];
                    $addCargoExitInfo = CargoExitCarInfoModel::query()->create($makeData);
                    if ($addCargoExitInfo) {
                        if (!empty($_FILES)) {
                            $files = fileHelper->normalizeFilesArray('driverInfo', 'cargo_file');
                            foreach ($files as $file) {
                                $fileUpload = fileHelper->fileUploadByArray('cargoExit', $file, 'cargo_file', $addCargoExit->id);
                                $addCargoExitInfo->update([
                                    'cargo_file' => $fileUpload
                                ]);
                            }
                        }
                    }
                }
            }
            $this->successCallBack("/ProformaInvoice/process/{$data['invoiceCargoExit']}", 'خروج بار با موفقیت ثبت شد');
        } else {
            $this->failedCallBack("/ProformaInvoice/process/{$data['invoiceCargoExit']}", 'خروج بار با خطا مواجه شد');
        }
    }

    public function removeCargoExitInfo()
    {
        $cargoExitCarInfoId = $this->requestArray('cargoExitCarInfoId');
        $delete = CargoExitCarInfoModel::query()->find($cargoExitCarInfoId)->delete();
        if ($delete) {
            echo 'deleteSuccess';
        } else {
            echo 'deleteError';
        }
    }
}
