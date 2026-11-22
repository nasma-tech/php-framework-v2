<?php

namespace App\Models\marketerGroupModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class marketerGroupModel extends Model
{
    protected $table = 'marketingGroup';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "title",
        "target_values",
        "user_id",
        "create_at",
        "update_at",
        "deleted_at",
    ];

}