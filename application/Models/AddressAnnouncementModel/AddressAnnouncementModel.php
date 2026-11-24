<?php

namespace App\Models\AddressAnnouncementModel;

use App\Models\CargoExitModel\CargoExitModel;
use App\Models\CityModel\CityModel;
use App\Models\CountryModel\CountryModel;
use App\Models\ProductExitPartsModel\ProductExitPartsModel;
use App\Models\ProductPartItemModel\ProductPartItemModel;
use App\Models\StateModel\StateModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class AddressAnnouncementModel extends Model
{
    protected $table = 'AddressAnnouncement';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "product_exit_part_id",
        "country_id",
        "state_id",
        "city_id",
        "address",
        "address_file",
        "user_id",
        "create_at",
        "update_at",
        "deleted_at",
    ];

    public function countryData()
    {
        return $this->belongsTo(CountryModel::class, 'country_id');
    }
    public function stateData()
    {
        return $this->belongsTo(StateModel::class, 'state_id');
    }
    public function cityData(): BelongsTo
    {
        return $this->belongsTo(cityModel::class, 'city_id', 'id');
    }

    public function userData(): BelongsTo
    {
        return $this->belongsTo(UserModel::class, 'user_id', 'id');
    }

    public function ProductPartItem(): HasMany
    {
        return $this->hasMany(ProductPartItemModel::class, 'part_id', 'id');
    }

    public function cargoExit(): HasOne
    {
        return $this->hasOne(CargoExitModel::class,'address_announcement_id','id');
    }
}