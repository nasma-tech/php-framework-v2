<?php

namespace App\Models\PriceSuggestionModel;

use App\Models\ContactProjectsFollowUpModel\ContactProjectsFollowUpModel;
use App\Models\CustomerContactInformationModel\CustomerContactInformationModel;
use App\Models\ProformaInvoiceModel\ProformaInvoiceModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class PriceSuggestionModel extends Model
{
    protected $table = 'PriceSuggestion';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'price_suggestion_number',
        'contact_id',
        'contact_project_id',
        'contact_project_followup_id',
        'brand_id',
        'sale_team_id',
        'country_id',
        'state_id',
        'city_id',
        'marketer_id',
        'description',
        'day_validity',
        'day_validity_timestamp',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function contactData(): HasOne
    {
        return $this->hasOne(CustomerContactInformationModel::class,'id','contact_id');
    }

    public function followUpData(): HasOne
    {
        return $this->hasOne(ContactProjectsFollowUpModel::class,'id','contact_project_followup_id');
    }

    public function proformaInvoice(): HasOne
    {
        return $this->hasOne(ProformaInvoiceModel::class,'price_suggestion_id','id');
    }

}