<?php

namespace App\Models\YearModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class YearModel extends Model
{
    protected $table = 'years';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "year_value",
        "from",
        "to",
        "updated_at",
        "deleted_at",
    ];
}