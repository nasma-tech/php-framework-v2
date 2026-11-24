<?php

namespace App\Models\ProductExitPartsModel;

use App\Models\AddressAnnouncementModel\AddressAnnouncementModel;
use App\Models\ProductExitPartItemsModel\ProductExitPartItemsModel;
use App\Models\ProductPartModel\ProductPartModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductExitPartsModel extends Model
{
    protected $table = 'ProductExitParts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'proforma_invoice_id',
        'product_part_id',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function productParts(): HasOne
    {
        return $this->hasOne(ProductPartModel::class,'id','product_part_id');
    }

    public function addressAnnouncement(): HasOne
    {
        return $this->hasOne(AddressAnnouncementModel::class,'product_exit_part_id','id');
    }

    public function productExitPartItems(): HasMany
    {
        return $this->hasMany(ProductExitPartItemsModel::class,'product_exit_part_id','id');
    }

}