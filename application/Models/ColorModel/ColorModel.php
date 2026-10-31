<?php

namespace App\Models\ColorModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class ColorModel extends Model
{
    protected $table = 'colors';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'ral_code',
        'name',
        'persian_name',
        'rgb_color',
        'hex',
        'color_status',
        'user_id',
        'update_at',
        'soft_delete',
        'company_id',
        'cartable_definition_id',
        'schema_work_group',
        'cartable_circulation',
        'process_log',
        'change_schema_log',
        'process_status',
        'updated_at',
        'deleted_at'
    ];

}