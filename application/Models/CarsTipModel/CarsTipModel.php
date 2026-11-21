<?php

namespace App\Models\CarsTipModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CarsTipModel extends Model
{
    protected $table = 'CarsTip';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'car_model_id',
        'title',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}