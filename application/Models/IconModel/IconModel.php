<?php

namespace App\Models\IconModel;
use Illuminate\Database\Eloquent\Model;

class IconModel extends Model
{
    protected $table = 'icons';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'title'
    ];

}