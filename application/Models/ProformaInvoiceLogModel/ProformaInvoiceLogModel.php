<?php

namespace App\Models\ProformaInvoiceLogModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProformaInvoiceLogModel extends Model
{
    protected $table = 'ProformaInvoiceLog';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'proforma_invoice_id',
        'ProformaInvoice',
        'ProformaInvoiceProducts',
        'ProformaInvoiceDetails',
        'user_id',
        'deleted_at'
    ];

}