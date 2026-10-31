<?php

namespace Packages\View;

use Packages\Helpers\ButtonHelper;
use Packages\Helpers\DateTimeHelper;
use Packages\Helpers\UserHelper;
use Packages\Security\Csrf;
use Packages\View\Helpers\FlashMessageHelper;
use Smarty;

class View
{
    private $pageTitle;
    private $singleName;
    private $pluralName;
    private $Model;

    public function ui($scriptsPath = '', $cssPath = '', array $variables = []): Smarty
    {
        $ui = new Smarty();
        $ui->setTemplateDir('view');
        $ui->setCompileDir('compiled/');
        $ui->setConfigDir('ui/conf/');
        $ui->setCacheDir('ui/cache/');
        $ui->assign('app_url', APP_URL . '/');
        $ui->assign('_theme', APP_URL . '/public');
        $ui->assign('pageTitle', $this->getPageTitle());
        $ui->assign('singleName', $this->getSingleName());
        $ui->assign('pluralName', $this->getPluralName());
        $ui->assign('getData', $this->getModel());
        $ui->assign('buttonHelper', new ButtonHelper());
        $ui->assign('dateTimeHelper', new DateTimeHelper());
        $ui->assign('csrf', new Csrf());
        $ui->assign('userHelper', new UserHelper());
        $ui->assign('flashMessageHelper', new FlashMessageHelper());
        $ui->caching = Smarty::CACHING_OFF;
        $ui->compile_check = true;
        $ui->force_compile = true;
        $ui->cache_lifetime = 0;

        foreach ($variables as $key => $item) {
            $ui->assign("$key", $item);
        }

        //Assign JS
        $js = $this->readJs($scriptsPath);
        $ui->assign('scriptsPath', $js);
        //Assign CSS
        $css = $this->readCss($cssPath);
        $ui->assign('cssPath', $css);
        //Make Menu
        $ui->assign('menu', new \Packages\View\Menu());

        return $ui;
    }


    public function readCss(array|string $path): string
    {
        if (empty($path)) {
            return '';
        }
        $paths = is_array($path) ? $path : [$path];
        $css = [];
        foreach ($paths as $cssAddress) {
            $cssAddress = trim($cssAddress, '/');
            $filePath = '/public/'. $cssAddress. '.css';
            $css[] = '<link rel="stylesheet" type="text/css" href="' . $filePath . '"/>';
        }
        return implode("\n", $css);
    }

    public function readJs(array|string $path): string
    {
        if (empty($path)) {
            return '';
        }
        $paths = is_array($path) ? $path : [$path];
        $scripts = [];
        foreach ($paths as $scriptAddress) {
            $scriptAddress = trim($scriptAddress, '/');
            $filePath = '/public/'. $scriptAddress. '.js';
            $version = is_file($filePath)? filemtime($filePath): time();
            $src = '/public/'. htmlspecialchars($scriptAddress, ENT_QUOTES, 'UTF-8'). '.js?v='. $version;
            $scripts[] = '<script src="' . $src . '"></script>';
        }
        return implode("\n", $scripts);
    }


    /**
     * @param mixed $pageTitle
     */
    public function setPageTitle(mixed $pageTitle): void
    {
        $this->pageTitle = $pageTitle;
    }

    /**
     * @return mixed
     */
    private function getPageTitle(): mixed
    {
        return $this->pageTitle;
    }

    /**
     * @param mixed $singleName
     */
    public function setSingleName(mixed $singleName): void
    {
        $this->singleName = $singleName;
    }


    /**
     * @return mixed
     */

    private function getSingleName(): mixed
    {
        return $this->singleName;
    }

    /**
     * @param mixed $pluralName
     */
    public function setPluralName(mixed $pluralName): void
    {
        $this->pluralName = $pluralName;
    }

    /**
     * @return mixed
     */
    private function getPluralName(): mixed
    {
        return $this->pluralName;
    }

    /**
     * @param mixed $Model
     */
    public function setModel(mixed $Model): void
    {
        $get = $Model;

        if ($get) {
            $this->Model = $get;
        } else {
            header('location:/notAccess');
        }
    }

    /**
     * @return mixed
     */
    public function getModel(): mixed
    {
        return $this->Model;
    }

    public function debug(bool $debug = false, array $users = [], array $ips = [], $title = 'در حال بروزرسانی', $description = 'این صفحه در دست بروزرسانی هستش...'): void
    {
        $userLogin = userObject()->userId;
        $userIp = $_SERVER['REMOTE_ADDR'];
        if ($debug && !in_array($userLogin, $users) && !in_array($userIp, $ips)) {
            $view = new View();
            $view->ui('', '', [
                'getMsg' => $this->show404Error(),
                'title' => $title,
                'description' => $description
            ])->display('sections/develop.tpl');
            die();
        }
    }

    public function show404Error(): string
    {
        return '<div class="app-content content bg-light">
                    <div class="content-wrapper">
                        <div class="content-body">
                            <div class="card bg-transparent shadow-none">
                                <div class="card-content text-center">
                                    <div class="card-body text-center bg-transparent miscellaneous">
                                        <h1 class="error-title">صفحه یافت نشد :(</h1>
                                        <p class="pb-3 text-white">صفحه ای که به دنبال آن هستید موجود نیست</p>
                                        <img class="img-fluid" src="' . APP_URL . '/public/images/pages/404.png" alt="404 error">
                                    </div>
                                    <button class="btn btn-sm btn-primary mt-2">رفتن به داشبورد</button>
                                </div>
                            </div>
                         </div>
                        </div>
                    </div>';
    }


}