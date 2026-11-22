<?php

namespace App\Models\SaleContractsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SaleContractsModel extends Model
{
    protected $table = 'SaleContracts';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'proforma_invoice_id',
        'convert_to_contract',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}