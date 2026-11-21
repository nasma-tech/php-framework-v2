<?php

namespace App\Models\CarsGroupModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CarsGroupModel extends Model
{
    protected $table = 'CarsGroup';
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