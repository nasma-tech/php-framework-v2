<?php

namespace App\Models\ProductCategoriesModel;

use App\Models\ProductGroupModel\ProductGroupModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductCategoriesModel extends Model
{
    use SoftDeletes;

    protected $table = 'product_categories';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'label',
        'user_id',
        'update_at',
        'deleted_at',
    ];

    public function userData(): BelongsTo
    {
        return $this->belongsTo(UserModel::class, 'user_id');
    }

    public function productGroups(): HasMany
    {
        return $this->hasMany(ProductGroupModel::class, 'category_id');
    }
}