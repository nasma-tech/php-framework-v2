<?php

namespace App\Models\BankAccountModel;

use App\Models\BankListModel\BankListModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class BankAccountModel extends Model
{
    protected $table = 'BankAccount';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'id',
        'has_card_number',
        'bank_list_id',
        'bank_branch_name',
        'bank_account_number',
        'bank_card_number',
        'bank_sheba_number',
        'bank_person',
        'bank_last_value',
        'bank_status',
        'user_id',
        'update_at',
        'soft_delete'
    ];

    public function bankData() :HasOne
    {
        return $this->hasOne(BankListModel::class,'id','bank_list_id');
    }

}