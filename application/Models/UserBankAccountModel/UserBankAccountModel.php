<?php

namespace App\Models\UserBankAccountModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserBankAccountModel extends Model
{
    protected $table = 'user_bank_accounts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "user_identity_id",
        "bank_id",
        "is_default",
        "card_number",
        "account_number",
        "iban_number",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}