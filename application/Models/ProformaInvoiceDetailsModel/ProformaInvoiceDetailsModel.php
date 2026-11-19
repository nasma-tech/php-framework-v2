<?php

namespace App\Models\ProformaInvoiceDetailsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProformaInvoiceDetailsModel extends Model
{
    protected $table = 'ProformaInvoiceDetails';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'proforma_invoice_id',
        'expert_alias_name',
        'charges_deductions',
        'invoice_sum',
        'invoice_sum_discount',
        'invoice_net_sum',
        'invoice_sum_tax',
        'invoice_sum_tax_details',
        'invoice_sum_total',
        'payment_terms',
        'bottom_invoice_text',
        'updated_at',
        'deleted_at'
    ];

}