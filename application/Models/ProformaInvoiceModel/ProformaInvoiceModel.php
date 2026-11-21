<?php

namespace App\Models\ProformaInvoiceModel;

use App\Models\brandsModel\brandsModel;
use App\Models\CityModel\CityModel;
use App\Models\CompaniesModel\CompaniesModel;
use App\Models\CustomerContactInformationModel\CustomerContactInformationModel;
use App\Models\SalesTeamModel\SalesTeamModel;
use App\Models\StateModel\StateModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProformaInvoiceModel extends Model
{
    protected $table = 'ProformaInvoice';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'invoice_number',
        'price_suggestion_id',
        'contact_id',
        'company_id',
        'contact_project_followup_id',
        'delivery_date',
        'brand_id',
        'sale_team_id',
        'country_id',
        'state_id',
        'city_id',
        'marketer_id',
        'marketer_commission',
        'day_validity',
        'day_validity_timestamp',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function contact(): HasOne
    {
        return $this->hasOne(CustomerContactInformationModel::class, 'id', 'contact_id');
    }

    public function company(): HasOne
    {
        return $this->hasOne(CompaniesModel::class, 'id', 'company_id');
    }

    public function expert(): HasOne
    {
        return $this->hasOne(UserModel::class, 'id', 'user_id');
    }

    public function saleTeam(): HasOne
    {
        return $this->hasOne(SalesTeamModel::class, 'id', 'sale_team_id');
    }

    public function brand(): HasOne
    {
        return $this->hasOne(brandsModel::class, 'id', 'brand_id');
    }

    public function state(): HasOne
    {
        return $this->hasOne(StateModel::class, 'id', 'state_id');
    }

    public function city(): HasOne
    {
        return $this->hasOne(CityModel::class, 'id', 'city_id');
    }
}