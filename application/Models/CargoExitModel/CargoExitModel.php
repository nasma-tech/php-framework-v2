<?php

namespace App\Models\CargoExitModel;

use App\Models\CargoExitCarInfoModel\CargoExitCarInfoModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class CargoExitModel extends Model
{
    protected $table = 'CargoExit';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'address_announcement_id',
        'exit_status',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function cargoExitInfo(): HasMany
    {
        return $this->hasMany(CargoExitCarInfoModel::class,'cargo_exit_id','id');
    }

}