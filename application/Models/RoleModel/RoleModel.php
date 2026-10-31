<?php

namespace App\Models\RoleModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class RoleModel extends Model
{
    protected $table = 'roles';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "title",
        "access_json",
        "status",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}