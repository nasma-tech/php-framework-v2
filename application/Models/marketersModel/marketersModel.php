<?php

namespace App\Models\marketersModel;

use App\Models\CityModel\CityModel;
use App\Models\marketerGroupModel\marketerGroupModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class marketersModel extends Model
{
    protected $table = 'marketers';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "marketer_type",
        "marketer_gender",
        "marketer_full_name",
        "birth_date",
        "marketer_national_code",
        "front_national_card_image",
        "back_national_card_image",
        "contract_image",
        "company_national_code",
        "company_name",
        "registration_date",
        "ceo_full_name",
        "connector_full_name",
        "contract_image_legal",
        "official_newspaper_image",
        "last_changes_image",
        "marketing_group_id",
        "expert_id",
        "city_id",
        "commissionPercentage",
        "marketer_cardNumber",
        "bank_id",
        "marketer_accountNumber",
        "marketer_shebaNumber",
        "marketer_address",
        "marketer_phones",
        "marketer_mobiles",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",

    ];

    public function groupData()
    {
        return $this->hasOne(marketerGroupModel::class,'id', 'marketing_group_id');
    }

    public function expertData()
    {
        return $this->belongsTo(UserModel::class,'expert_id', 'id');
    }

    public function userData()
    {
        return $this->belongsTo(UserModel::class,'user_id', 'id');
    }

    public function citiesData()
    {
        return $this->belongsTo(CityModel::class,'city_id', 'id');
    }
}