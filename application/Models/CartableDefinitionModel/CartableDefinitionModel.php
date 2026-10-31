<?php

namespace App\Models\CartableDefinitionModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CartableDefinitionModel extends Model
{
    protected $table = 'cartable_definitions';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "form_persian_title",
        "form_english_title",
        "cartable_schema",
        "cartable_model",
        "view_address",
        "service_address",
        "user_id",
        "updated_at",
        "deleted_at",
    ];

}