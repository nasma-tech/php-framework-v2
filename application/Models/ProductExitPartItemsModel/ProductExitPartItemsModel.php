<?php

namespace App\Models\ProductExitPartItemsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductExitPartItemsModel extends Model
{
    protected $table = 'ProductExitPartItems';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'product_exit_part_id',
        'product_exit_part_item_id',
        'exit_amount',
        'unit_price',
        'sum_unit_price',
        'invoice_sum_tax_details',
        'exit_part_total_sum',
        'updated_at',
        'deleted_at'
    ];

}