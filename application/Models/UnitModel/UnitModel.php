<?php

namespace App\Models\UnitModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UnitModel extends Model
{
    protected $table = 'units';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'unit_name',
        'unit_symbol',
        'user_id',
        'update_at',
        'deleted_at'
    ];

}