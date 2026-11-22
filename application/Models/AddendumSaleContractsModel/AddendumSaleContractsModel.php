<?php

namespace App\Models\AddendumSaleContractsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AddendumSaleContractsModel extends Model
{
    protected $table = 'AddendumSaleContracts';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'sale_contract_id',
        'addendum_date',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}