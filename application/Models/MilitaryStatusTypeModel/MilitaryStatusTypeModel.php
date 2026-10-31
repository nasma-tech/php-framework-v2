<?php

namespace App\Models\MilitaryStatusTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MilitaryStatusTypeModel extends Model
{
    protected $table = 'military_status_types';
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