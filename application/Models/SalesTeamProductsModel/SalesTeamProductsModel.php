<?php

namespace App\Models\SalesTeamProductsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SalesTeamProductsModel extends Model
{
    protected $table = 'SalesTeamProducts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "team_id",
        "product_id",
        "product_price",
        "price_percentage",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

    public function product()
    {
        return $this->belongsTo(ProductModel::class, 'product_id', 'id');
    }
}