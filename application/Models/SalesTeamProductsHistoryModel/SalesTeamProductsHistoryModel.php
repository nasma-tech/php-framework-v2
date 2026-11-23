<?php

namespace App\Models\SalesTeamProductsHistoryModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SalesTeamProductsHistoryModel extends Model
{
    protected $table = 'SalesTeamProductsHistory';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "team_id",
        "product_id",
        "product_price",
        "price_percentage",
        "user_id",
        "ip_address",
        "created_at",
    ];

}