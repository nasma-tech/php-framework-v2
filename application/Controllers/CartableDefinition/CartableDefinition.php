<?php

namespace App\Controllers\CartableDefinition;

use App\Controllers\scheme\ControllerScheme;
use App\Models\CartableDefinitionModel\CartableDefinitionModel;
use App\Models\RoleModel\RoleModel;
use App\Models\UserModel\UserModel;
use Exception;

class CartableDefinition extends ControllerScheme
{
    const string singleName = 'کارتابل';
    const string pluralName = 'کارتابل ها';
    protected string $defaultModel = CartableDefinitionModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);

        view->setModel($this->defaultModel::query()->get());
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
            //'js/CartableDefinition/CartableDefinition'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('CartableDefinition/CartableDefinition.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/CartableDefinition/add-CartableDefinition'
        ], [],
            [
                "models" => getAllModels()
            ]
        )->display('CartableDefinition/add-CartableDefinition.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/CartableDefinition/edit-CartableDefinition'
        ], [], [
            //var
        ])->display('CartableDefinition/edit-CartableDefinition.tpl');
    }

    public function getPermissionList(): void
    {
        $getAllStaff = RoleModel::all();
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'titlePersian' => $item['title'],
                'titleEnglish' => "-",
                'users' => (function () use ($item) {
                    $permissionId = $item['id'];
                    $query = UserModel::query();

                    if ($permissionId == 1) {
                        $query->whereIn('permission_id', [0, 1]);
                    } else {
                        $query->where(['permission_id' => $permissionId]);
                    }
                    $users = $query->get();
                    $output = [];
                    foreach ($users as $row) {
                        $output[] = [
                            'userId' => $row->id,
                            'userFullName' => $row->full_name,
                        ];
                    }
                    return $output;
                })()
            ];
        }, $getAllStaff->toArray()));
    }

    public function add(): void
    {
        $data = $this->requestArray();
        if ($this->validateRequestsData()) {
            $this->changeRequestValues('cartable_schema', json_encode(array_values($data['cartable_schema']), JSON_UNESCAPED_UNICODE));
            $namespace = "App\\Services\\{$data['service_address']}";
            $classPath = "App\\Services\\{$data['service_address']}\\{$data['service_address']}";
            $content = <<<PHP
                <?php

                namespace $namespace;

                use App\core\Service\ProcessType;
                use App\core\Service\ServiceSchema;

                class {$data['service_address']} extends ServiceSchema
                {
                    private mixed \$getData;

                    public function __construct(\$getData)
                    {
                        \$this->getData = \$getData;
                    }

                }

                PHP;
            $directory = __SOURCE__ . "/application/Services/{$data['service_address']}";
            $filename = "{$data['service_address']}.php";
            $fullPath = $directory . "/" . $filename;
            if (!file_exists($fullPath)) {
                if (!is_dir($directory)) {
                    mkdir($directory, 0777, true);
                }
                file_put_contents($fullPath, $content);
            }
            $this->changeRequestValues('service_address', $classPath);
            parent::add();
        }
    }

    /**
     * @throws Exception
     */
    public function getAllCartableData(): array
    {
        $get = $this->defaultModel::all();
        $output = [];

        foreach ($get as $item) {
            if (class_exists($item->cartable_model)) {
                $newInstance = new $item->cartable_model;
                $cartable = new \Cartable($newInstance);

                $output[$item->id] = [
                    'definitionData' => $item->toArray(),
                    'data' => $cartable->getCartableByUser()
                ];
            } else {
                throw new Exception("Model Class $item->cartable_model not Found!");
            }
        }

        return $output;
    }
}