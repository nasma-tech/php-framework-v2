<?php

namespace App\Models\BankIdentifierModel;

use Illuminate\Database\Eloquent\Model;

class BankIdentifierModel extends Model
{
    protected $table = 'bank_identifiers';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        "bank_id",
        "type",
        "value",
        "user_id",
        "updated_at",
        "deleted_at"
    ];

}