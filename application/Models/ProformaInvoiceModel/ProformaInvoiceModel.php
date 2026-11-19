<?php

namespace App\Models\ProformaInvoiceModel;

use Illuminate\Database\Eloquent\Model;
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

}