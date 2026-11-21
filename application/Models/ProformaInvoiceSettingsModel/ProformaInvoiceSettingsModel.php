<?php

namespace App\Models\ProformaInvoiceSettingsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProformaInvoiceSettingsModel extends Model
{
    protected $table = 'ProformaInvoiceSettings';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'brand_id',
        'custom_brand_logo',
        'custom_brand_name',
        'phones',
        'address',
        'top_invoice_text',
        'bottom_invoice_text',
        'payment_terms',
        'show_unit_price_column',
        'show_discount_column',
        'template_invoice_src',
        'invoice_signature_src',
        'invoice_signature_name',
        'charges_deductions_order',
        'updated_at',
        'deleted_at'
    ];

}