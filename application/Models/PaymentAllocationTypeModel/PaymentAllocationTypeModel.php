<?php

namespace App\Models\PaymentAllocationTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PaymentAllocationTypeModel extends Model
{
    protected $table = 'PaymentAllocationType';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'allocation_title',
        'user_id',
        'updated_at',
        'deleted_at'
    ];
}