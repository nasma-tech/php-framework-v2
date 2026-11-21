<?php

namespace App\Models\ProductCategoriesModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductCategoriesModel extends Model
{
    protected $table = 'product_categories';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "label",
        "user_id",
        "update_at",
        "deleted_at",
    ];

    public function userData()
    {
        return $this->hasOne(UserModel::class, "id", "user_id");
    }
}