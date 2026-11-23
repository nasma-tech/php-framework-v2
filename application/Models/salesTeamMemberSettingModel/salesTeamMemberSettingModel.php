<?php

namespace App\Models\salesTeamMemberSettingModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class salesTeamMemberSettingModel extends Model
{
    protected $table = 'salesTeam_member_setting';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "member_id",
        "sales_team_id",
        "overPrice",
        "underPrice",
        "discountPercent",
        "sellClose",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
        "modifyLog"
    ];

}