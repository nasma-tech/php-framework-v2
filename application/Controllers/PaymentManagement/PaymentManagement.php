<?php

namespace App\Controllers\PaymentManagement;

//use App\Controllers\PaymentAllocation\PaymentAllocation;
//use App\Controllers\PaymentMethod\PaymentMethod;
use App\Controllers\PaymentAllocation\PaymentAllocation;
use App\Controllers\scheme\ControllerScheme;

//use App\Models\BankAccountModel\BankAccountModel;
//use App\Models\BankListModel\BankListModel;
//use App\Models\ChequeManagementModel\ChequeManagementModel;
//use App\Models\colorsModel\colorsModel;
//use App\Models\PaymentAllocationModel\PaymentAllocationModel;
//use App\Models\PaymentAllocationTypeModel\PaymentAllocationTypeModel;
use App\Models\ChequeManagementModel\ChequeManagementModel;
use App\Models\PaymentAllocationTypeModel\PaymentAllocationTypeModel;
use App\Models\PaymentManagementModel\PaymentManagementModel;
use App\Models\PaymentMethodModel\PaymentMethodModel;
use Packages\Cartable\Cartable;
use PHPMailer\PHPMailer\Exception;

class PaymentManagement extends ControllerScheme
{
    const string singleName = 'مدیریت واریزی';
    const string pluralName = 'مدیریت واریزی ها';
    protected string $defaultModel = PaymentManagementModel::class;

    public function main(): void
    {
        $_ENV['APP_DEBUG'] = 1;
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
            //'js/PaymentManagement/PaymentManagement'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'list' => $this->defaultModel::byPermission()->get()
            ])->display('PaymentManagement/PaymentManagement.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/PaymentManagement/add-PaymentManagement'
        ], [],
            [
//                'bankAccounts' => BankAccountModel::query()->where('bank_list_id', '!=', 0)->get(),
//                'bankList' => new BankListModel()
            ]
        )->display('PaymentManagement/add-PaymentManagement.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/PaymentManagement/edit-PaymentManagement'
        ], [], [
            //var
        ])->display('PaymentManagement/edit-PaymentManagement.tpl');
    }

