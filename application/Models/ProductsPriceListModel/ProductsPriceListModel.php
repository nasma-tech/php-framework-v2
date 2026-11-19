<?php

namespace App\Models\ProductsPriceListModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductsPriceListModel extends Model
{
    protected $table = '';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        //col Name
    ];

}