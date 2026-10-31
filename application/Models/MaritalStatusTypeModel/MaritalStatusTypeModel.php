<?php

namespace App\Models\MaritalStatusTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MaritalStatusTypeModel extends Model
{
    protected $table = 'marital_status_types';
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