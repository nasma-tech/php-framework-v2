<?php

namespace App\Models\personTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class personTypeModel extends Model
{
    protected $table = 'person_type';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "label",
        "tag_label",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}
