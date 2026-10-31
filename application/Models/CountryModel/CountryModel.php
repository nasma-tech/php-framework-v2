<?php

namespace App\Models\CountryModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CountryModel extends Model
{
    protected $table = 'countries';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "persian_title",
        "english_title",
        "area_code",
        "abbreviated_name",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}