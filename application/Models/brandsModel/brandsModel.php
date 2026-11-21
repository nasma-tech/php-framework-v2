<?php

namespace App\Models\brandsModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use usersModel;

class brandsModel extends Model
{
    protected $table = 'brands';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "label",
        "logo_address",
        "user_id",
        "created_at",
        "update_at",
        "deleted_at",
    ];

    public function users()
    {
        return $this->hasOne(UserModel::class, 'id', 'user_id');
    }
}