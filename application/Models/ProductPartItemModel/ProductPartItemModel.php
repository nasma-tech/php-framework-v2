<?php

namespace App\Models\ProductPartItemModel;

use App\Models\ProductExitPartItemsModel\ProductExitPartItemsModel;
use App\Models\ProformaInvoiceProductsModel\ProformaInvoiceProductsModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductPartItemModel extends Model
{
    protected $table = 'productPartItems';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "part_id",
        "invoice_product_id",
        "amount",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function invoiceProduct(): HasOne
    {
        return $this->hasOne(ProformaInvoiceProductsModel::class,'id','invoice_product_id');
    }

    public function productExitPartItem(): HasOne
    {
        return $this->hasOne(ProductExitPartItemsModel::class,'product_exit_part_item_id','id');
    }

}