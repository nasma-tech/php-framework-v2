<?php

namespace Packages\Helpers;


use App\Models\RoleModel\RoleModel;

class PermissionHelper
{
    private static ?array $permissions = null;

    /**
     * بررسی مجوز خاص
     * @param string $action مثلاً menu, create, edit, delete
     * @param int $menuId آیدی منو
     * @return bool
     */
    public static function can(string $action, int $menuId): bool
    {
        $user = userObject();
        if (!$user) {
            return false;
        }

        // اگر مدیر کل است (permission = 0)
        if (empty($user->permission) || (int)$user->permission === 0) {
            return true;
        }

        if (self::$permissions === null) {
            self::loadPermissions((int)$user->permission);
        }

        // چک کنیم که مقدار آرایه باشد
        if (!isset(self::$permissions[$menuId]) || !is_array(self::$permissions[$menuId])) {
            return false;
        }

        return !empty(self::$permissions[$menuId][$action]) && self::$permissions[$menuId][$action] == 1;
    }


    /**
     * لود مجوزها از جدول نقش‌ها
     */
    private static function loadPermissions(int $roleId): void
    {
        $role = RoleModel::query()->find($roleId);
        if (!$role || empty($role->access_json)) {
            self::$permissions = [];
            return;
        }
        $data = json_decode($role->access_json, true);
        self::$permissions = is_array($data) ? $data : [];
    }

    public function getUserPermissionName(?int $permissionId = null, string $defaultValue = '')
    {
        if (is_null($permissionId)) {
            $permissionId = userObject()->permissionId;
        }

        $get = RoleModel::query()->find($permissionId);

        if ($get) {
            $output = $get->title ?? $defaultValue;
        }

        return $output ?? $defaultValue;
    }

    public
    function isDeveloper(array $ipSelect = []): bool
    {
        if (empty($ipSelect)) {
            $developerUsers = [
                1
            ];
            return in_array(userObject()->userId, $developerUsers);
        } else {
            return in_array(userObject()->userId, $ipSelect);
        }
    }

    public
    function isSuperAdmin(): bool
    {
        return userObject()->permission == 0;
    }
}