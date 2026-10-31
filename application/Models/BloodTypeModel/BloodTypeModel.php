<?php

namespace App\Models\BloodTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class BloodTypeModel extends Model
{
    protected $table = 'blood_types';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "title",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}