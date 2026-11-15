<?php

namespace App\Controllers\ImplementationTeam;

use App\Controllers\scheme\ControllerScheme;
use App\Models\ImplementationTeamModel\ImplementationTeamModel;
use App\Models\ImplementationTeamModifyLogModel\ImplementationTeamModifyLogModel;
use App\Models\MenuListModel\MenuListModel;
use App\Models\ProjectsModel\ProjectsModel;
use App\Models\ProjectsTypeModel\ProjectsTypeModel;
use App\Models\StructureTypeModel\StructureTypeModel;
use App\Models\usersModel\usersModel;
use App\Models\WorkGroupsModel\WorkGroupsModel;

class ImplementationTeam extends ControllerScheme
{
    const string singleName = 'تیم ';
    const string pluralName = 'تیم  ';

    protected string $defaultModel = ImplementationTeamModel::class;

    public function main()
    {
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
//            'js/ImplementationTeam/ImplementationTeam'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                'list' => ImplementationTeamModel::all()
            ])->display('ImplementationTeam/ImplementationTeam.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/charts/valadart/go',
            'vendors/js/charts/valadart/data',
            'vendors/js/charts/valadart/lookup',
            'vendors/js/charts/valadart/model-helpers',
            'vendors/js/charts/valadart/editing',
            'vendors/js/charts/valadart/context-menu',
            'vendors/js/charts/valadart/node-template',
            'vendors/js/charts/valadart/dragging-tool',
            'vendors/js/charts/valadart/diagram-init',
            'vendors/js/charts/valadart/app',
//            'vendors/js/goJs/go',
//            'vendors/js/goJs/DataInspector',
//            'vendors/js/goJs/DataInspector',
            'js/ImplementationTeam/add-ImplementationTeam',
        ], [
            'vendors/css/charts/valadart/style'
        ],
            [
                'projectsType' => ProjectsTypeModel::all()
            ]
        )->display('ImplementationTeam/add-ImplementationTeam.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel(ImplementationTeamModel::query()->find($id));
        view->ui([
            'js/ImplementationTeam/edit-ImplementationTeam',
            'vendors/js/charts/valadart/go',
            'vendors/js/charts/valadart/data',
            'vendors/js/charts/valadart/lookup',
            'vendors/js/charts/valadart/model-helpers',
            'vendors/js/charts/valadart/editing',
            'vendors/js/charts/valadart/context-menu',
            'vendors/js/charts/valadart/node-template',
            'vendors/js/charts/valadart/dragging-tool',
            'vendors/js/charts/valadart/diagram-init',
            'vendors/js/charts/valadart/app',
        ], [
            'vendors/css/charts/valadart/style'
        ], [

        ])->display('ImplementationTeam/edit-ImplementationTeam.tpl');
    }


    public function add()
    {
        csrf->csrfValidate();

        $data = $this->requestArray();

        $needle = [
            'team_title',
            'jsonOutput',
        ];

        if (validator->validateRequestsData($needle)) {


            $add = ImplementationTeamModel::query()
                ->create([
                    'team_title' => $data['team_title'],
                    'team_data_json' => json_encode(json_decode($data['jsonOutput'], true)['nodeDataArray'], JSON_UNESCAPED_UNICODE),
                    'nodes_data_json' => $data['jsonOutput'],
                    'user_id' => userObject()->userId
                ]);

            if ($add) {
                $this->successCallBack('/ImplementationTeam/main', 'تیم با موفقیت اضافه شد');
            }
        } else {
            $this->failedCallBack('/ImplementationTeam/new', "تیم برای نوع پروژه انتخابی ثبت شده است");

            header('location:/notAccess');
        }
    }

    public function edit($id)
    {
        csrf->csrfValidate();
        $getData = ImplementationTeamModel::query()->find($id);

        if ($getData) {
            $needle = [
                'team_title',
                'jsonOutput',
            ];

            $data = $this->requestArray();
            if (validator->validateRequestsData($needle)) {
                $addLog = ImplementationTeamModifyLogModel::query()->create([
                    "team_id" => $getData->id,
                    "team_title" => $getData->team_title,
                    "team_data_json" => $getData->team_data_json,
                    "nodes_data_json" => $getData->nodes_data_json,
                    "user_id" => userObject()->userId,
                ]);
                if ($addLog) {
                    $getData->update([
                        'team_title' => $data['team_title'],
                        'team_data_json' => json_encode(json_decode($data['jsonOutput'], true)['nodeDataArray'], JSON_UNESCAPED_UNICODE),
                        'nodes_data_json' => $data['jsonOutput']
                    ]);
                    if ($getData->save()) {
                        $this->successCallBack('/ImplementationTeam/main', 'تیم با موفقیت ویرایش شد');
                    }
                }
            } else {
                header('location:/notAccess');
            }
        } else {
            header('location:/notAccess');
        }

    }

    public function loopUsers($nodes, $parentId = null)
    {
        $output = [];
        foreach ($nodes as $node) {
            $output[$parentId ?? 'ROOT'][] = [
                'userId' => $node['userId'],
                'workGroupId' => $node['workGroupId'],
            ];
            if (!empty($node['children'])) {
                $childOutput = self::loopUsers($node['children'], $node['userId']);
                $output = array_merge_recursive($output, $childOutput);
            }
        }
        return $output;
    }


    private function getTeamData(?int $teamId = null): \Illuminate\Database\Eloquent\Collection|array
    {
        return ImplementationTeamModel::query()
            ->when($teamId, fn($q) => $q->where('id', $teamId))
            ->whereNull('deleted_at')
            ->get();
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
                } else {
                    $result[$team->id][] = (int)$item['workGroupId'];
                }
            }
        }

        return $result;
    }

    //*** دریافت اطلاعات زیر مجموعه تیم یک نفر در یک یا همه‌ی تیم‌ها ***//
    public function getUserSaleTeamChildren(int $userId, ?int $teamId = null, bool $returnAdditionalData = false): array
    {
        $result = [];

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

    //saman
    public function getTeamUsersAndWorkGroup(array $teamDecodeArray)
    {
        $result = [];
        foreach ($teamDecodeArray as $item) {
            if (isset($item['userId']) && isset($item['workGroupId'])) {
                $result[$item['workGroupId']][] = $item['userId'];
            }
            if (!empty($item['children'])) {
                $childResult = self::getTeamUsersAndWorkGroup($item['children']);
                foreach ($childResult as $workGroup => $users) {
                    if (!isset($result[$workGroup])) {
                        $result[$workGroup] = [];
                    }
                    $result[$workGroup] = array_merge($result[$workGroup], $users);
                }
            }
        }
        return $result;
    }

    // *** دریافت اطلاعات کارشناسان فروش *** //
    public function getExpertUsersByTeam(array $workGroupIds = [4, 6], ?int $teamId = null, bool $breakdownByTeam = true, bool $returnAssociativeData = true): array
    {
        $output = [];
        $get = $this->getTeamUsersByWorkGroupIds($workGroupIds, $teamId);

        foreach ($get as $teamId => $data) {
            foreach ($data as $datum) {
                if ($breakdownByTeam) {
                    if ($returnAssociativeData) {
                        $output[$teamId]['teamTitle'] = ImplementationTeamModel::query()->find($teamId)->team_title;
                        $output[$teamId]['users'][$datum['userId']] = [
                            'userId' => $datum['userId'],
                            'userFullName' => userHelper->getUserFullName($datum['userId'], 'نامشخص')
                        ];
                    } else {
                        $output[$teamId][$datum['userId']] = $datum['userId'];
                    }
                } else {
                    $output[$datum['userId']] = $datum['userId'];
                }
            }
        }

        return $output;

    }

    public function managerWorkGroupData(): array
    {
        return [
            'workGroupIds' => [1],
            'permissionIds' => [1]
        ];
    }

    public function supervisorWorkGroupData(): array
    {
        return [
            'workGroupIds' => [4],
            'permissionIds' => [2]
        ];
    }

    public function getTreeData()
    {
        $teamId = $this->requestArray()['teamId'];
        $json = ImplementationTeamModel::query()->find($teamId)->team_date_json;
        echo $json;
    }

    public function delete($id)
    {

    }
}
