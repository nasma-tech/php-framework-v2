<?php

namespace App\Models\ProductModel;

use App\Models\brandsModel\brandsModel;
use App\Models\MeasurementUnitModel\MeasurementUnitModel;
use App\Models\ProductGradeModel\ProductGradeModel;
use App\Models\ProductGroupModel\ProductGroupModel;
use App\Models\ProductQualitiesModel\ProductQualitiesModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductModel extends Model
{
    use SoftDeletes;

    protected $table = 'products';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'parent_id',
        'parent_unit_ratio',
        'label',
        'serial_number',
        'group_id',
        'grade_id',
        'brand_id',
        'quality_level_id',
        'measurement_unit_id',
        'unit_id',
        'cost_price',
        'sale_price',
        'customer_price',
        'file_address',
        'description',
        'complete_description',
        'user_id',
    ];

    public function measurementUnit(): BelongsTo
    {
        return $this->belongsTo(MeasurementUnitModel::class, 'measurement_unit_id');
    }

    public function brand(): BelongsTo
    {
        return $this->belongsTo(brandsModel::class, 'brand_id');
    }

    public function productGroup(): BelongsTo
    {
        return $this->belongsTo(ProductGroupModel::class, 'group_id');
    }

    public function grade(): BelongsTo
    {
        return $this->belongsTo(ProductGradeModel::class, 'grade_id');
    }

    public function quality(): BelongsTo
    {
        return $this->belongsTo(ProductQualitiesModel::class, 'quality_level_id');
    }
}