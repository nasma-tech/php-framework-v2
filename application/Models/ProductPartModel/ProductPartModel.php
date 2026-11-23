<?php

namespace App\Models\ProductPartModel;

use App\Models\ProductExitPartsModel\ProductExitPartsModel;
use App\Models\ProductPartItemModel\ProductPartItemModel;
use App\Models\ProformaInvoiceModel\ProformaInvoiceModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductPartModel extends Model
{
    protected $table = 'productParts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "proforma_invoice_id",
        "warehouse_id",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function productPartItems(): HasMany
    {
        return $this->hasMany(ProductPartItemModel::class, 'part_id', 'id');
    }

    public function proformaInvoice(): HasOne
    {
        return $this->hasOne(ProformaInvoiceModel::class,'id','proforma_invoice_id');
    }

    public function productExitPart(): HasOne
    {
        return $this->hasOne(ProductExitPartsModel::class,'product_part_id','id');
    }

    public function expert(): HasOne
    {
        return $this->hasOne(UserModel::class,'id','user_id');
    }

}