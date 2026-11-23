<?php

namespace App\Models\EntryWarehouseModel;

use App\Models\EntryWarehousePackageModel\EntryWarehousePackageModel;
use App\Models\ProductModel\ProductModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class EntryWarehouseModel extends Model
{
    protected $table = 'entryWarehouse';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "entry_package_id",
        "product_id",
        "amount",
        "unit_id",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

    public function package(): HasOne
    {
        return $this->hasOne(EntryWarehousePackageModel::class, 'id', 'entry_package_id');
    }
    public function productData()
    {
        return $this->belongsTo(productModel::class, 'product_id', 'id');
    }

}