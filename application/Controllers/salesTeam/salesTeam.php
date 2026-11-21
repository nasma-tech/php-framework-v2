<?php

namespace App\Controllers\salesTeam;
use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\SalesTeamModel\SalesTeamModel;
use App\Models\salesTeamModifyLogModel\salesTeamModifyLogModel;
use Packages\Security\Csrf;

require_once __SOURCE__ . 'application/Controllers/scheme/ControllerScheme.php';

class salesTeam extends ControllerScheme
{
    const string singleName = 'تیم فروش';
    const string pluralName = 'تیم های فروش';
    protected string $defaultModel = SalesTeamModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'assets/vendors/js/tables/datatable/datatables.min',
            'assets/vendors/js/tables/datatable/dataTables.bootstrap4.min',
            'assets/vendors/js/tables/datatable/dataTables.buttons.min',
            'assets/vendors/js/tables/datatable/buttons.html5.min',
            'assets/vendors/js/tables/datatable/buttons.print.min',
            'assets/vendors/js/tables/datatable/buttons.bootstrap.min',
            'assets/vendors/js/tables/datatable/jszip.min',
            'assets/vendors/js/tables/datatable/pdfmake.min',
            'assets/vendors/js/tables/datatable/vfs_fonts',
            'assets/vendors/js/tables/datatable/buttons.colVis.min',
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'list' => SalesTeamModel::query()->get(),
            ])->display('salesTeam/salesTeam.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            '/js/valadart/app',
            '/js/valadart/go',
            '/js/valadart/context-menu',
            '/js/valadart/data',
            '/js/valadart/diagram-init',
            '/js/valadart/editing',
            '/js/valadart/dragging-tool',
            '/js/valadart/lookup',
            '/js/valadart/model-helpers',
            '/js/valadart/node-template',
            '/js/salesTeam/add-salesTeam',
        ], [
            '/css/valadart/style',
        ],[
            'Brands' => brandsModel::query()->get(),
        ])->display('salesTeam/add-salesTeam.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(SalesTeamModel::query()->find($id));
        view->ui([
            '/js/valadart/app',
            '/js/valadart/go',
            '/js/valadart/context-menu',
            '/js/valadart/data',
            '/js/valadart/diagram-init',
            '/js/valadart/editing',
            '/js/valadart/dragging-tool',
            '/js/valadart/lookup',
            '/js/valadart/model-helpers',
            '/js/valadart/node-template',
            '/js/salesTeam/add-salesTeam',
        ], [
            '/css/valadart/style',
        ],[
            'Brands' => brandsModel::query()->get(),
        ])->display('salesTeam/edit-salesTeam.tpl');
    }

    public function viewIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(ORM::for_table($this->Model())->find_one($id));
        view->ui([
            'assets/vendors/js/charts/valadart/go',
            'assets/vendors/js/charts/valadart/data',
            'assets/vendors/js/charts/valadart/lookup',
            'assets/vendors/js/charts/valadart/model-helpers',
            'assets/vendors/js/charts/valadart/editing',
            'assets/vendors/js/charts/valadart/context-menu',
            'assets/vendors/js/charts/valadart/node-template',
            'assets/vendors/js/charts/valadart/dragging-tool',
            'assets/vendors/js/charts/valadart/diagram-init',
            'assets/vendors/js/charts/valadart/app',
        ], [
            'assets/vendors/css/charts/valadart/style'
        ], [

        ])->display('SalesAndMarketing/salesTeam/view-salesTeam.tpl');
    }

    public function permissionIndex($id)
    {

        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(SalesTeamModel::query()->find($id));
        view->ui([
            'assets/js/salesTeam/permission-salesTeam',
        ], [], [
            'brands' => BrandsModel::query()->get(),
        ])->display('/salesTeam/permission-salesTeam.tpl');
    }



    public function add()
    {
        csrf->csrfValidate();
        $data = $this->requestArray();


        $needle = [
            'team_title',
            'team_data_json',
        ];

        if ($this->validateRequestsData($needle)) {

            $newNodes = json_decode($data['team_data_json'], true)['nodeDataArray'] ?? [];

            $add = SalesTeamModel::query()->insert([
                'team_title' => $data['team_title'],
                'team_data_json' => json_encode($newNodes, JSON_UNESCAPED_UNICODE),
                'nodes_data_json' => $data['team_data_json'],
                'user_id' => userObject()->userId,
            ]);

            if ($add) {
                return $this->successCallBack('/salesTeam/main');

            }
        } else {
            header('location:/notAccess');
        }
    }

    public function edit($id)
    {
        csrf->csrfValidate();
        $getData = SalesTeamModel::query()->find($id);

        if ($getData) {
            $needle = [
                'team_title',
                'jsonOutput',
            ];
            $data = $this->requestArray();
            if ($this->validateRequestsData($needle)) {
                $newNodes = json_decode($data['jsonOutput'], true)['nodeDataArray'] ?? [];
//                if (empty($newNodes) || $this->hasDuplicate($newNodes, $id)) {
//                    echo 'duplicate';
//                    return;
//                }
                $addLog = salesTeamModifyLogModel::query()->create([
                    "team_id" => $getData->id,
                    "team_title" => $getData->team_title,
                    "json_data" => $getData->team_data_json,
                    "nodes_data_json" => $getData->nodes_data_json,
                    "user_id" => userObject()->userId,
                ]);
                if ($addLog->save()) {
                    $getData->update([
                        'team_title' => $data['team_title'],
                        'team_data_json' => json_encode($newNodes, JSON_UNESCAPED_UNICODE),
                        'nodes_data_json' => $data['jsonOutput'],
                    ]);
                    if ($getData->save()) {
                        $this->successCallBack('/salesTeam/main');
                    }
                }
            } else {
                header('location:/notAccess');
            }
        } else {
            header('location:/notAccess');
        }
    }

    public function getSalePermissionBrands()
    {
        $brands = ORM::for_table('tbl_Brands')
            ->select_many([
                'id',
                'name' => 'brand_persian_name',
                'latin_name' => 'brand_latin_name',
                'logo' => 'brand_logo',
            ])
            ->where('soft_delete', 0)
            ->order_by_asc('brand_persian_name')
            ->find_array();
        echo json_encode([
            'success' => true,
            'brands' => $brands,
        ], JSON_UNESCAPED_UNICODE);
        exit;
    }

    public function getSalePermissionProducts()
    {
        $data = $this->requestArray();
        $brandId = (int)($data['brand_id'] ?? 0);
        $page = max(1, (int)($data['page'] ?? 1));
        $limit = min(50, max(10, (int)($data['limit'] ?? 30)));
        $search = trim($data['search'] ?? '');

        if ($brandId <= 0) {
            echo json_encode([
                'success' => false,
                'message' => 'برند نامعتبر است.',
            ], JSON_UNESCAPED_UNICODE);
            exit();
        }

        $offset = ($page - 1) * $limit;
        $query = ORM::for_table('qc_Products')
            ->table_alias('p')
            ->left_outer_join('qc_ProductCategories', ['p.category_id', '=', 'c.id'], 'c')
            ->left_outer_join('qc_ProductGroups', ['p.group_id', '=', 'g.id'], 'g')
            ->left_outer_join('qc_ProductGrades', ['p.grade_id', '=', 'gr.id'], 'gr')
            ->left_outer_join('qc_ProductQualities', ['p.quality_id', '=', 'q.id'], 'q')
            ->left_outer_join('qc_Units', ['p.unit_id', '=', 'u.id'], 'u')
            ->where('p.brand_id', $brandId)
            ->where('p.is_active', 1)
            ->where('p.soft_delete', 0);

        if ($search !== '') {
            $searchLike = '%' . $search . '%';
            $query->where_raw('(p.title LIKE ? OR p.product_id LIKE ?)', [$searchLike, $searchLike]);
        }

        $total = $query->count();
        $products = $query->select_many([
            'id' => 'p.id',
            'brand_id' => 'p.brand_id',
            'product_code' => 'p.product_id',
            'name' => 'p.title',
            'default_price' => 'p.sale_price',
            'category_name' => 'c.title',
            'group_name' => 'g.title',
            'grade_name' => 'gr.title',
            'quality_name' => 'q.title',
            'unit_name' => 'u.unite_name',
            'unit_symbol' => 'u.unit_symbol',
        ])->order_by_asc('p.title')
            ->limit($limit)
            ->offset($offset)
            ->find_array();

        foreach ($products as &$product) {
            $product['id'] = (int)$product['id'];
            $product['brand_id'] = (int)$product['brand_id'];
            $product['default_price'] = (int)($product['default_price'] ?? 0);
            $product['category_name'] = $product['category_name'] ?? '';
            $product['group_name'] = $product['group_name'] ?? '';
            $product['grade_name'] = $product['grade_name'] ?? '';
            $product['quality_name'] = $product['quality_name'] ?? '';
            $product['unit_name'] = $product['unit_name'] ?? '';
            $product['unit_symbol'] = $product['unit_symbol'] ?? '';
        }

        unset($product);
        echo json_encode([
            'success' => true,
            'products' => $products,
            'pagination' => [
                'page' => $page,
                'limit' => $limit,
                'total' => $total,
                'has_more' => ($offset + count($products)) < $total,
            ],
        ], JSON_UNESCAPED_UNICODE);
        exit();
    }

    public function getSalePermissionProductsForTeam()
    {
        $data = $this->requestArray();
        $teamId = (int)($data['team_id'] ?? 0);
        if ($teamId <= 0) {
            echo json_encode([
                'success' => false,
                'message' => 'تیم نامعتبر است.',
            ], JSON_UNESCAPED_UNICODE);
            exit();
        }

        $permissions = ORM::for_table('qc_SalesTeamProducts')->table_alias('stp')
            ->select_many([
                'product_id' => 'stp.product_id',
                'price' => 'stp.product_price',
                'brand_id' => 'p.brand_id',
                'brand_name' => 'b.brand_persian_name',
                'name' => 'p.title',
                'code' => 'p.product_id',
                'default_price' => 'p.sale_price',
                'category_name' => 'c.title',
                'group_name' => 'g.title',
                'grade_name' => 'gr.title',
                'quality_name' => 'q.title',
                'unit_name' => 'u.unite_name',
                'unit_symbol' => 'u.unit_symbol',
            ])->join('qc_Products', ['stp.product_id', '=', 'p.id'], 'p')
            ->left_outer_join('tbl_Brands', ['p.brand_id', '=', 'b.id'], 'b')
            ->left_outer_join('qc_ProductCategories', ['p.category_id', '=', 'c.id'], 'c')
            ->left_outer_join('qc_ProductGroups', ['p.group_id', '=', 'g.id'], 'g')
            ->left_outer_join('qc_ProductGrades', ['p.grade_id', '=', 'gr.id'], 'gr')
            ->left_outer_join('qc_ProductQualities', ['p.quality_id', '=', 'q.id'], 'q')
            ->left_outer_join('qc_Units', ['p.unit_id', '=', 'u.id'], 'u')
            ->where('stp.team_id', $teamId)
            ->order_by_asc('b.brand_persian_name')
            ->order_by_asc('p.title')
            ->find_array();

        foreach ($permissions as &$permission) {
            $permission['product_id'] = (int)$permission['product_id'];
            $permission['brand_id'] = (int)$permission['brand_id'];
            $permission['default_price'] = (int)($permission['default_price'] ?? 0);
            if ($permission['price'] === null || $permission['price'] === '') {
                $permission['price'] = null;
            } else {
                $permission['price'] = (int)$permission['price'];
            }

            $permission['category_name'] = $permission['category_name'] ?? '';
            $permission['group_name'] = $permission['group_name'] ?? '';
            $permission['grade_name'] = $permission['grade_name'] ?? '';
            $permission['quality_name'] = $permission['quality_name'] ?? '';
            $permission['unit_name'] = $permission['unit_name'] ?? '';
            $permission['unit_symbol'] = $permission['unit_symbol'] ?? '';
        }

        unset($permission);
        echo json_encode([
            'success' => true,
            'permissions' => $permissions,
        ], JSON_UNESCAPED_UNICODE);
        exit();
    }

    public function saveSalePermissions()
    {
        header('Content-Type: application/json; charset=utf-8');
        $data = $this->requestArray();
        try {
            $teamId = (int)($data['team_id'] ?? 0);
            if ($teamId <= 0) {
                echo json_encode([
                    'success' => false,
                    'message' => 'شناسه تیم نامعتبر است.'
                ], JSON_UNESCAPED_UNICODE);

                return;
            }

            $permissionsJson = $data['sale_permissions'] ?? '';
            if ($permissionsJson === '') {
                echo json_encode([
                    'success' => false,
                    'message' => 'هیچ محصولی برای ذخیره ارسال نشده است.'
                ], JSON_UNESCAPED_UNICODE);

                return;
            }

            $permissions = json_decode($permissionsJson, true);
            if (!is_array($permissions) || json_last_error() !== JSON_ERROR_NONE) {
                echo json_encode([
                    'success' => false,
                    'message' => 'اطلاعات محصولات نامعتبر است.'
                ], JSON_UNESCAPED_UNICODE);

                return;
            }

            $team = ORM::for_table('qc_SalesTeam')
                ->where('id', $teamId)
                ->find_one();

            if (!$team) {
                echo json_encode([
                    'success' => false,
                    'message' => 'تیم مورد نظر پیدا نشد.'
                ], JSON_UNESCAPED_UNICODE);

                return;
            }

            $products = [];
            foreach ($permissions as $permission) {
                if (!is_array($permission)) {
                    continue;
                }

                $productId = (int)($permission['product_id'] ?? 0);
                if ($productId <= 0) {
                    continue;
                }

                $price = null;
                if (isset($permission['price']) && $permission['price'] !== '') {
                    $price = preg_replace('/\D/', '', (string)$permission['price']);
                    if ($price !== '') {
                        $price = (int)$price;
                    } else {
                        $price = null;
                    }
                }

                $products[$productId] = [
                    'product_id' => $productId,
                    'price' => $price
                ];
            }

            $products = array_values($products);

            if (!$products) {
                ORM::for_table('qc_SalesTeamProducts')
                    ->where('team_id', $teamId)
                    ->delete_many();
                echo json_encode([
                    'success' => true,
                    'message' => 'دسترسی‌های فروش تیم با موفقیت حذف شد.'
                ], JSON_UNESCAPED_UNICODE);
                return;
            }




            $validProducts = [];

            foreach ($products as $product) {
                $productExists = ORM::for_table('qc_Products')
                    ->where('id', $product['product_id'])
                    ->where('soft_delete', 0)
                    ->find_one();

                if ($productExists) {
                    $validProducts[] = $product;
                } else {
                    ORM::for_table('qc_SalesTeamProducts')
                        ->where('team_id', $teamId)
                        ->where('product_id', $product['product_id'])
                        ->delete_many();
                }
            }

            $products = $validProducts;

            if (!$products) {
                ORM::for_table('qc_SalesTeamProducts')
                    ->where('team_id', $teamId)
                    ->delete_many();

                echo json_encode([
                    'success' => true,
                    'message' => 'هیچ محصول معتبری برای ثبت وجود نداشت؛ دسترسی‌های قبلی حذف شدند.',
                    'count' => 0
                ], JSON_UNESCAPED_UNICODE);
                return;
            }

            $productIds = [];
            foreach ($products as $product) {
                $changed = false;
                $row = ORM::for_table('qc_SalesTeamProducts')
                    ->where([
                        'team_id' => $teamId,
                        'product_id' => $product['product_id'],
                    ])
                    ->find_one();

                if ($row) {
                    if ((int)$row->product_price !== (int)$product['price']) {
                        $changed = true;
                    }
                } else {
                    $row = ORM::for_table('qc_SalesTeamProducts')->create();
                    $row->team_id = $teamId;
                    $row->product_id = $product['product_id'];
                }

                if ($changed) {
                    $history = ORM::for_table('qc_SalesTeamProductsHistory')->create();
                    $history->team_id = $row->team_id;
                    $history->product_id = $row->product_id;
                    $history->product_price = $row->product_price;
                    $history->price_percentage = $row->price_percentage;
                    $history->user_id = userObject()->userId;
                    $history->ip_address = $_SERVER['REMOTE_ADDR'];
                    $history->save();
                }

                $row->product_price = $product['price'];
                $row->save();

                $productIds[] = $row->product_id;
            }

            $teamProducts = ORM::for_table('qc_SalesTeamProducts')
                ->where('team_id', $teamId)
                ->find_many();
            foreach ($teamProducts as $teamProduct) {
                if (!in_array((int)$teamProduct->product_id, $productIds, true)) {
                    $teamProduct->delete();
                }
            }

            echo json_encode([
                'success' => true,
                'message' => 'دسترسی‌های فروش تیم با موفقیت ثبت شد.',
                'count' => count($products)
            ], JSON_UNESCAPED_UNICODE);
        } catch (Throwable $e) {
            echo json_encode([
                'success' => false,
                'message' => 'خطایی هنگام ذخیره دسترسی‌های فروش رخ داد.'
            ], JSON_UNESCAPED_UNICODE);
        }
    }


    //***** new *****//

    public function getTeamData(?int $teamId = null, bool $asArray = false): IdiormResultSet|array
    {
        $query = ORM::for_table('qc_SalesTeam')
            ->where([
                'soft_delete' => 0
            ]);

        if ($teamId) {
            $query->where_equal('id', $teamId);
        }

        if ($asArray) {
            return $query->find_array();
        }
        return $query->find_many();
    }

    //*** دریافت اطلاعات تیم یک نفر در یک یا همه ی تیم ها *** //
    public function getUserSaleTeams(?int $userId = null, ?int $teamId = null, bool $returnAdditionalData = false): array
    {
        $result = [];

        if (is_null($userId)) {
            $userId = userObject()->userId;
        }

        $getAllTeams = $this->getTeamData($teamId);

        foreach ($getAllTeams as $team) {

            $teamData = json_decode($team->team_data_json, true);

            if (empty($teamData) || !is_array($teamData)) {
                continue;
            }

            foreach ($teamData as $item) {

                if ((int)$item['userId'] !== $userId) {
                    continue;
                }

                if ($returnAdditionalData) {
                    $result[$team->id]['workGroupIds'][] = (int)$item['workGroupId'];
                    $result[$team->id]['projectTypeId'] = $team->project_type_id;
                } else {
                    $result[$team->id][] = (int)$item['workGroupId'];
                }
            }
        }

        return $result;
    }

    //*** دریافت اطلاعات زیر مجموعه تیم یک نفر در یک یا همه‌ی تیم‌ها ***//
    public function getUserSaleTeamChildren(?int $userId = null, ?int $teamId = null, bool $returnAdditionalData = false): array
    {
        $result = [];

        if (is_null($userId)) {
            $userId = userObject()->userId;
        }

        $getAllTeams = $this->getTeamData($teamId);

        foreach ($getAllTeams as $team) {

            $teamData = json_decode($team->team_data_json, true);

            if (empty($teamData) || !is_array($teamData)) {
                continue;
            }

            // ایندکس کردن نودها
            $nodesByKey = [];
            $childrenByParent = [];

            foreach ($teamData as $node) {
                $nodesByKey[$node['key']] = $node;

                if (isset($node['parent'])) {
                    $childrenByParent[$node['parent']][] = $node;
                }
            }

            // پیدا کردن نود کاربر
            $userNode = null;

            foreach ($teamData as $node) {
                if ((int)$node['userId'] === $userId) {
                    $userNode = $node;
                    break;
                }
            }

            if (!$userNode) {
                continue;
            }

            // جمع‌آوری تمام زیرمجموعه‌ها
            $collectChildren = function (int $parentKey) use (&$collectChildren, &$childrenByParent, $returnAdditionalData) {

                $output = [];

                foreach ($childrenByParent[$parentKey] ?? [] as $child) {

                    if ($returnAdditionalData) {
                        $item = $child;
                    } else {
                        $item = [
                            'userId' => (int)$child['userId'],
                            'workGroupId' => (int)$child['workGroupId'],
                        ];
                    }

                    $output[] = $item;

                    $output = array_merge(
                        $output,
                        $collectChildren((int)$child['key'])
                    );
                }

                return $output;
            };

            $result[$team->id][] = [
                'workGroupId' => (int)$userNode['workGroupId'],
                'children' => $collectChildren((int)$userNode['key']),
            ];
        }

        return $result;
    }

    // *** دریافت اطلاعات نفرات یک یا همه ی تیم بر اساس گروه کاری های فیلتر شده *** //
    public function getTeamUsersByWorkGroupIds(array $workGroupsIds, ?int $teamId = null, bool $returnAdditionalData = false): array
    {
        $result = [];

        $getAllTeams = $this->getTeamData($teamId);

        foreach ($getAllTeams as $team) {

            $teamData = json_decode($team->team_data_json, true);

            if (empty($teamData) || !is_array($teamData)) {
                continue;
            }

            // ایندکس فرزندان بر اساس parent
            $childrenByParent = [];

            foreach ($teamData as $node) {
                if (isset($node['parent'])) {
                    $childrenByParent[$node['parent']][] = $node;
                }
            }

            // جمع‌آوری تمام فرزندان
            $collectChildren = function (int $parentKey) use (&$collectChildren, &$childrenByParent, $returnAdditionalData) {

                $output = [];

                foreach ($childrenByParent[$parentKey] ?? [] as $child) {

                    if ($returnAdditionalData) {
                        $item = $child;
                    } else {
                        $item = [
                            'userId' => (int)$child['userId'],
                            'workGroupId' => (int)$child['workGroupId'],
                        ];
                    }

                    $output[] = $item;

                    if ($returnAdditionalData) {
                        $item['children'] = $collectChildren((int)$child['key']);
                    }

                    $output = array_merge(
                        $output,
                        $collectChildren((int)$child['key'])
                    );
                }

                return $output;
            };

            foreach ($teamData as $node) {

                if (!in_array((int)$node['workGroupId'], $workGroupsIds, true)) {
                    continue;
                }

                $result[$team->id][] = [
                    'workGroupId' => (int)$node['workGroupId'],
                    'userId' => (int)$node['userId'],
                    'children' => $collectChildren((int)$node['key'])
                ];
            }
        }

        return $result;
    }
}