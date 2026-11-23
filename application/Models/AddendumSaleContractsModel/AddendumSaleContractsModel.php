<?php

namespace App\Models\AddendumSaleContractsModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
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

    public function expert(): HasOne
    {
        return $this->hasOne(UserModel::class,'id','user_id');
    }

}