<?php

namespace App\Models\AddressAnnouncementModel;

use App\Models\CityModel\CityModel;
use App\Models\ProductExitPartsModel\ProductExitPartsModel;
use App\Models\ProductPartItemModel\ProductPartItemModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AddressAnnouncementModel extends Model
{
    protected $table = 'AddressAnnouncement';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "proforma_invoice_id",
        "part_id",
        "city_id",
        "address",
        "address_file",
        "user_id",
        "create_at",
        "update_at",
        "deleted_at",
    ];

    public function cityData()
    {
        return  $this->belongsTo(cityModel::class, 'city_id', 'id');
    }

    public function userData()
    {
        return  $this->belongsTo(UserModel::class, 'user_id', 'id');
    }

    public function ProductPartItem()
    {
        return $this->hasMany(ProductPartItemModel::class, 'part_id', 'id');
    }
}