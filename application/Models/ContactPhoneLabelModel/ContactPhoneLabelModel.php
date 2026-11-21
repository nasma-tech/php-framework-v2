<?php

namespace App\Models\ContactPhoneLabelModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ContactPhoneLabelModel extends Model
{
    protected $table = 'ContactPhoneLabel';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'type',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}