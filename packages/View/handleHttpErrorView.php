<?php

namespace Packages\View;

use JetBrains\PhpStorm\NoReturn;

class handleHttpErrorView
{
    private const array PAGES = [
        401 => 'templates/401.tpl',
        403 => 'templates/403.tpl',
        404 => 'templates/404.tpl',
        500 => 'templates/500.tpl',
    ];

    #[NoReturn]
    public static function handle(int $code, string $errorText = ''): void
    {
        if (file_exists(__SOURCE__.'view/'.self::PAGES[$code])) {
            http_response_code($code);
            view->ui([], [], [
                'errorText' => $errorText,
                'errorCode' => $code,
            ])->display(self::PAGES[$code] ?? self::PAGES[500]);
        } else {
            http_response_code(500);
            view->ui([], [], [
                'errorText' => $errorText,
                'errorCode' => $code,
            ])->display(self::PAGES[500]);
        }
        exit;
    }
}