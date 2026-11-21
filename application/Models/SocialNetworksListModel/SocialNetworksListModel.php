<?php

namespace App\Models\SocialNetworksListModel;

use App\Models\ContactPhonesModel\ContactPhonesModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class SocialNetworksListModel extends Model
{
    protected $table = 'SocialNetworksList';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        'title',
        'icon',
        'user_id',
        'updated_at',
        'deleted_at',
    ];

    public function contactPhones(): BelongsToMany
    {
        return $this->belongsToMany(ContactPhonesModel::class,
            'ContactSocialNetworks',
            'contact_phone_id',
            'social_network_id'
        );
    }

}