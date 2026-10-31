<?php

namespace App\Models\UserModel;

use App\Models\RoleModel\RoleModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserModel extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "gender",
        "first_name",
        "last_name",
        "full_name",
        "username",
        "password_hash",
        "avatar",
        "role_id",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function roleData()
    {
        return $this->hasOne(RoleModel::class, 'id', 'role_id');
    }
}