<?php

namespace App\Models\IndustryTypeModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class IndustryTypeModel extends Model
{
    protected $table = 'IndustryType';
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