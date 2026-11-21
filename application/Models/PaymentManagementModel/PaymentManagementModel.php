<?php

namespace App\Models\PaymentManagementModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PaymentManagementModel extends Model
{
    protected $table = 'PaymentManagement';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'payment_method_id',
        'bank_account_id',
        'cheque_management_id',
        'reference_no',
        'date_deposit',
        'amount_paid',
        'payment_description',
        'payment_documents',
        'payment_status',
        'cartable_circulation',
        'schema_work_group',
        'process_log',
        'process_status',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function scopeByPermission($query)
    {
        if (userObject()->roleId == 0){
            return $query->with([
                'bankAccountData',
                'paymentMethodData',
                'chequeData',
            ])->orderByDesc('id');
        }else{
            return $query->with([
                'bankAccountData',
                'paymentMethodData',
                'chequeData',
            ])->where([
                'user_id'=>userObject()->userId
            ])->orderByDesc('id');
        }
    }



}