<?php

namespace App\Models\UserContactTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserContactTypeModel extends Model
{
    protected $table = 'user_contact_types';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "code",
        "title",
        "is_required",
        "validation_pattern",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}