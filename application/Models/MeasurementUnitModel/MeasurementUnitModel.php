<?php

namespace App\Models\MeasurementUnitModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MeasurementUnitModel extends Model
{
    protected $table = 'measurement_units';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "label",
        "user_id",
        "create_at",
        "update_at",
        "deleted_at",
    ];

    public function userData()
    {
        return $this->hasOne(UserModel::class,  'id','user_id');
    }
}