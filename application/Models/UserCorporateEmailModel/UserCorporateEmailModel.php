<?php

namespace App\Models\UserCorporateEmailModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserCorporateEmailModel extends Model
{
    protected $table = 'user_corporate_emails';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "user_account_id",
        "corporate_email_id",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}