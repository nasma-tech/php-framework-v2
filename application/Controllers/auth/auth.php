<?php

namespace App\Controllers\auth;

use App\Models\RoleModel\RoleModel;
use App\Models\UserModel\UserModel;

class auth
{
    public $userId {
        get {
            return $this->userId;
        }
        set {
            $this->userId = $value;
        }
    }
    public $userName {
        get {
            return $this->userName;
        }
        set {
            $this->userName = $value;
        }
    }
    public $userFullName {
        get {
            return $this->userFullName;
        }
        set {
            $this->userFullName = $value;
        }
    }
    public $roleId {
        get {
            return $this->roleId;
        }
        set {
            $this->roleId = $value;
        }
    }
    public $userCompanyId {
        get {
            return $this->userCompanyId;
        }
        set {
            $this->userCompanyId = $value;
        }
    }

    public $representationId {
        get {
            return $this->representationId;

        }
        set {
            $this->representationId = $value;
        }
    }

    public $roleTitle {
        get {
            return $this->roleTitle;

        }
        set {
            $this->roleTitle = $value;
        }
    }

    public $userInfo {
        get {
            return $this->userInfo;

        }
        set {
            $this->userInfo = $value;
        }
    }

    public function authentication(): void
    {
        $userName = trim($_POST['user_name']);
        $userPassword = sha1(md5($_POST['user_password']));
        $userCheck = UserModel::query()->where([
            "username" =>$userName,
            "password_hash" => $userPassword
        ])->first();

        if ($userCheck) {
            $role = RoleModel::query()->find($userCheck->role_id);

            if ($role) {
                $this->userName = $userCheck->username;
                $this->userFullName = $userCheck->full_name;
                $this->userId = $userCheck->id;
                $this->roleId = $userCheck->role_id;
                $this->userCompanyId = $userCheck->company_id;
                $this->representationId = $userCheck->representation_id;
                $this->roleTitle = $role->title;
                $this->userInfo = [
                    'internalNumber' => ''
                ];

                $_SESSION['userId'] = $this->userId;
                $_SESSION['userName'] = $this->userName;
                $_SESSION['userFullName'] = $this->userFullName;
                $_SESSION['roleId'] = $this->roleId;
                $_SESSION['userCompanyId'] = $this->userCompanyId;
                $_SESSION['representationId'] = $this->representationId;
                $_SESSION['roleTitle'] = $this->roleTitle;
                $_SESSION['userInfo'] = $this->userInfo;
                echo 'successLogin';
            }
        } else {
            echo 'userNotFound';
        }
    }

}