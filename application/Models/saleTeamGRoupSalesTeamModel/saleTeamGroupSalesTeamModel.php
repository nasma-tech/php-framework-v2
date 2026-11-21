<?php

namespace App\Models\saleTeamGroupSalesTeamModel;

use App\Models\salesTeamGroupModel\salesTeamGroupModel;
use App\Models\SalesTeamModel\SalesTeamModel;
use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class saleTeamGroupSalesTeamModel extends Model
{
    protected $table = 'saleTeamGroupSalesTeam';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "SalesTeamGroup_id",
        "salesTeam_id",
        "user_id",
        "created_at",
        "updated_at",
        'deleted_at'
    ];

    public function user()
    {
        return $this->belongsTo(UserModel::class, 'user_id', 'id');
    }

    public function salesTeam()
    {
        return $this->belongsTo(SalesTeamModel::class, 'salesTeam_id', 'id');
    }

    public function salesTeamGroup()
    {
        return $this->belongsTo(SalesTeamGroupModel::class, 'salesTeamGroup_id', 'id');
    }
}