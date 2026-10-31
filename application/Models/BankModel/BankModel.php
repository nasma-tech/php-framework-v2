<?php

namespace App\Models\BankModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class BankModel extends Model
{
    protected $table = 'banks';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "title",
        "user_id",
        "updated_at",
        "deleted_at"
    ];

}