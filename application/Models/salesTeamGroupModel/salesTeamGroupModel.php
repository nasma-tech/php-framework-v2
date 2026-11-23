<?php

namespace App\Models\salesTeamGroupModel;

use App\Models\UserModel\UserModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class salesTeamGroupModel extends Model
{
    protected $table = 'salesTeamGroup';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        //col Name
        "label",
        "modifyLog",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

    public function users()
    {
        return $this->belongsTo(UserModel::class, 'user_id');
    }
}