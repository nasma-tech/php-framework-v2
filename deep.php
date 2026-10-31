<?php
//require dirname(__DIR__) . '/vendor/autoload.php';

class CLI
{
    public function makeController($name)
    {
        $folderPath = __DIR__ . "/application/Controllers/$name";
        $fileName = "$name.php";
        $filePath = $folderPath . '/' . $fileName;
        $content = <<<PHP
<?php
namespace App\Controllers\\$name;
use App\Controllers\scheme\ControllerScheme;
class $name extends ControllerScheme{
        const string singleName = '';
        const string pluralName = '';
        protected string \$defaultModel = {$name}Model::class;
        
        public function main(){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/tables/datatable/datatables.min',
            'vendors/js/tables/datatable/dataTables.bootstrap4.min',
            'vendors/js/tables/datatable/dataTables.buttons.min',
            'vendors/js/tables/datatable/buttons.html5.min',
            'vendors/js/tables/datatable/buttons.print.min',
            'vendors/js/tables/datatable/buttons.bootstrap.min',
            'vendors/js/tables/datatable/jszip.min',
            'vendors/js/tables/datatable/pdfmake.min',
            'vendors/js/tables/datatable/vfs_fonts',
            'vendors/js/tables/datatable/buttons.colVis.min',
            //'js/$name/$name'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            //vars
                ])->display('$name/$name.tpl');
    }
    
        public function addIndex(){
                view->setPageTitle(self::pluralName);
                view->setSingleName(self::singleName);
                view->setPluralName(self::pluralName);
                view->ui([
                    //'js/$name/add-$name'
                ], [],
                    [//vars
                    ]
                )->display('$name/add-$name.tpl');
            }
            
        public function editIndex(\$id){
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/$name/edit-$name'
        ],[], [
        //var
        ])->display('$name/edit-$name.tpl');
    }
}

PHP;
        if (!is_dir($folderPath)) {
            if (mkdir($folderPath, 0777, true)) {
                echo "Folder created: $name\n";
            } else {
                die("Failed to create folder: $name\n");
            }
        } else {
            echo "Folder already exists: $name\n";
        }
        if (file_put_contents($filePath, $content) !== false) {
            echo "File created successfully: $name\n";
        } else {
            echo "Failed to create file: $name\n";
        }
    }

    public function makeModel($name)
    {
        $modelName = $name . 'Model';
        $folderPath = __DIR__ . "/application/Models/$modelName";
        $fileName = "$modelName.php";
        $filePath = $folderPath . '/' . $fileName;
        $content = <<<PHP
<?php

namespace App\Models\\{$modelName};

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class $modelName extends Model
{
    protected \$table = '';
    protected \$primaryKey = 'id';
    public \$timestamps = false;
    
    use SoftDeletes;

    protected \$fillable = [
        //col Name
    ];

}
PHP;
        if (!is_dir($folderPath)) {
            if (mkdir($folderPath, 0777, true)) {
                echo "Model created: $modelName\n";
            } else {
                die("Failed to create folder: $modelName\n");
            }
        } else {
            echo "Model already exists: $modelName\n";
        }
        if (file_put_contents($filePath, $content) !== false) {
            echo "File created successfully: $modelName\n";
        } else {
            echo "Failed to create file: $modelName\n";
        }
    }

    public function makeRoute($name)
    {
        $filePath = __DIR__ . "/application/core/route.php";
        $contentToAppend = <<<PHP
\$router->mount('/$name', function () use (\$router) {
    dynamicRoute(\$router, App\Controllers\\$name\\$name::class);
});

PHP;

        if (file_put_contents($filePath, $contentToAppend, FILE_APPEND) !== false) {
            echo "rote append success.\n";
        } else {
            echo "route append has error.\n";
        }


    }

    public function makeAll($name)
    {
        if ($name) {
            $this->makeController($name);
            $this->makeModel($name);
            $this->makeRoute($name);
        } else
            echo " name not valid\n";
    }

    public function makeService($name)
    {
        if ($name) {
            $namespace = "App\\Services\\{$name}Service";
            $content = <<<PHP
                <?php

                namespace $namespace;

                use App\core\Service\ProcessType;
                use App\core\Service\ServiceSchema;

                class {$name}Service extends ServiceSchema
                {
                    private mixed \$getData;

                    public function __construct(\$getData)
                    {
                        \$this->getData = \$getData;
                    }

                }

                PHP;

            $directory = __DIR__ . "/application/Services/{$name}Service";
            $filename = "{$name}Service.php";
            $fullPath = $directory . "/" . $filename;
            if (!file_exists($fullPath)) {
                if (!is_dir($directory)) {
                    mkdir($directory, 0777, true);
                }
                file_put_contents($fullPath, $content);
                echo "service append success.\n";
            }
        } else
            echo " name not valid\n";
    }


    public function help()
    {
        echo "Available commands:\n";
        echo " - make:controller [name]\n";
        echo " - make:model [name]\n";
        echo " - make:route [name] / make route and append to end of route file\n";
        echo " - make:all [name] / make model and controller\n";
        echo " - make:service [name] / make service\n";
    }
}

if (php_sapi_name() === 'cli') {
    $cli = new CLI();
    $command = $argv[1] ?? null;
    $name = $argv[2] ?? null;
    if (!$command) {
        $cli->help();
        exit;
    }
    $map = [
        'make:controller' => 'makeController',
        'make:model' => 'makeModel',
        'make:all' => 'makeAll',
        'make:route' => 'makeRoute',
        'make:service' => 'makeService',
    ];

    if (isset($map[$command])) {
        $method = $map[$command];
        $cli->$method($name);
    } else {
        echo "Command not found: $command\n";
        $cli->help();
    }
}