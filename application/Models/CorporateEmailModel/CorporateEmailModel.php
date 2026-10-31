<?php

namespace App\Models\CorporateEmailModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CorporateEmailModel extends Model
{
    protected $table = '';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "mail_address",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}