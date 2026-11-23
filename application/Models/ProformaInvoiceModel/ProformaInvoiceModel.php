<?php

namespace App\Models\ProformaInvoiceModel;

use App\Models\brandsModel\brandsModel;
use App\Models\CityModel\CityModel;
use App\Models\CompaniesModel\CompaniesModel;
use App\Models\CustomerContactInformationModel\CustomerContactInformationModel;
use App\Models\marketersModel\marketersModel;
use App\Models\PaymentAllocationModel\PaymentAllocationModel;
use App\Models\ProductPartModel\ProductPartModel;
use App\Models\ProformaInvoiceDetailsModel\ProformaInvoiceDetailsModel;
use App\Models\ProformaInvoiceLogModel\ProformaInvoiceLogModel;
use App\Models\ProformaInvoiceProductsModel\ProformaInvoiceProductsModel;
use App\Models\SaleContractsModel\SaleContractsModel;
use App\Models\SalesTeamModel\SalesTeamModel;
use App\Models\StateModel\StateModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
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

    public function invoiceProduct(): HasMany
    {
        return $this->hasMany(ProformaInvoiceProductsModel::class,'proforma_invoice_id','id');
    }

    public function invoiceDetail(): HasOne
    {
        return $this->hasOne(ProformaInvoiceDetailsModel::class,'proforma_invoice_id','id');
    }

    public function invoiceLog(): HasMany
    {
        return $this->hasMany(ProformaInvoiceLogModel::class,'proforma_invoice_id','id')->orderByDesc('id');
    }

    public function contract(): HasOne
    {
        return $this->hasOne(SaleContractsModel::class,'proforma_invoice_id','id');
    }

    public function paymentAllocation(): HasMany
    {
        return $this->hasMany(PaymentAllocationModel::class,'invoice_id','id');
    }

    public function marketer(): HasOne
    {
        return $this->hasOne(marketersModel::class,'id','marketer_id')->orderByDesc('id');
    }


    public function productPart(): HasMany
    {
        return $this->hasMany(ProductPartModel::class, 'proforma_invoice_id', 'id');
    }

}