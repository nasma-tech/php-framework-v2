<?php

namespace App\Models\ExitWarehousePackageModel;

use App\Models\WarehousesModel\WarehousesModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExitWarehousePackageModel extends Model
{
    protected $table = 'exitWarehousePackages';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "warehouse_id",
        "title",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function warehouse(): HasOne
    {
        return $this->hasOne(WarehousesModel::class, 'id', 'warehouse_id');
    }

}