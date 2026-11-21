<?php

namespace App\Models\CarsBrandModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CarsBrandModel extends Model
{
    protected $table = 'CarsBrand';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'title',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}