<?php

namespace App\Controllers\PaymentAllocation;

use App\Controllers\scheme\ControllerScheme;
use App\Models\PaymentAllocationModel\PaymentAllocationModel;
use App\Models\PaymentManagementModel\PaymentManagementModel;
use Helper\Class\Cartable;

class PaymentAllocation extends ControllerScheme
{
    const string singleName = 'تخصیص واریزی';
    const string pluralName = 'تخصیص واریزی ها';
    protected string $defaultModel = PaymentAllocationModel::class;

    public function main(): void
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
            //'js/PaymentAllocation/PaymentAllocation'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [

            ])->display('PaymentAllocation/PaymentAllocation.tpl');
    }

    public function addIndex(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/PaymentAllocation/add-PaymentAllocation'
        ], [],
            [//vars
            ]
        )->display('PaymentAllocation/add-PaymentAllocation.tpl');
    }

    public function editIndex($id): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/PaymentAllocation/edit-PaymentAllocation'
        ], [], [
            //var
        ])->display('PaymentAllocation/edit-PaymentAllocation.tpl');
    }

    /**
     * @throws \SmartyException
     * @throws \Exception
     */
    public function viewIndex($id): void
    {
        $cartable = new \Helper\Class\Cartable(new PaymentAllocationModel(), $id);

        $getData = $this->defaultModel::query()->find($id);

        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel($getData);
        view->ui([
            'js/PaymentAllocation/view-PaymentAllocation'
        ], [], [
            'getActivityLogView' => $cartable->getActivityLogView(),
        ])->display('PaymentAllocation/view-PaymentAllocation.tpl');
    }

    /**
     * @throws \Exception
     */
    public function submitPaymentAllocation(): void
    {
        csrf->csrfValidate();
        $request = $this->requestArray();
        $paymentAmount = numberNormalizer->removePriceSeparator($request['payment_amount']);
        if ($paymentAmount > $this->checkRemaining($request['payment_management_id'])) {
            echo json_encode([
                'status' => false,
                'message' => 'مقدار واریزی بیشتر از حد مجاز'
            ], JSON_UNESCAPED_UNICODE);
        } else {
            $add = PaymentAllocationModel::query()->create([
                'payment_management_id' => $request['payment_management_id'],
                'payment_allocation_type_id' => $request['payment_allocation_type_id'],
                'invoice_id' => $request['invoiceId'],
                'payment_amount' => numberNormalizer->removePriceSeparator($request['payment_amount']),
                'user_id' => userObject()->userId
            ]);
            if ($add) {
//                $cartable = new Cartable(new PaymentAllocationModel(), $add->id);
//                $cartable->attachSchemaToCartable(2);
//                $cartable->submitCartable();

                echo json_encode([
                    'status' => true,
                    'message' => 'تخصیص با موفقیت انجام شد'
                ], JSON_UNESCAPED_UNICODE);
            }
        }
    }

    public function checkRemaining($paymentManagementId)
    {
        $paymentManagement = PaymentManagementModel::query()->find($paymentManagementId);
        $allocation = PaymentAllocationModel::query()->where([
            'payment_management_id' => $paymentManagementId
        ]);
        $sumAllocation = $allocation->sum('payment_amount');
        return match ($paymentManagement->payment_method_id) {
            1 => $paymentManagement->chequeData->cheque_amount - $sumAllocation,
            default => $paymentManagement->amount_paid - $sumAllocation,
        };
    }
}
