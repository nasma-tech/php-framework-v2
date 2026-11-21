<?php

namespace App\Models\ChargesDeductionsModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ChargesDeductionsModel extends Model
{
    protected $table = 'ChargesDeductions';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'identifier',
        'title',
        'coefficient',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}