<?php

namespace App\Models\ContactProjectsFollowUpActionsModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ContactProjectsFollowUpActionsModel extends Model
{
    protected $table = 'ContactProjectsFollowUpActions';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'contact_project_followUp_id',
        'followUp_description',
        'action_time',
        'user_id',
        'deleted_at'
    ];

    public function userData(): HasOne
    {
        return $this->hasOne(UserModel::class,'id','user_id');
    }

}