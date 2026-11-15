<?php

namespace App\Models\ImplementationTeamModel;

use App\Models\ProjectsTypeModel\ProjectsTypeModel;
use Illuminate\Database\Eloquent\Model;

class ImplementationTeamModel extends Model
{
    protected $table = 'teams';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'team_title',
        'team_data_json',
        'nodes_data_json',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

    public function projectTypes()
    {
        return $this->hasOne(ProjectsTypeModel::class, 'id', 'project_type_id');
    }

}