<?php

namespace Packages\View;

use App\Models\MenuModel\MenuModel;
use App\Models\RoleModel\RoleModel;

class Menu
{

    public function mainMenuStart(): string
    {
        return <<<HTML
<div class="main-menu menu-fixed menu-light menu-accordion menu-shadow" data-scroll-to-active="true">
    <div class="navbar-header text-center mb-2">
        <a href="/dashboard/main">
            <img style="height: 75%;margin-top: 2.5%" src="/public/images/logo/logo-side-menu.png" alt="">
        </a>                
    </div>
    <div class="main-menu-content">
        <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
HTML;
    }

    public function mainMenuEnd(): string
    {
        return <<<HTML
        </ul>
    </div>
</div>
HTML;
    }

    public function titleMenuSection(string $titleName): string
    {
        return "<li class='navigation-header'><span>{$titleName}</span></li>";
    }

    /**
     * ساخت منو بر اساس دسترسی کاربر
     */
    public function menuList(int $parentId = 0, bool $isRoot = true, ?array $allowedIds = null): string
    {
        if ($allowedIds === null) {
            $allowedIds = $this->getAllowedMenuIds();
        }

        $childMenus = MenuModel::query()
            ->where([
                ['menu_parent', '=', $parentId],
                ['hide_menu', '=', 0],
            ])
            ->orderBy('parent_menu_priority_order')
            ->orderBy('child_menu_priority_order')
            ->get();

        if ($childMenus->isEmpty()) {
            return '';
        }

        $currentPath = trim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');
        $firstSegment = explode('/', $currentPath)[0] ?? '';

        $output = $isRoot ? '' : '<ul class="menu-content">';

        foreach ($childMenus as $item) {
            $menuId = $item->id;

            if (!in_array($menuId, $allowedIds) && !$this->hasAllowedChild($menuId, $allowedIds)) {
                continue;
            }

            $icon = htmlspecialchars($item->menu_icon ?: 'bx-folder');
            $persianName = htmlspecialchars($item->menu_persian_name);
            $englishName = htmlspecialchars($item->menu_english_name);
            $hasChildren = MenuModel::query()
                ->where([
                    ['menu_parent', '=', $menuId],
                    ['hide_menu', '=', 0],
                ])->exists();

            $isActive = $firstSegment === $englishName;
            $activeClass = $isActive ? 'active' : '';

            if ($hasChildren) {
                $childHtml = $this->menuList($menuId, false, $allowedIds);

                if (str_contains($childHtml, 'class="active"')) {
                    $activeClass = 'active';
                }
                $output .= <<<HTML
                            <li class="nav-item has-sub {$activeClass}">
                                <a href="javascript:void(0)">
                                    <i class="bx {$icon}"></i>
                                    <span class="menu-title">{$persianName}</span>
                                </a>
                                {$childHtml}
                            </li>
                            HTML;
            } else {
                $output .= <<<HTML
                            <li class="nav-item {$activeClass}">
                                <a href="/{$englishName}/main">
                                    <i class="bx {$icon}"></i>
                                    <span class="menu-item">{$persianName}</span>
                                </a>
                            </li>
                            HTML;
            }
        }

        if (!$isRoot) {
            $output .= "</ul>";
        }

        return $output;
    }


    private function getAllowedMenuIds(): array
    {
        $user = userObject();
        if (!$user) {
            return [];
        }

        // ✅ اگر permission = 0 بود => تمام منوها
        if (empty($user->permission) || (int)$user->permission === 0) {
            return MenuModel::query()->pluck('id')->toArray();
        }

        $role = RoleModel::query()->find($user->permission);
        if (!$role || empty($role->access_json)) {
            return [];
        }

        $permissions = json_decode($role->access_json, true);
        if (!is_array($permissions)) {
            return [];
        }

        // فقط منوهایی که menu = 1 دارند
        $allowedIds = [];
        foreach ($permissions as $menuId => $values) {
            if (!empty($values['menu']) && $values['menu'] == 1) {
                $allowedIds[] = (int)$menuId;
            }
        }

        // والدهایشان را هم اضافه کن
        $allMenus = MenuModel::query()->get(['id', 'menu_parent'])->keyBy('id')->toArray();

        foreach ($allowedIds as $id) {
            $parent = $allMenus[$id]['menu_parent'] ?? 0;
            while ($parent > 0) {
                if (!in_array($parent, $allowedIds)) {
                    $allowedIds[] = $parent;
                }
                $parent = $allMenus[$parent]['menu_parent'] ?? 0;
            }
        }

        return array_unique($allowedIds);
    }


    private function hasAllowedChild(int $parentId, array $allowedIds): bool
    {
        $children = MenuModel::query()->where('menu_parent', $parentId)->where('hide_menu', '=', 0)->pluck('id')->toArray();
        return array_any($children, fn($childId) => in_array($childId, $allowedIds));
    }
}