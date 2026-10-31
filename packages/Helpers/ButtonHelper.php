<?php

namespace Packages\Helpers;

use App\Models\MenuModel\MenuModel;

class ButtonHelper
{
    public function actionButtons($params): string
    {
        return '<div>' .
            $this->deleteButton($params) . $this->editButton($params) . $this->viewButton($params) .
            '</div>';
    }

    public function refreshAndAddButton($name): string
    {
        return $this->addButton($name) . $this->refreshBtn();
    }

    public function refreshAndBackButton(int $size = 1): string
    {
        return $this->backBtn($size) . $this->refreshBtn($size);
    }

    public function addButton($name): string
    {
        $menuId = $this->getCurrentMenuId();
        if (PermissionHelper::can('create', $menuId)) {
            return '<a href="addIndex" style="cursor: pointer;" class="badge badge-primary text-white addIndexButton">
                افزودن ' . htmlspecialchars($name) . ' جدید
            </a>';
        }
        return '';
    }

    public function refreshBtn(int $size = 1): string
    {
        return match ($size) {
            1 => '<a class="badge badge-secondary text-white" id="refreshBtn" style="float: left;margin-right: 5px;margin-left: 5px;cursor: pointer"> تازه سازی صفحه </a>',
            2 => '<a class="btn btn-sm btn-secondary text-white" id="refreshBtn" style="float: left;margin-right: 5px;margin-left: 5px;cursor: pointer"><i class="bx bx-repost"></i> تازه سازی صفحه </a>',
            default => ''
        };
    }

    public function backBtn(int $size = 1): string
    {
        return match ($size) {
            1 => '<a class="badge badge-warning text-white" id="backBtn" style="float: left;cursor: pointer"> بازگشت</a>',
            2 => '<a class="btn btn-sm btn-warning text-white" id="backBtn" style="float: left;cursor: pointer"><i class="bx bx-undo"></i> بازگشت</a>',
            default => ''
        };
    }

    public function refreshAndBackBtn(): string
    {
        return $this->backBtn() . $this->refreshBtn();
    }

    //edit button
    public function editButton($params): string
    {
        $menuId = $this->getCurrentMenuId();
        if (PermissionHelper::can('edit', $menuId)) {
            return '<a href="editIndex/' . $params . '" class="badge badge-warning badge-icon text-white" data-toggle="tooltip" data-placement="top" title="" data-original-title="ویرایش" style="margin-right: 2px;"><i class="bx bxs-edit-alt" style="font-size: 14px"></i></a>';
        }
        return '';
    }

    //delete button
    public function deleteButton($params): string
    {
        $menuId = $this->getCurrentMenuId();
        if (PermissionHelper::can('delete', $menuId)) {
            return '<a href="deleteIndex/' . $params . '" data-id="' . $params . '" class="badge badge-danger badge-icon deleteButton" data-toggle="tooltip" data-placement="top" title="" data-original-title="حذف" style="margin-right: 2px"><i class="bx bxs-trash-alt" style="font-size: 14px"></i></a>';
        }
        return '';
    }

    //view button
    public function viewButton($params): string
    {
        $menuId = $this->getCurrentMenuId();
        if (PermissionHelper::can('view', $menuId)) {
            return '<a href="viewIndex/' . $params . '" class="badge badge-info badge-icon text-white" style="margin-right: 2px" data-toggle="tooltip" data-placement="top" title="" data-original-title="مشاهده"><i class="bx bx-show-alt" style="font-size: 14px"></i></a>';
        }
        return '';
    }

    //get id from current url
    private function getCurrentMenuId(): int
    {
        $path = explode('/', trim($_SERVER['REQUEST_URI'], '/'))[0] ?? '';
        $menu = MenuModel::query()->where('menu_english_name', '=', "$path")->first();
        return (int)$menu?->id;
    }
}