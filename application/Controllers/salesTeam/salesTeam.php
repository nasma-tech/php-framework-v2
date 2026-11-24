<?php

namespace App\Controllers\salesTeam;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\ProductModel\ProductModel;
use App\Models\salesTeamMemberSettingModel\salesTeamMemberSettingModel;
use App\Models\SalesTeamModel\SalesTeamModel;
use App\Models\salesTeamModifyLogModel\salesTeamModifyLogModel;
use App\Models\SalesTeamProductsHistoryModel\SalesTeamProductsHistoryModel;
use App\Models\SalesTeamProductsModel\SalesTeamProductsModel;
use App\Models\salesTeamGroupModel\salesTeamGroupModel;
use App\Models\saleTeamGRoupSalesTeamModel\saleTeamGroupSalesTeamModel;
use App\Models\UserModel\UserModel;
use Packages\Security\Csrf;

require_once __SOURCE__ . 'application/Controllers/scheme/ControllerScheme.php';

class salesTeam extends ControllerScheme
{
    const string singleName = 'گروه تیم فروش';
    const string pluralName = 'گروه تیم فروش';
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
            'js/salesTeam/salesTeamGroup',
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
//                'list' => SalesTeamModel::query()->get(),
                'list' => salesTeamGroupModel::query()->get(),
            ])->display('salesTeam/salesTeam.tpl');
    }

    public function addTeamIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            '/vendors/js/charts/valadart/go',
            '/vendors/js/charts/valadart/data',
            '/vendors/js/charts/valadart/lookup',
            '/vendors/js/charts/valadart/model-helpers',
            '/vendors/js/charts/valadart/editing',
            '/vendors/js/charts/valadart/context-menu',
            '/vendors/js/charts/valadart/node-template',
            '/vendors/js/charts/valadart/dragging-tool',
            '/vendors/js/charts/valadart/diagram-init',
            '/vendors/js/charts/valadart/app',
            '//js/salesTeam/add-salesTeam',
        ], [
            '/vendors/css/charts/valadart/style'
        ], [
            'groupId' => $id,
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
            '/vendors/js/charts/valadart/go',
            '/vendors/js/charts/valadart/data',
            '/vendors/js/charts/valadart/lookup',
            '/vendors/js/charts/valadart/model-helpers',
            '/vendors/js/charts/valadart/editing',
            '/vendors/js/charts/valadart/context-menu',
            '/vendors/js/charts/valadart/node-template',
            '/vendors/js/charts/valadart/dragging-tool',
            '/vendors/js/charts/valadart/diagram-init',
            '/vendors/js/charts/valadart/app',
            '/js/salesTeam/add-salesTeam',
        ], [
            '/vendors/css/charts/valadart/style'
        ], [
            'Brands' => brandsModel::query()->get(),
        ])->display('salesTeam/edit-salesTeam.tpl');
    }

    public function viewIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(SalesTeamModel::query()->find($id));
        view->ui([
            '/vendors/js/charts/valadart/go',
            '/vendors/js/charts/valadart/data',
            '/vendors/js/charts/valadart/lookup',
            '/vendors/js/charts/valadart/model-helpers',
            '/vendors/js/charts/valadart/editing',
            '/vendors/js/charts/valadart/context-menu',
            '/vendors/js/charts/valadart/node-template',
            '/vendors/js/charts/valadart/dragging-tool',
            '/vendors/js/charts/valadart/diagram-init',
            '/vendors/js/charts/valadart/app',
        ], [
            '/vendors/css/charts/valadart/style'
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
            'js/salesTeam/permission-salesTeam',
        ], ["css/salesTeam/sale-permissions"], [
            'brands' => BrandsModel::query()->get(),
        ])->display('salesTeam/permission-salesTeam.tpl');
    }

    public function addGroupIndex()
    {

        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            '/vendors/js/charts/valadart/go',
            '/vendors/js/charts/valadart/data',
            '/vendors/js/charts/valadart/lookup',
            '/vendors/js/charts/valadart/model-helpers',
            '/vendors/js/charts/valadart/editing',
            '/vendors/js/charts/valadart/context-menu',
            '/vendors/js/charts/valadart/node-template',
            '/vendors/js/charts/valadart/dragging-tool',
            '/vendors/js/charts/valadart/diagram-init',
            '/vendors/js/charts/valadart/app',
        ], [
            '/vendors/css/charts/valadart/style'
        ], [
            'Brands' => brandsModel::query()->get(),
        ])->display('salesTeam/add-groupSaleTeam.tpl');
    }

    public function editGroupIndex($id)
    {

        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(salesTeamGroupModel::query()->find($id));
        view->ui([
            '/vendors/js/charts/valadart/go',
            '/vendors/js/charts/valadart/data',
            '/vendors/js/charts/valadart/lookup',
            '/vendors/js/charts/valadart/model-helpers',
            '/vendors/js/charts/valadart/editing',
            '/vendors/js/charts/valadart/context-menu',
            '/vendors/js/charts/valadart/node-template',
            '/vendors/js/charts/valadart/dragging-tool',
            '/vendors/js/charts/valadart/diagram-init',
            '/vendors/js/charts/valadart/app',
        ], [
            '/vendors/css/charts/valadart/style'
        ], [
            'Brands' => brandsModel::query()->get(),
        ])->display('salesTeam/edit-groupSaleTeam.tpl');
    }

    public function addTeam()
    {
        csrf->csrfValidate();
        $data = $this->requestArray();


        $needle = [
            'team_title',
            'team_data_json',
        ];

        if ($this->validateRequestsData($needle)) {

            $newNodes = json_decode($data['team_data_json'], true)['nodeDataArray'] ?? [];

            $add = SalesTeamModel::query()->create([
                'team_title' => $data['team_title'],
                'team_data_json' => json_encode($newNodes, JSON_UNESCAPED_UNICODE),
                'nodes_data_json' => $data['team_data_json'],
                'user_id' => userObject()->userId,
            ]);

            if ($add->save()) {
                $addToGroup = saleTeamGroupSalesTeamModel::query()->insert([
                    'salesTeam_id' => $add->id,
                    'SalesTeamGroup_id' => $data['groupId'],
                    'user_id' => userObject()->userId,
                ]);
                if ($addToGroup) {
                    return $this->successCallBack('/salesTeam/main');
                }
            } else {
                header('location:/notAccess');
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
        $brands = brandsModel::query()->get();
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

        $products = ProductModel::with([
            'brand',
            'productGroup.category',
            'grade',
            'quality',
            'measurementUnit',
        ])
            ->where('brand_id', $brandId)
            ->when($search !== '', function ($query) use ($search) {
                $query->where(function ($q) use ($search) {
                    $q->where('label', 'LIKE', "%{$search}%")
                        ->orWhere('serial_number', 'LIKE', "%{$search}%");
                });
            })
            ->orderBy('label')
            ->paginate($limit, ['*'], 'page', $page);

        $total = $products->total();

        $result = $products->getCollection()->map(function ($product) {
            return [
                'id' => (int)$product->id,
                'brand_id' => (int)$product->brand_id,
                'product_code' => $product->serial_number,
                'name' => $product->label,
                'default_price' => (int)($product->sale_price ?? 0),
                'category_name' => $product->productGroup?->category?->label ?? '',
                'group_name' => $product->productGroup?->label ?? '',
                'grade_name' => $product->grade?->label ?? '',
                'quality_name' => $product->quality?->label ?? '',
                'unit_name' => $product->measurementUnit?->label ?? '',
                'unit_symbol' => $product->measurementUnit?->unit_symbol ?? '',
            ];
        })->values();

        echo json_encode([
            'success' => true,
            'products' => $result,
            'pagination' => [
                'page' => $page,
                'limit' => $limit,
                'total' => $total,
                'has_more' => $products->hasMorePages(),
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

        $permissions = SalesTeamProductsModel::with([
            'product.brand',
            'product.productGroup.category',
            'product.grade',
            'product.quality',
            'product.measurementUnit',
        ])
            ->where('team_id', $teamId)
            ->get();

        $permissions = $permissions->sort(function ($a, $b) {
            $brandA = $a->product?->brand?->brand_persian_name ?? '';
            $brandB = $b->product?->brand?->brand_persian_name ?? '';

            $brandCompare = strcasecmp($brandA, $brandB);

            if ($brandCompare !== 0) {
                return $brandCompare;
            }

            $nameA = $a->product?->label ?? '';
            $nameB = $b->product?->label ?? '';

            return strcasecmp($nameA, $nameB);
        });

        $permissions = $permissions->map(function ($item) {
            $product = $item->product;

            return [
                'product_id' => (int)$item->product_id,
                'price' => ($item->product_price === null || $item->product_price === '')
                    ? null
                    : (int)$item->product_price,
                'brand_id' => (int)($product?->brand_id ?? 0),
                'brand_name' => $product?->brand?->brand_persian_name ?? '',
                'name' => $product?->label ?? '',
                'code' => $product?->serial_number ?? '',
                'default_price' => (int)($product?->sale_price ?? 0),
                'category_name' => $product?->productGroup?->category?->label ?? '',
                'group_name' => $product?->productGroup?->label ?? '',
                'grade_name' => $product?->grade?->label ?? '',
                'quality_name' => $product?->quality?->label ?? '',
                'unit_name' => $product?->measurementUnit?->label ?? '',
                'unit_symbol' => $product?->measurementUnit?->unit_symbol ?? '',
            ];
        })->values()->toArray();

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
            $team = SalesTeamModel::query()->find($teamId);


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
                SalesTeamProductsModel::query()->where('team_id', $teamId)->delete();
                echo json_encode([
                    'success' => true,
                    'message' => 'دسترسی‌های فروش تیم با موفقیت حذف شد.'
                ], JSON_UNESCAPED_UNICODE);
                return;
            }


            $validProducts = [];

            foreach ($products as $product) {
                $productExists = ProductModel::query()->find($product['product_id']);

                if ($productExists) {
                    $validProducts[] = $product;
                } else {
                    salesTeamProductsModel::query()->where([
                        'team_id' => $teamId,
                        'product_id' => $product['product_id'],
                    ])->delete();
                }
            }

            $products = $validProducts;

            if (!$products) {
                salesteamProductsModel::query()->where('team_id', $teamId)->delete();


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
                $row = salesteamProductsModel::query()->where([
                    'team_id' => $teamId,
                    'product_id' => $product['product_id'],
                ])->first();

                if ($row) {
                    if ((int)$row->product_price !== (int)$product['price']) {
                        $changed = true;
                    }
                } else {
                    $row = salesteamProductsModel::query()->create([]);
                    $row->team_id = $teamId;
                    $row->product_id = $product['product_id'];
                }

                if ($changed) {
                    $history = SalesTeamProductsHistoryModel::query()->create([]);
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
            $teamProducts = SalesTeamProductsModel::query()->where('team_id', $teamId)->get();

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

    public function getTeamData(?int $teamId = null, bool $asArray = false)
    {
        $query = salesTeamProductsModel::query();

        if ($teamId) {
            $query->where('id', $teamId);
        }

        if ($asArray) {
            return $query->get()->toArray();
        }

        return $query->get();
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

    public function addGroup()
    {
        $data = $this->requestArray();
        $add = salesTeamGroupModel::query()->create([
            'label' => $data['label'],
            'user_id' => userObject()->userId,
        ]);
        if ($add) {
            $this->successCallBack('/salesTeam/main');
        } else {
            $this->failedCallBack('/salesTeam/main');
        }
    }

    public function getGroupData($id)
    {
        $data = saleTeamGroupSalesTeamModel::query()->where('SalesTeamGroup_id', $id)->with(['user', 'salesTeam', 'salesTeamGroup'])->get();
        echo json_encode($data);
    }

    public function deleteSalesTeam()
    {
        $data = $this->requestArray();
        $delete = saleTeamGroupSalesTeamModel::query()->where(['SalesTeamGroup_id' => $data['group_id'], 'salesTeam_id' => $data['team_id']])->delete();
        $deleteTeam = SalesTeamModel::query()->where('id', $data['team_id'])->delete();
        if ($delete && $deleteTeam) {
            echo "deleteSucess";
        } else {
            echo "deleteFailed";
        }
    }

    public function checkGroupTeam($id)
    {
        $data = saleTeamGroupSalesTeamModel::query()
            ->where('SalesTeamGroup_id', $id)
            ->with(['salesTeam'])
            ->get();

        if ($data->isNotEmpty()) {
            echo json_encode([
                'message' => 'withData',
                'data' => $data
            ]);
        } else {
            echo json_encode([
                'message' => 'withoutData',
                'data' => []
            ]);
        }
    }

    public function deleteGroup($id)
    {
        $check = saleTeamGroupSalesTeamModel::query()->where('SalesTeamGroup_id', $id)->get();
        if (!$check) {
            var_print('data');
            die();
            $delete = salesTeamGroupModel::query()->where('id', $id)->delete();
            if ($delete) {
                echo "deleteSucess";
            } else {
                echo "deleteFailed";
            }
        } else {

            $deleteGroup = salesTeamGroupModel::query()->where('id', $id)->delete();
            $emptyGroup = saleTeamGroupSalesTeamModel::query()
                ->where('SalesTeamGroup_id', $id)
                ->delete();

            if (!$emptyGroup && !$deleteGroup) {
                echo "deleteSucess";
            } else {
                echo "deleteFailed";

            }
        }
    }

    public function editGroup($id)
    {
        $data = $this->requestArray();
        $edit = salesTeamGroupModel::query()->where('id', $id)->first();
        $modifyLog = json_decode($edit['modifyLog']) ?? [];

        $modifyLog[] = [
            "label" => $edit['label'],
            "userId" => userObject()->userId,
            "date" => date("Y-m-d H:i:s"),
            "timestamp" => time(),
        ];
        $edit->update([
            'label' => $data['label'],
            'modifyLog' => json_encode($modifyLog),
        ]);
        if ($edit) {
            $this->successCallBack('/salesTeam/main');
        } else {
            $this->failedCallBack('/salesTeam/main');
        }
    }

    public function teamSetting($id)
    {
        $team = salesTeamModel::query()->find($id);
        $jsonData = json_decode($team->team_data_json, true);
        $users = array_column($jsonData ?? [], 'userId');
        $users = UserModel::query()->whereIn('id', $users)->get()->toArray();
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel(salesTeamMemberSettingModel::query()->where('sales_team_id', $id)->get());
        view->ui([
            'js/salesTeam/saleaTeamSetting',
        ], ["css/salesTeam/sale-permissions"], [
            'salesTeamId' => $id,
            'Users' => $users,
        ])->display('salesTeam/saleaTeamSetting.tpl');
    }

    public function addSalesTeamSetting($id)
    {
        $data = $this->requestArray();

        foreach ($data as $key => $value) {
            $check = salesTeamMemberSettingModel::query()
                ->where('sales_team_id', $id)
                ->where('member_id', $key)
                ->first();

            $makeData = [
                "member_id" => $key,
                "sales_team_id" => $id,
                "overPrice" => $value['overPrice'] ?? false,
                "underPrice" => $value['underPrice'] ?? false,
                "discountPercent" => $value['discountPercent'] ?? false,
                "sellClose" => $value['sellClose'] ?? false,
                "user_id" => userObject()->userId,
            ];

            if ($check) {
                $modifyLog = [
                    "member_id" => $check->member_id,
                    "sales_team_id" => $check->sales_team_id,
                    "overPrice" => $check->overPrice,
                    "underPrice" => $check->underPrice,
                    "discountPercent" => $check->discountPercent,
                    "sellClose" => $check->sellClose,
                    "user_id" => $check->user_id,
                ];

                $oldLogs = json_decode($check->modifyLog, true) ?? [];
                array_unshift($oldLogs, $modifyLog);

                $makeData['modifyLog'] = json_encode($oldLogs, JSON_UNESCAPED_UNICODE);

                $check->update($makeData);
            } else {
                $makeData['modifyLog'] = "[]";

                salesTeamMemberSettingModel::query()->create($makeData);
            }
        }

        $this->successCallBack('/salesTeam/main');
    }
}