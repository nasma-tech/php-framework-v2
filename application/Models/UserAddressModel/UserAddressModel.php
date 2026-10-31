<?php

namespace App\Models\UserAddressModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserAddressModel extends Model
{
    protected $table = 'user_addresses';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "user_identity_id",
        "is_default",
        "city_id",
        "main_street",
        "side_street",
        "alley_name",
        "plaque",
        "unit",
        "complete_address",
        "postal_code",
        "area_code",
        "landline_number",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}