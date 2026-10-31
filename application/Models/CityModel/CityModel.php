<?php

namespace App\Models\CityModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CityModel extends Model
{
    protected $table = 'cities';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "state_id",
        "title",
        "latitude",
        "longitude",
        "user_id",
        "created_at",
        "updated_at"
    ];

}