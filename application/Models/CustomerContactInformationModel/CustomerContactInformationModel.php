<?php

namespace App\Models\CustomerContactInformationModel;

use App\Models\CityModel\CityModel;
use App\Models\CompaniesModel\CompaniesModel;
use App\Models\ContactAcquisitionSourcesModel\ContactAcquisitionSourcesModel;
use App\Models\ContactProjectsModel\ContactProjectsModel;
use App\Models\ContactsGroupModel\ContactsGroupModel;
use App\Models\StateModel\StateModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class CustomerContactInformationModel extends Model
{
    protected $table = 'Contacts';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'contact_code',
        'first_name',
        'last_name',
        'contact_type',
        'state_id',
        'city_id',
        'national_code',
        'contact_group_id',
        'contact_acquisition_source_id',
        'user_id',
        'updated_at',
        'deleted_at',
    ];

    public function companies(): BelongsToMany
    {
        return $this->belongsToMany(CompaniesModel::class, 'ContactCompanyLinks', 'contact_id', 'company_id');
    }

    public function projectData(): HasMany
    {
        $query = $this->hasMany(ContactProjectsModel::class, 'contact_id', 'id');
        if (userObject()->roleId != 0) {
            $query->where('user_id', userObject()->userId);
        }
        return $query;
    }

    public function stateDate(): HasOne
    {
        return $this->hasOne(StateModel::class, 'id', 'state_id');
    }

    public function cityDate(): HasOne
    {
        return $this->hasOne(CityModel::class, 'id', 'city_id');
    }

    public function contactGroupData(): HasOne
    {
        return $this->hasOne(ContactsGroupModel::class, 'id', 'contact_group_id');
    }

    public function contactAcquisitionSource(): HasOne
    {
        return $this->hasOne(ContactAcquisitionSourcesModel::class, 'id', 'contact_acquisition_source_id');
    }

    public function contactFullName(): string
    {
        return $this->first_name . " " . $this->last_name;
    }

}