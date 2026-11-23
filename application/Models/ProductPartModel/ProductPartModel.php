<?php

namespace App\Models\ProductPartModel;

use App\Models\ProductPartItemModel\ProductPartItemModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductPartModel extends Model
{
    protected $table = 'productParts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "proforma_invoice_id",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function productPartItems(): HasMany
    {
        return $this->hasMany(ProductPartItemModel::class, 'part_id', 'id');
    }

}