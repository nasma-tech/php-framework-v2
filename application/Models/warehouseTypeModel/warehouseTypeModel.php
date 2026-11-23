<?php

namespace App\Models\warehouseTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class warehouseTypeModel extends Model
{
    protected $table = 'warehouseType';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "label",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}