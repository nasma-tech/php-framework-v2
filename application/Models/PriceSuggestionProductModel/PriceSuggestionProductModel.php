<?php

namespace App\Models\PriceSuggestionProductModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PriceSuggestionProductModel extends Model
{
    protected $table = 'PriceSuggestionProduct';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'price_suggestion_id',
        'product_id',
        'amount',
        'unit_price',
        'discount_type',
        'discount_amount',
        'discount_unit_amount',
        'discount_unit_amount_cash',
        'total_unit_price',
        'total_unit_price',
        'total_product_price',
        'updated_at',
        'deleted_at'
    ];

}