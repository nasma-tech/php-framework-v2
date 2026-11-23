<?php

namespace App\Models\WarehouseUsageTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class WarehouseUsageTypeModel extends Model
{
    protected $table = 'warehouseUsageType';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "label",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}