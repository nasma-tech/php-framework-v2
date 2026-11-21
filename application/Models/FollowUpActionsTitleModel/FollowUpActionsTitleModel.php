<?php

namespace App\Models\FollowUpActionsTitleModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class FollowUpActionsTitleModel extends Model
{
    protected $table = 'FollowUpActionsTitle';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    use SoftDeletes;

    protected $fillable = [
        'title',
        'color',
        'user_id',
        'updated_at'
    ];

}