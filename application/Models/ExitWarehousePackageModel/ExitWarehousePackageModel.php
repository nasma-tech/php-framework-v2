<?php

namespace App\Models\ExitWarehousePackageModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExitWarehousePackageModel extends Model
{
    protected $table = 'exitWarehousePackages';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "title",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}