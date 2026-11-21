<?php

namespace App\Models\ProductGroupModel;

use App\Models\ProductCategoriesModel\ProductCategoriesModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductGroupModel extends Model
{
    protected $table = 'product_groups';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "label",
        "category_id",
        "user_id",
        "deleted_at",
        "created_at",
        "updated_at",
    ];

    public function users()
    {
        return $this->hasOne(UserModel::class, 'id', 'user_id');
    }
    public function category()
    {
        return $this->belongsTo(ProductCategoriesModel::class, 'category_id');
    }

    public function products()
    {
        return $this->hasMany(ProductModel::class, 'group_id');
    }

}