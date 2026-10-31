<?php

namespace App\Models\UserInternalExtensionModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserInternalExtensionModel extends Model
{
    protected $table = 'user_internal_extensions';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "user_account_id",
        "internal_extension_id",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}