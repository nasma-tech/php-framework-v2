<?php

namespace Packages\Helpers;

use App\Models\UserModel\UserModel;

class UserHelper
{
    public
    function getCustomerGenderPersianName(string $gender): string
    {
        return match (strtolower($gender)) {
            "mr" => "آقای",
            "mrs" => "خانم",
            "eng" => "مهندس",
            "dr" => "دکتر",
            default => ''
        };
    }

    public
    function getUserFullName(?int $userId = null, string $defaultValue = ''): string
    {
        if (is_null($userId)) {
            $userId = userObject()->userId;
        }

        $get = UserModel::query()->find($userId);

        if ($get) {
            $output = $get->full_name;
        }

        return $output ?? $defaultValue;
    }

    public
    function getUserImage(int|string|null $userId = null): string
    {
        if (is_null($userId)) {
            $userId = userObject()->userId;
        }
        $check = UserModel::query()->find($userId);
        if ($check) {
            if ($check->user_image_gif && file_exists('/Storage/users/' . $check->id . '/' . $check->user_image_gif)) {
                return '/Storage/users/' . $check->id . '/' . $check->user_image_gif;
            } elseif ($check->user_image && file_exists('/Storage/Users/' . $check->id . '/' . $check->user_image)) {
                return '/Storage/Users/' . $check->id . '/' . $check->user_image;
            } else {
                return match ($check->user_gender) {
                    "Mr" => "/Storage/DefaultImages/man.jpg",
                    "Mrs" => "/Storage/DefaultImages/woman.jpg",
                    default => "/Storage/DefaultImages/default.png"
                };
            }
        } else {
            return '/Storage/DefaultImages/default.png';
        }
    }

}