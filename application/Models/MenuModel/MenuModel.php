<?php

namespace App\Models\MenuModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MenuModel extends Model
{
    protected $table = 'menus';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'menu_parent',
        'menu_persian_name',
        'menu_english_name',
        'menu_icon',
        'parent_menu_priority_order',
        'child_menu_priority_order',
        'hide_menu',
        'user_id',
        'updated_at',
        'deleted_at'
    ];

}