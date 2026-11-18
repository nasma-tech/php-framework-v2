<?php

namespace App\Models\SalesTeamModel;

use App\Models\ProjectsTypeModel\ProjectsTypeModel;
use Illuminate\Database\Eloquent\Model;

class SalesTeamModel extends Model
{
    protected $table = 'tbl_ImplementationTeam';
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


}