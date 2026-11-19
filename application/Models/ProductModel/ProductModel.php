<?php

namespace App\Models\ProductModel;

use App\Controllers\ProductGroup\ProductGroup;
use App\Models\brandsModel\brandsModel;
use App\Models\MeasurementUnitModel\MeasurementUnitModel;
use App\Models\ProductGroupModel\ProductGroupModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductModel extends Model
{
    protected $table = 'products';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "parent_id",
        "parent_unit_ratio",
        "label",
        "serial_number",
        "group_id",
        "grade_id",
        "brand_id",
        "quality_level_id",
        "measurement_unit_id",
        "unit_id",
        "cost_price",
        "sale_price",
        "customer_price",
        "file_address",
        "description",
        "complete_description",
        "user_id",
    ];

    public function measurementUnit(): HasOne
    {
        return $this->hasOne(MeasurementUnitModel::class, 'id', 'measurement_unit_id');
    }

    public function brand(): HasOne
    {
        return $this->hasOne(brandsModel::class, 'id', 'brand_id');
    }

    public function productGroup(): HasOne
    {
        return $this->hasOne(ProductGroupModel::class , 'id' , 'group_id');
    }
}