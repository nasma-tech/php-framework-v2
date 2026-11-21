<?php

namespace App\Models\WarehousesModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class WarehousesModel extends Model
{
    protected $table = 'warehouses';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "ware_house_name",
        "warehouse_brand_id",
        "warehouse_type_id",
        "country_id",
        "state_id",
        "city_id",
        "post_code",
        "warehouse_phone_number",
        "warehouse_full_address",
        "person_type",
        "owners_data",
        "team_data",
        "nodes_data",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}