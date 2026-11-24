<?php

namespace App\Models\CargoExitCarInfoModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CargoExitCarInfoModel extends Model
{
    protected $table = 'CargoExitCarInfo';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'cargo_exit_id',
        'driver_full_name',
        'driver_phone',
        'driver_national_id',
        'two_left_digit_plate',
        'license_plate_letter',
        'three_digit_plate',
        'two_right_digit_plate',
        'cargo_file',
        'updated_at',
        'deleted_at'
    ];

}