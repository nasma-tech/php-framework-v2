<?php

namespace App\Models\MailboxQueueModel;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MailboxQueueModel extends Model
{
    protected $table = 'mailbox_queue';
    protected $primaryKey = 'id';
    public $timestamps = false;

    use SoftDeletes;

    protected $fillable = [
        "mail_subject",
        "mail_receiver_address",
        "mail_cc_address_data",
        "mail_body",
        "mail_attachment",
        "status",
        "status_log",
        "deleted_at",
    ];

}