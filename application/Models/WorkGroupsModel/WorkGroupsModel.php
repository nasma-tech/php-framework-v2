<?php
namespace App\Models\WorkGroupsModel;
use Illuminate\Database\Eloquent\Model;

class WorkGroupsModel extends Model
{
    protected $table = 'WorkGroup';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'work_group_title',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}