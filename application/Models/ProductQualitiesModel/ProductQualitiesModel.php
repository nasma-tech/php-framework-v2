<?php

namespace App\Models\ProductQualitiesModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductQualitiesModel extends Model
{
    protected $table = 'product_quality_levels';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "label",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

    public function userData()
    {
        return $this->hasOne(UserModel::class , 'id' , 'user_id');
    }
}