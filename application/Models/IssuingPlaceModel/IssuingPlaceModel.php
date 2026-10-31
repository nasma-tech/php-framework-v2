<?php

namespace App\Models\IssuingPlaceModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class IssuingPlaceModel extends Model
{
    protected $table = 'issuing_places';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "code",
        "title",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}