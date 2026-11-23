<?php

namespace App\Models\SaleContractsModel;

use App\Models\AddendumSaleContractsModel\AddendumSaleContractsModel;
use App\Models\CancelledSaleContractsModel\CancelledSaleContractsModel;
use App\Models\ProformaInvoiceModel\ProformaInvoiceModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
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

    public function proformaInvoice(): HasOne
    {
        return $this->hasOne(ProformaInvoiceModel::class,'id','proforma_invoice_id');
    }

    public function expert(): HasOne
    {
        return $this->hasOne(UserModel::class,'id','user_id');
    }

    public function addendum(): HasMany
    {
        return $this->hasMany(AddendumSaleContractsModel::class,'sale_contract_id','id')->orderByDesc('id');
    }

    public function cancelContract(): HasOne
    {
        return $this->hasOne(CancelledSaleContractsModel::class,'id','sale_contract_id');
    }

}