<?php

namespace App\Models\EntryWarehousePackageModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EntryWarehousePackageModel extends Model
{
    protected $table = 'entryWarehousePackages';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "title",
        "description",
        "entry_datetime",
        "driver_plaques",
        "documents",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}