<?php

namespace App\Models\priceChangePackageItemsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class priceChangePackageItemsModel extends Model
{
    protected $table = 'price_change_package_items';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "package_id",
        "product_id",
        "previous_price",
        "new_price",
        "user_id",
        "status",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}