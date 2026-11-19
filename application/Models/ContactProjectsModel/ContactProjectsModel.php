<?php

namespace App\Models\ContactProjectsModel;

use App\Controllers\users\users;
use App\Models\ContactProjectRequestsModel\ContactProjectRequestsModel;
use App\Models\ContactProjectsFollowUpModel\ContactProjectsFollowUpModel;
use App\Models\CustomerContactInformationModel\CustomerContactInformationModel;
use App\Models\IndustryTypeModel\IndustryTypeModel;
use App\Models\PriceSuggestionModel\PriceSuggestionModel;
use App\Models\ProductModel\ProductModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class ContactProjectsModel extends Model
{
    protected $table = 'ContactProjects';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'contact_id',
        'project_code',
        'payment_type',
        'purchase_type',
        'industry_type_id',
        'expert_id',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function contactData(): HasOne
    {
        return $this->hasOne(CustomerContactInformationModel::class,'id','contact_id');
    }

    public function projectRequests(): HasMany
    {
        return $this->hasMany(ContactProjectRequestsModel::class,'contact_project_id','id');
    }

    public function followUpData(): HasMany
    {
        return $this->hasMany(ContactProjectsFollowUpModel::class,'contact_project_id','id')->orderByDesc('id');
    }

    public function industryTypeData() :HasOne
    {
        return $this->hasOne(IndustryTypeModel::class,'id','industry_type_id');
    }

    public function expertData()
    {
        return $this->hasOne(UserModel::class,'id','expert_id');
    }

    public function userData(): HasOne
    {
        return $this->hasOne(UserModel::class,'id','user_id');
    }


}