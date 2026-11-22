<?php

namespace App\Models\ExitWarehouseModel;

use App\Models\ExitWarehousePackageModel\ExitWarehousePackageModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExitWarehouseModel extends Model
{
    protected $table = 'exitWarehouse';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "exit_package_id",
        "product_id",
        "amount",
        "unit_id",
        "exit_datetime",
        "exit_status",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function package(): HasOne
    {
        return $this->hasOne(ExitWarehousePackageModel::class, 'id', 'exit_package_id');
    }
}