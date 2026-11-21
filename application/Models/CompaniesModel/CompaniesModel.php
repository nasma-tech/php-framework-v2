<?php

namespace App\Models\CompaniesModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CompaniesModel extends Model
{
    protected $table = 'Companies';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'national_ID',
        'company_name',
        'establishment_date',
        'company_status',
        'registration_number',
        'economic_code',
        'address',
        'postal_code',
        'lat',
        'lang',
        'updated_at',
        'deleted_at'
    ];

}