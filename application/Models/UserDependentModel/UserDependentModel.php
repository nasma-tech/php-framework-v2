<?php

namespace App\Models\UserDependentModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserDependentModel extends Model
{
    protected $table = 'user_dependents';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "user_identity_id",
        "dependent_relation_type_id",
        "first_name",
        "last_name",
        "national_id",
        "marital_status_type_id",
        "birth_date",
        "phone_number",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}