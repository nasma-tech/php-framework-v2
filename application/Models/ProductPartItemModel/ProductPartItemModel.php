<?php

namespace App\Models\ProductPartItemModel;

use Illuminate\Database\Eloquent\Model;
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

}