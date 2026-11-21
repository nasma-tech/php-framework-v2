<?php

namespace App\Models\ContactAcquisitionSourcesModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ContactAcquisitionSourcesModel extends Model
{
    protected $table = 'ContactAcquisitionSources';
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