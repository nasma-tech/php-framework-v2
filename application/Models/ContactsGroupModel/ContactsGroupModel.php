<?php

namespace App\Models\ContactsGroupModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ContactsGroupModel extends Model
{
    protected $table = 'ContactsGroup';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "title",
        "user_id",
        "created_at",
        "updated_at",
        "deleted_at",
    ];

}