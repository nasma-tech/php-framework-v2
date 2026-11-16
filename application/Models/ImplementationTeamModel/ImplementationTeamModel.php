<?php

namespace App\Models\ImplementationTeamModel;

use App\Models\ProjectsTypeModel\ProjectsTypeModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;

class ImplementationTeamModel extends Model
{
    protected $table = 'tbl_ImplementationTeam';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'project_type_id',
        'team_title',
        'team_data_json',
        'nodes_data_json',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function projectTypes(): HasOne
    {
        return $this->hasOne(ProjectsTypeModel::class, 'id', 'project_type_id');
    }

}