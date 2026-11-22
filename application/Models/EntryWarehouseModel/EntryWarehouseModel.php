<?php

namespace App\Models\EntryWarehouseModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EntryWarehouseModel extends Model
{
    protected $table = 'entryWarehouse';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "product_id",
        "amount",
        "unit_id",
        "entry_datetime",
        "is_stock",
        "stock_datetime",
        "documents",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}