//    public function viewIndex($id)
//    {
//        $cartable = new \Cartable();
//
//        $cartable->setRequestId(222);
//        $cartable->setDataModel(new colorsModel());
//
//        $getCartableCirculationLog = $cartable->getCartableCirculationLog();
//        $statusDictionary = [
//            0 => [
//                'label' => "در انتظار بررسی",
//                'bs-color' => "info",
//            ],
//            1 => [
//                'label' => "تایید نهایی",
//                'bs-color' => "success",
//            ],
//            2 => [
//                'label' => "عدم تایید",
//                'bs-color' => "danger",
//            ],
//            3 => [
//                'label' => "در انتظار بررسی مجدد",
//                'bs-color' => "warning",
//            ],
//        ];
//
//        view->setPageTitle(self::pluralName);
//        view->setSingleName(self::singleName);
//        view->setPluralName(self::pluralName);
//        view->setModel($this->defaultModel::query()->find($id));
//        view->ui([
//            //'js/PaymentManagement/edit-PaymentManagement'
//        ], [], [
//            'getCartableCirculationLog' => $getCartableCirculationLog,
//            'statusDictionary' => $statusDictionary
//        ])->display('PaymentManagement/view-PaymentManagement.tpl');
//    }

    /**
     * @throws \Exception
     */
    public function add()
    {
        $_ENV['APP_DEBUG'] = 1;
        $this->validateCSRF();
        $request = $this->requestArray();
        $output = [
            'status' => false
        ];

        $validationKey = [];

        //validate request
        foreach ($request as $key => $item) {
            if (!$item) {
                $validationKey[] = $key;
            }
        }

        //validate cheque document upload
        if (isset($_FILES['cheque_document'])) {
            if ($_FILES['cheque_document']['size'] == 0) {
                $validationKey[] = 'cheque_document';
            }
        }

        //validate payment document upload
        if (isset($_FILES['payment_documents'])) {
            foreach ($_FILES['payment_documents']['size'] as $item) {
                if ($item == 0) {
                    $validationKey[] = 'payment_documents';
                }
            }
        }

        if (count($validationKey) > 0) {
            $output = [
                'status' => false,
                'errors' => $validationKey,
            ];
        } else {
            $requestId = '';
            switch ($request['payment_method_id']) {
                case 1:
                    $arrayFill = [
                        'cheque_deposit_date' => dateTimeHelper->convertDateToTimestamp($request['cheque_deposit_date']),
                        'cheque_number' => persianTextNormalizer->persianNumberToEnglish($request['cheque_number']),
                        'cheque_amount' => str_replace([',', ' '], '', $request['cheque_amount']),
                        'cheque_description' => $request['cheque_description'],
                        'user_id' => userObject()->userId
                    ];
                    $addCheque = ChequeManagementModel::query()->create($arrayFill);
                    if ($addCheque) {
                        $lastId = $addCheque->id;
                        $document = fileHelper->fileUpload('ChequeManagement', 'cheque_document', $lastId);
                        ChequeManagementModel::query()->find($lastId)->update([
                            'cheque_document' => $document
                        ]);
                        $arrayFill = [
                            'payment_method_id' => $request['payment_method_id'],
                            'cheque_management_id' => $lastId,
                            'user_id' => userObject()->userId,
                        ];
                        $add = PaymentManagementModel::query()->create($arrayFill);
                        if ($add) {
                            $requestId = $add->id;
                            $output['status'] = true;
                        }
                    }
                    break;
                default:
                    $arrayFill = [
                        'payment_method_id' => $request['payment_method_id'],
                        'bank_account_id' => $request['bank_account_id'],
                        'reference_no' => persianTextNormalizer->persianNumberToEnglish($request['reference_no']),
                        'date_deposit' => dateTimeHelper->convertDateToTimestamp($request['date_deposit']),
                        'amount_paid' => persianTextNormalizer->persianNumberToEnglish(numberNormalizer->removePriceSeparator($request['amount_paid'])),
                        'payment_description' => $request['payment_description'],
                        'user_id' => userObject()->userId,
                    ];
                    $add = PaymentManagementModel::query()->create($arrayFill);
                    if ($add) {
                        $requestId = $add->id;
                        $document = fileHelper->uploadMultipleFiles('PaymentManagement',fileHelper->normalizeUploadedFiles('payment_documents'), $add->id);
                        $add->update([
                            'payment_documents' => json_encode($document)
                        ]);
                        $output['status'] = true;
                    }
                    break;
            }
            if ($requestId) {
//                $cartable = new Cartable();
//                $cartable->setDataModel(new PaymentManagementModel());
//                $cartable->setRequestId($requestId);
//                $cartable->attachSchemaToCartable(1);
//                $cartable->submitCartable('تست');
            }

        }

        echo json_encode($output, JSON_UNESCAPED_UNICODE);

    }

    public function getPayments(): void
    {
        $get = $this->defaultModel::byPermission()->get();
        $result = [];
        $getType = PaymentAllocationTypeModel::all();
        $allocation = new PaymentAllocation();
        foreach ($getType as $item) {
            $result['allocationType'][] = [
                'id' => $item->id,
                'title' => $item->allocation_title
            ];
        }
        foreach ($get as $item) {
            if ($item->payment_status == 1) {
                if ($allocation->checkRemaining($item->id) > 0) {
                    if ($item->payment_method_id != 1) {
                        $bankData = $item->bankAccountData->bankData;
                        $result['payment'][] = [
                            'id' => $item->id,
                            'bankName' => $bankData->bank_list_name,
                            'branchName' => $item->bankAccountData->bank_branch_name,
                            'paymentMethod' => $item->paymentMethodData->title,
                            'referenceNo' => $item->reference_no,
                        ];
                    } else {
                        $result['cheque'][] = [
                            'id' => $item->id,
                            'chequeNumber' => $item->chequeData->cheque_number
                        ];
                    }
                }
            }
        }
        if (!empty($result)) {
            echo json_encode($result, JSON_UNESCAPED_UNICODE);
        }
    }

    public function getRemainingPayment(): void
    {
        $paymentManagementId = $this->requestArray()['paymentManagementId'];
        $allocation = new PaymentAllocation();
        echo $allocation->checkRemaining($paymentManagementId);
    }

}
