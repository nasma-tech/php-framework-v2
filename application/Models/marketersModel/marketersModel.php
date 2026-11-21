<?php

namespace App\Models\marketersModel;

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
        "person_type_id",
        "marketing_group_id",
        "marketer_gender",
        "marketer_full_name",
        "company_national_code",
        "birth_date",
        "registration_date",
        "marketer_national_code",
        "bank_id",
        "marketer_accountNumber",
        "marketer_shebaNumber",
        "marketer_cardNumber",
        "commissionPercentage",
        "company_name",
        "state_id",
        "city_id",
        "marketer_address",
        "marketer_phones",
        "marketer_mobiles",
        "ceo_full_name",
        "connector_full_name",
        "front_national_card_image",
        "back_national_card_image",
        "contract_image",
        "last_changes_image",
        "official_newspaper_image",
        "contract_image_legal",
        "expert_id",
        "user_id",
        "create_at",
        "update_at",
        "deleted_at",
    ];

}