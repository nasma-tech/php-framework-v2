<?php

namespace App\Models\PaymentAllocationModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PaymentAllocationModel extends Model
{
    protected $table = 'PaymentAllocation';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'payment_management_id',
        'payment_allocation_type_id',
        'service_invoice_id',
        'payment_amount',
        'allocation_document',
        'status',
        'cartable_definition_id',
        'schema_work_group',
        'cartable_circulation',
        'process_status',
        'process_log',
        'change_schema_log',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}