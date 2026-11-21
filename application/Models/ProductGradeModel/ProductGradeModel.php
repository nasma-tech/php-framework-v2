<?php

namespace App\Models\ProductGradeModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use UsersModel;

class ProductGradeModel extends Model
{
    protected $table = 'product_grades';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "label",
        "user_id",
        "create_at",
        "update_at",
        "deleted_at",
    ];

    public function users()
    {
        return $this->hasOne(UserModel::class, 'id', 'user_id');
    }
}