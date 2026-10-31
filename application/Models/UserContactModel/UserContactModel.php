<?php

namespace App\Models\UserContactModel;

use App\Models\UserContactTypeModel\UserContactTypeModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserContactModel extends Model
{
    protected $table = 'user_contacts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "user_identity_id",
        "contact_type_id",
        "value",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

    public function contactTypeData()
    {
        return $this->hasOne(UserContactTypeModel::class, 'id', 'contact_type_id');
    }

}