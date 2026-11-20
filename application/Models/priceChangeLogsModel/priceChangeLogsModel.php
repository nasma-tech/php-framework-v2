<?php

namespace App\Models\priceChangeLogsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class priceChangeLogsModel extends Model
{
    protected $table = 'price_change_logs';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "product_id",
        "cost_price",
        "sale_price",
        "customer_price",
        "user_id",
        "modified_at",
    ];

}