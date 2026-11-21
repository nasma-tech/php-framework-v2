<?php

namespace App\Models\CarsModelModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CarsModelModel extends Model
{
    protected $table = 'CarsModel';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'car_group_id',
        'car_brand_id',
        'title',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}