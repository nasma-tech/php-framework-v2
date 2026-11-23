<?php

namespace App\Models\BankListModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class BankListModel extends Model
{
    protected $table = 'BankList';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'bank_list_name',
        'bank_list_logo',
        'bank_list_code',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}