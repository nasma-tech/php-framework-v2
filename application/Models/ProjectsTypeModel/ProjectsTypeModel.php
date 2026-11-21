<?php
namespace App\Models\ProjectsTypeModel;
use App\Models\ContactProjectsModel\ContactProjectsModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProjectsTypeModel extends Model
{
    protected $table = 'tbl_ProjectsType';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'title',
        'user_id',
        'updated_at',
        'deleted_at',
    ];

    public function contactProjectData(): HasMany
    {
        return $this->hasMany(ContactProjectsModel::class,'id','projects_type_id');
    }

}