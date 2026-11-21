<?php

namespace App\Models\salesTeamModifyLogModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class salesTeamModifyLogModel extends Model
{
    protected $table = 'salesTeamModifyLog';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "team_id",
        "team_title",
        "json_data",
        "nodes_data_json",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}