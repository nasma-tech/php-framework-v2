<?php

namespace App\Models\priceChangePoliciesModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class priceChangePoliciesModel extends Model
{
    protected $table = 'price_change_policies';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "brand_id",
        "approval_workflow",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}