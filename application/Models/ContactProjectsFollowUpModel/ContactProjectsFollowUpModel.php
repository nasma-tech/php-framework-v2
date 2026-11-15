<?php

namespace App\Models\ContactProjectsFollowUpModel;

use App\Models\ContactProjectsFollowUpActionsModel\ContactProjectsFollowUpActionsModel;
use App\Models\FollowUpActionsTitleModel\FollowUpActionsTitleModel;
use App\Models\PriceSuggestionModel\PriceSuggestionModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ContactProjectsFollowUpModel extends Model
{
    protected $table = 'ContactProjectsFollowUp';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'contact_project_id',
        'FollowUp_action_id',
        'next_followUp_date',
        'followUp_description',
        'user_id',
        'deleted_at',
    ];

    public function followUpActionTitleData(): HasOne
    {
        return $this->hasOne(FollowUpActionsTitleModel::class,'id','FollowUp_action_id');
    }

    public function followUpActionData(): HasOne
    {
        return $this->hasOne(ContactProjectsFollowUpActionsModel::class, 'contact_project_followUp_id', 'id');
    }

    public function userData():HasOne
    {
        return $this->hasOne(UserModel::class,'id','user_id');
    }

    public function priceSuggestionData(): HasOne
    {
        return $this->hasOne(PriceSuggestionModel::class,'contact_project_followup_id','id');
    }

}