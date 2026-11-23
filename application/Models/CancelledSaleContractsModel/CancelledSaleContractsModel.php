<?php

namespace App\Models\CancelledSaleContractsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CancelledSaleContractsModel extends Model
{
    protected $table = 'CancelledSaleContracts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'sale_contract_id',
        'cancel_date_time',
        'description',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}