<?php

namespace App\Models\priceChangePackagesModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class priceChangePackagesModel extends Model
{
    protected $table = 'price_change_packages';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "brand_id",
        "label",
        "status",
        "approval_workflow",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}