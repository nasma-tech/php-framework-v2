<?php

namespace App\Models\CorporateInternalExtensionModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CorporateInternalExtensionModel extends Model
{
    protected $table = 'corporate_internal_extensions';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "internal_extension",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}