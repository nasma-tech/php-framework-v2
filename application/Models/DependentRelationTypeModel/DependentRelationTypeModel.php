<?php

namespace App\Models\DependentRelationTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class DependentRelationTypeModel extends Model
{
    protected $table = 'dependent_relation_types';
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