<?php

namespace App\Models\EntryWarehousePackageModel;

use App\Models\WarehousesModel\WarehousesModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class EntryWarehousePackageModel extends Model
{
    protected $table = 'entryWarehousePackages';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "warehouse_id",
        "title",
        "description",
        "entry_datetime",
        "driver_plaques",
        "documents",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

    public function warehouseData()
    {
        return $this->belongsTo(warehousesModel::class, 'warehouse_id');
    }

    public function userData()
    {
        return $this->belongsTo(UserModel::class, 'user_id');
    }
    public function warehouse(): HasOne
    {
        return $this->hasOne(WarehousesModel::class, 'id', 'warehouse_id');
    }

}