<?php

namespace App\Models\UserIdentityModel;

use App\Models\UserContactModel\UserContactModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserIdentityModel extends Model
{
    protected $table = 'user_identities';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "user_account_id",
        "is_iranian",
        "national_id",
        "passport_number",
        "birth_date",
        "birth_place",
        "father_name",
        "military_status_type_id",
        "blood_type_id",
        "issuing_place_id",
        "marital_status_type_id",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function userData()
    {
        return $this->hasOne(UserModel::class, 'id', 'user_account_id');
    }

    public function userContactData()
    {
        return $this->hasMany(UserContactModel::class, 'user_identity_id', 'id');
    }
}