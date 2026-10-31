<?php

namespace App\Models\StateModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class StateModel extends Model
{
    protected $table = 'states';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "country_id",
        "title",
        "area_code",
        "latitude",
        "longitude",
        "hc_key",
        "user_id",
        "updated_at",
        "deleted_at",
    ];
}