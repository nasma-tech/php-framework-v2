<?php

namespace App\Models\ChequeManagementModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ChequeManagementModel extends Model
{
    protected $table = 'ChequeManagement';
    protected $primaryKey = 'id';
    public $timestamps = false;
    use SoftDeletes;

    protected $fillable = [
        'cheque_deposit_date',
        'cheque_number',
        'cheque_amount',
        'cheque_document',
        'cheque_description',
        'cheque_passed_status',
        'user_id',
        'updated_at',
        'deleted_at',
    ];

}