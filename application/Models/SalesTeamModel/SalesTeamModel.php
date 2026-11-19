<?php

namespace App\Models\SalesTeamModel;

use App\Models\ProjectsTypeModel\ProjectsTypeModel;
use Illuminate\Database\Eloquent\Model;

class salesTeamModel extends Model
{
    protected $table = 'SalesTeam';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'company_id',
        'team_title',
        'Minimum_payment',
        'firstDiscountPolicy',
        'forceMaxDiscount',
        'MaxDurationDay',
        'license_payment',
        'team_data_json',
        'nodes_data_json',
        'all_data_chart',
        'brand_percentages',
        'brand_percentages_history',
        'parent',
        'user_id',
        'create_at',
        'update_at',
        'soft_delete',
        ];
}