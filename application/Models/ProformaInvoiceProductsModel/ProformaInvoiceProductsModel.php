<?php

namespace App\Models\ProformaInvoiceProductsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProformaInvoiceProductsModel extends Model
{
    protected $table = 'ProformaInvoiceProducts';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'proforma_invoice_id',
        'product_id',
        'amount',
        'unit_price',
        'unit_price_edit',
        'sum_unit_price',
        'discount_type',
        'discount_unit_amount',
        'discount_unit_amount_cash',
        'discount_amount',
        'total_unit_price',
        'total_product_price',
        'updated_at',
        'deleted_at'
    ];

}