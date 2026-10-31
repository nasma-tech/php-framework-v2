<?php

namespace Packages\Cartable;

use App\core\Service\ActionType;
use App\core\Service\ProcessType;
use App\core\Service\ServiceSchema;
use App\Models\CartableDefinitionModel\CartableDefinitionModel;
use App\Models\UserModel\UserModel;
use Exception;

class Cartable
{
    public mixed $tableName;
    public mixed $requestId;

    public readonly ServiceSchema $service;
    public Illuminate\Database\Eloquent\Model $dataModel;

    /**
     * @throws Exception
     */
    public function __construct(
        Illuminate\Database\Eloquent\Model $dataModel,
        ?int                               $requestId = null
    )
    {
        $this->setDataModel($dataModel);

        if (!is_null($requestId)) {
            $this->setRequestId($requestId);
            if (!is_null($this->getData()->cartable_definition_id)) {
                $getCartableDefinition = CartableDefinitionModel::query()->find($this->getData()->cartable_definition_id);

                if ($getCartableDefinition) {
                    if ($getCartableDefinition->service_address) {
                        $this->service = new $getCartableDefinition->service_address($this->getData());
                    } else {
                        throw new Exception('service_address is empty');
                    }
                } else {
                    throw new Exception('cartable definition not found');
                }
            }
        }
    }

    /**
     * @throws Exception
     */
    public function setDataModel($dataModel): void
    {
        $this->dataModel = $dataModel;
        $fillable = $dataModel->getFillable();
        $FieldsRequired = [
            'cartable_definition_id', //int آی دی تعریف کارتابل بر اساس tbl_CartableDefinition
            'schema_work_group', //نمونه گردش کارتابل که گردش کارتابل از این قسمت تبعیت میکند : json
            'cartable_circulation', //گردش کارتابل : json
            'process_status',// null: ارسال نشده0: فرآیند در گردش1:اتمام فرآیند2: لغو شده3: برگشت از کارتابل : tinyint(1)
            'process_log',//json : لاگ تغییرات کارتابل
            'change_schema_log'//لاگ تغییرات نمونه گردش کارتابل، ذخیره گردش قبلی به همراه نمونه آن json
        ];
        $difference = array_diff($FieldsRequired, $fillable);

        if ($difference) {
            throw new Exception(
                "required filed not valid in " . $dataModel->getTable()
            );
        }
    }

    public function getDataModel(): Illuminate\Database\Eloquent\Model
    {
        return $this->dataModel;
    }

    /**
     * @param mixed $tableName
     */
    public function setTableName(mixed $tableName): void
    {
        $this->tableName = $tableName;
    }

    /**
     * @return mixed
     */
    public function getTableName(): mixed
    {
        return $this->tableName;
    }


    /**
     * @param mixed $requestId
     */
    public function setRequestId(int $requestId): void
    {
        $this->requestId = $requestId;
    }

    /**
     * @return mixed
     */
    public
    function getRequestId(): mixed
    {
        return $this->requestId;
    } //fixed

    public
    function cartableSchemeAndWorkGroup(array $schemeWorkGroup, string $description = '') //fixed
    {
        $getData = $this->getData();
        $getFirst = current($schemeWorkGroup);

        if ($getData->cartable_circulation) {
            $make = json_decode($getData->cartable_circulation, true);

            foreach ($make['cartable'] as &$item) {
                if (isset($item[$getFirst['user_permission_id']])) {
                    $item[$getFirst['user_permission_id']]['confirmation'][] = [
                        'user' => userObject()->userId,
                        'confirm' => 0,
                        'dateTime' => time(),
                        'description' => $description
                    ];
                }
            }
        } else {
            $make = [];
            $make['public']['attachment'] = [];
            $make['public']['comment'] = [];
            $getFirst['confirmation'][] = [
                'user' => userObject()->userId,
                'confirm' => 0,
                'dateTime' => time(),
                'description' => $description
            ];
            $make['cartable'][][$getFirst['user_permission_id']] = $getFirst;
        }
        return $make;
    }

    public
    function getCartableByUser(int|null $userId = null): array
    {
        if (is_null($userId)) {
            $userId = userObject()->userId;
        }
        $Request = $this->getDataModel()
            ->whereIn("process_status", [0, 3])
            ->get();
        $makeData = [];
        foreach ($Request as $row) {
            $decode = json_decode($row->cartable_circulation, true);
            if (isset($decode['cartable'])) {
                foreach ($decode['cartable'] as $item) {
                    if (isset($item[$userId])) {
                        $getConfirmation = $item[$userId]['confirmation'];
                        $lastConfirm = end($getConfirmation);
                        if ($lastConfirm['confirm'] == 0 || $lastConfirm['confirm'] == 3) {
                            $makeData[$row->id]['dataCartable'] = [
                                'requestId' => $row->id,
                                'userRequestId' => $row->user_id,
                                'userRequestName' => userHelper->getUserFullName($row->user_id),
                                'userSenderId' => $lastConfirm['user'],
                                'userSenderName' => userHelper->getUserFullName($lastConfirm['user']),
                                'dateSend' => jdate("Y/m/d", $lastConfirm['dateTime']),
                                'timeSend' => jdate("H:i", $lastConfirm['dateTime']),
                                'statusCode' => $lastConfirm['confirm'],
                                'statusName' => (function () use ($lastConfirm) {
                                    return match ($lastConfirm['confirm']) {
                                        1 => 'تایید شده',
                                        2 => 'عدم تایید',
                                        3 => 'بررسی مجدد',
                                        0 => 'در انتظار تایید',
                                        default => 'ناشناخته',
                                    };
                                })(),
                                'requestData' => $row->toArray(),
                                'description' => $lastConfirm['description']
                            ];
                            $makeData[$row->id]['publicCartableData'] = $decode['public'];
                        }
                    }
                }
            }
        }
        return $makeData;
    } //fixed

    private
    function sampleCartable($statusConfirm, $description = '', int $extraTime = 0): array //fixed
    {
        return [
            'user' => userObject()->userId,
            'confirm' => $statusConfirm,
            'dateTime' => time() + $extraTime,
            'description' => $description
        ];
    }

    public
    function confirmCartable($description = '', int|null $userId = null)
    {
        $request = $this->getData();
        $currentUser = ((is_null($userId) ? userObject()->userId : $userId));

        $getCartable = (($request->cartable_circulation) ? json_decode($request->cartable_circulation, true) : []);
        $workGroupSchema = json_decode($request->schema_work_group, true);
        foreach ($getCartable['cartable'] as $key => $item) {
            if (isset($item[$currentUser])) {
                $getCartable['cartable'][$key][$currentUser]['confirmation'][] = $this->sampleCartable(1, $description);
                foreach ($workGroupSchema as $step => $schemaItem) {
                    if ($schemaItem['user_permission_id'] == $currentUser) {
                        if (isset($workGroupSchema[$step + 1])) {
                            $getCartable['cartable'][] = $this->insertToCartable($workGroupSchema[$step + 1], 0, $description, 1);
                        } else {
                            $request->update([
                                "process_status" => 1
                            ]);
                            $this->service->cartableProcessAction(ProcessType::Finish);
                        }
                    }
                }
            }
        }
        $update = $request->update([
            "cartable_circulation" => json_encode($getCartable, JSON_UNESCAPED_UNICODE)
        ]);
        $this->service->userAction($currentUser, ActionType::Approve);
        return $update;
    } //fixed

    /**
     * @throws Exception
     */
    public
    function unConfirmCartable($description = '', int|null $userId = null) //fixed
    {
        $request = $this->getData();

        $currentUser = ((is_null($userId) ? userObject()->userId : $userId));
        $getCartable = json_decode($request->cartable_circulation, true);
        $workGroupSchema = json_decode($request->schema_work_group, true);

        if (!isset($getCartable['cartable'])) {
            throw new Exception("schema is not valid");
        }

        foreach ($getCartable['cartable'] as $stepKey => &$cartableItem) {
            if (isset($cartableItem[$currentUser])) {
                $cartableItem[$currentUser]['confirmation'][] = $this->sampleCartable(2, $description);
                foreach ($workGroupSchema as $schemaIndex => $schemaItem) {
                    if ($schemaItem['user_permission_id'] == $currentUser) {
                        if (isset($workGroupSchema[$schemaIndex - 1])) {
                            $previousUserId = $workGroupSchema[$schemaIndex - 1]['user_permission_id'];
                            if (isset($getCartable['cartable'][$stepKey - 1][$previousUserId])) {
                                $getCartable['cartable'][$stepKey - 1][$previousUserId]['confirmation'][] = $this->sampleCartable(3, $description, 1);
                                $this->service->userAction($previousUserId, ActionType::Resend);
                            }
                        } else {
                            $request->update(['process_status' => 2]);
                            $this->service->cartableProcessAction(ProcessType::Cancel);
                        }
                        break 2;
                    }
                }
            }
        }

        $this->service->userAction($currentUser, ActionType::Reject);

        return $request->update([
            "cartable_circulation" => json_encode($getCartable, JSON_UNESCAPED_UNICODE)
        ]);
    }

    /**
     * @throws Exception
     */
    public
    function reConfirmCartable($description = '', int|null $userId = null)
    {
        $request = $this->getData();

        $currentUser = is_null($userId)
            ? userObject()->userId
            : $userId;

        $getCartable = json_decode(
            $request->cartable_circulation,
            true
        );

        if (!isset($getCartable['cartable'])) {
            throw new Exception('schema is not valid');
        }

        foreach ($getCartable['cartable'] as $key => &$cartableItem) {

            if (isset($cartableItem[$currentUser])) {

                $cartableItem[$currentUser]['confirmation'][] =
                    $this->sampleCartable(3, $description);

                break;
            }
        }

        $this->service->userAction(
            $currentUser,
            ActionType::Resend
        );

        return $request->update([
            'cartable_circulation' =>
                json_encode($getCartable, JSON_UNESCAPED_UNICODE)
        ]);
    }

    public
    function insertToCartable(array $schemeWorkGroup, $status = 0, string $description = '', int $extraTime = 0): array
    {
        $make = [];
        $getFirst = $schemeWorkGroup;
        $getFirst['confirmation'][] = [
            'user' => userObject()->userId,
            'confirm' => $status,
            'dateTime' => time() + $extraTime,
            'description' => $description
        ];
        $make[$getFirst['user_permission_id']] = $getFirst;
        return $make;
    }

    /**
     * @throws Exception
     */
    public
    function attachSchemaToCartable(int $cartableTypeId, array $variables = [])
    {
        $getData = $this->getData();
        $getCartableData = \App\Models\CartableDefinitionModel\CartableDefinitionModel::query()->find($cartableTypeId);

        if ($getCartableData) {
            $decode = json_decode($getCartableData->cartable_schema, true);

            foreach ($decode as &$item) {
                if (isset($variables[$item['permission_id']])) {
                    $item['user_permission_id'] = $variables[$item['permission_id']];
                }
            }

            return $getData->update([
                "schema_work_group" => json_encode($decode, JSON_UNESCAPED_UNICODE),
                'cartable_definition_id' => $getCartableData->id
            ]);
        } else {
            throw new Exception("invalid parameter");
        }
    }

    /**
     * @throws Exception
     */
    public
    function submitCartable(string $description = "بررسی کارتابل")
    {
        $getData = $this->getData();

        if (!in_array($getData->process_status, [null, 1, 2])) {
            throw new Exception("request already sent");
        }

        $decode = json_decode($getData->process_log, true);

        $processStatus = 0;
        switch ($getData->process_status) {
            case null:
                $decode[] = [
                    'datetime' => time(),
                    'userId' => userObject()->userId,
                    'status' => "submitCartable",
                    'description' => $description
                ];
                break;

            case 1:
                $decode[] = [
                    'datetime' => time(),
                    'userId' => userObject()->userId,
                    'status' => "returnCartable",
                    'description' => $description
                ];
                break;

            case 2:
                $processStatus = 3;
                $decode[] = [
                    'datetime' => time(),
                    'userId' => userObject()->userId,
                    'status' => "reSendCartable",
                    'description' => $description
                ];
                break;
        }

        $update = $getData->update([
            "cartable_circulation" => json_encode($this->cartableSchemeAndWorkGroup(json_decode($getData->schema_work_group, true), $description), JSON_UNESCAPED_UNICODE),
            "process_log" => json_encode($decode, JSON_UNESCAPED_UNICODE),
            "process_status" => $processStatus
        ]);

        if ($processStatus == 3) {
            $this->service->cartableProcessAction(ProcessType::Resend);
        }

        return $update;
    }

    public
    function getCartableCirculationLog(): array
    {
        $getData = $this->getData();
        $output = [
            'circle' => []
        ];

        if ($getData->cartable_circulation) {
            $decode = json_decode($getData->cartable_circulation, true);
            $decodeProcessLog = json_decode($getData->process_log, true);

            if ($decode && isset($decode['cartable'])) {
                foreach ($decode['cartable'] as $items) {
                    foreach ($items as $userId => $item) {
                        foreach (($item['confirmation'] ?? []) as $confirmationItem) {
                            $output['circle'][$confirmationItem['dateTime']][] = [
                                'userId' => $userId,
                                'isProcessLog' => false,
                                'defaultLabel' => '',
                                'confirmation' => $confirmationItem['confirm'],
                                'description' => $confirmationItem['description'],
                            ];
                        }
                    }
                }
            }

            foreach ($decodeProcessLog as $decodeProcessLogItem) {
                $output['circle'][$decodeProcessLogItem['datetime']][] = [
                    'userId' => $decodeProcessLogItem['userId'],
                    'isProcessLog' => true,
                    'defaultLabel' => match ($decodeProcessLogItem['status']) {
                        "submitCartable" => "ارسال کارتابل",
                        "returnCartable", "reSendCartable" => "برگشت کارتابل",
                        default => "نامشخص"
                    },
                    'confirmation' => 1,
                    'description' => $decodeProcessLogItem['description'] ?? 'نامشخص'
                ];
            }

        }

        if ($output['circle']) {
            krsort($output['circle']);
            $output['lastLog'] = $this->getLastStatusOfCirculationLog();
        }

        return $output;
    }

    public
    function getLastStatusOfCirculationLog()
    {
        $getData = $this->getData();

        if ($getData->schema_work_group) {
            $decodeSchema = json_decode($getData->schema_work_group, true);
            $decodeCirculation = json_decode($getData->cartable_circulation, true);
            $sortedCirculationLog = call_user_func(function () use ($decodeCirculation) {
                $result = [];

                foreach ($decodeCirculation['cartable'] as $item) {
                    $result += $item;
                }

                return $result;
            });

            if ($decodeSchema) {
                foreach ($decodeSchema as $schemaData) {
                    $userActivityLog = $sortedCirculationLog[$schemaData['user_permission_id']] ?? [];

                    if (!$userActivityLog) {
                        break;
                    }

                    $endActivity = end($userActivityLog['confirmation']);

                    if (in_array($endActivity['confirm'], [0, 3])) {

                        return [
                            "userId" => $schemaData['user_permission_id'],
                            "permissionId" => $schemaData['permission_id'],
                            "confirmation" => $endActivity['confirm'],
                        ];

                    }
                }
            }

        }
    }

    /**
     * @throws Exception
     */
    public
    function getActivityLogView(): string
    {
        $getData = $this->getData();
        $getCartableCirculationLog = $this->getCartableCirculationLog();

        $html = '';
        $cartableDefinition = CartableDefinitionModel::query()->find($getData->cartable_definition_id);
        if ($cartableDefinition) {
            $statusDictionary = [
                null => [
                    'label' => 'در انتظار ارسال',
                    'bs-color' => 'warning',
                ],
                0 => [
                    'label' => 'در انتظار بررسی',
                    'bs-color' => 'info',
                ],
                1 => [
                    'label' => 'تایید نهایی',
                    'bs-color' => 'success',
                ],
                2 => [
                    'label' => 'عدم تایید',
                    'bs-color' => 'danger',
                ],
                3 => [
                    'label' => 'در انتظار بررسی مجدد',
                    'bs-color' => 'warning',
                ],
            ];

            $processDictionary = [
                null => [
                    'label' => 'در انتظار ارسال',
                    'bs-color' => 'warning',
                ],
                0 => [
                    'label' => 'در حال گردش',
                    'bs-color' => 'info',
                ],
                1 => [
                    'label' => 'اتمام فرآیند',
                    'bs-color' => 'success',
                ],
                2 => [
                    'label' => 'لغو فرآیند',
                    'bs-color' => 'danger',
                ],
                3 => [
                    'label' => 'برگشت از کارتابل',
                    'bs-color' => 'warning',
                ],
            ];

            $cycleElement = '';

            foreach ($getCartableCirculationLog['circle'] as $timestamp => $items) {
                foreach ($items as $item) {

                    $datetime = jdate("Y/m/d H:i:s", $timestamp);
                    $userFullName = userHelper->getUserFullName($item['userId']);
                    $userImage = userHelper->getUserImage($item['userId']);
                    $label = (($item['isProcessLog']) ? $item['defaultLabel'] : $statusDictionary[$item['confirmation']]['label']);
                    $cycleElement .= <<<HTML
                <li class="timeline-items timeline-icon-{$statusDictionary[$item['confirmation']]['bs-color']} active">
                    <div class="timeline-time" dir="ltr">
                        {$datetime}
                    </div>

                    <p class="timeline-text">
                        {$label}
                        توسط
                        {$userFullName}
                    </p>

                    <div class="timeline-content mb-1">
                        <img src="{$userImage}"
                             alt="userImage"
                             width="36"
                             height="36"
                             class="mr-50 rounded-circle">

                        توضیحات: {$item['description']}
                    </div>
                </li>
            HTML;
                }
            }

            $lastLog = $getCartableCirculationLog['lastLog'] ?? [];
            $confirmation = $lastLog['confirmation'] ?? null;
            $actionButtons = '';

            if ($getData->process_status == 1) {
                $confirmation = 1;
            }

            if ($lastLog) {
                $userId = $lastLog['userId'] ?? 0;

                $userName = userHelper->getUserFullName($userId);
                $userImage = userHelper->getUserImage($userId);
                $permissionName = permissionHelper->getUserPermissionName($lastLog['permissionId'] ?? 0);

                if ($userId == userObject()->userId) {
                    $actionButtons = <<<HTML
            <button class="btn btn-icon btn-light-success mb-1 actionCartable"
                    data-definition-id="{$cartableDefinition->id}"
                    data-request-id="{$getData->id}"
                    data-action="approve"
                    data-toggle="tooltip"
                    data-placement="bottom"
                    data-original-title="تایید نهایی">
                <i class="cursor-pointer bx bx-check m-0"></i>
            </button>

            <button class="btn btn-icon btn-light-danger mb-1 actionCartable"
                    data-definition-id="{$cartableDefinition->id}"
                    data-request-id="{$getData->id}"
                    data-action="reject"
                    data-toggle="tooltip"
                    data-placement="bottom"
                    data-original-title="عدم تایید">
                <i class="cursor-pointer bx bx-x m-0"></i>
            </button>
        HTML;
                }

            } else {
                $userId = $getData->user_id;
                $getUser = UserModel::query()->find($userId);

                $userName = userHelper->getUserFullName($userId);
                $userImage = userHelper->getUserImage($userId);
                $permissionName = permissionHelper->getUserPermissionName($getUser->permission_id);

                if ($userId == userObject()->userId) {
                    $actionButtons = match ($getData->process_status) {
                        null => <<<HTML
                                <button class="btn btn-icon btn-light-info mb-1 submitCartable"
                                        data-definition-id="{$cartableDefinition->id}"
                                        data-request-id="{$getData->id}"
                                        data-toggle="tooltip"
                                        data-placement="bottom"
                                        data-original-title="ارسال کارتابل">
                                    <i class="cursor-pointer bx bx-send m-0"></i>
                                </button>
                            HTML,
                        2 => <<<HTML
                                <button class="btn btn-icon btn-light-warning mb-1 submitCartable"
                                        data-definition-id="{$cartableDefinition->id}"
                                        data-request-id="{$getData->id}"
                                        data-toggle="tooltip"
                                        data-placement="bottom"
                                        data-original-title="ارسال مجدد کارتابل">
                                    <i class="cursor-pointer bx bx-send m-0"></i>
                                </button>
                            HTML,
                        default => ''
                    };
                }

            }

            $html = <<<HTML
        <div class="row">
            <div class="col-12">
                <div class="card collapse-header">

                    <div id="headingCollapse1" class="card-header">

                        <div class="row border">

                            <div class="col-12 p-1 col-sm-3 text-center">
                                <img src="{$userImage}"
                                     class="rounded"
                                     alt="group image"
                                     width="120"
                                     height="120">
                            </div>

                            <div class="col-12 pt-1 px-0 col-sm-6">

                                <div class="row">

                                    <div class="col-12 text-center text-sm-left">
                                        <h6 class="media-heading mb-0 primary-font">
                                            {$userName}

                                            <div class="badge badge-light-{$statusDictionary[$confirmation]['bs-color']}">
                                                {$statusDictionary[$confirmation]['label']}
                                            </div>
                                        </h6>

                                        <small class="text-muted align-top line-height-2">
                                            {$permissionName}
                                        </small>
                                    </div>

                                    <div class="col-12 text-center text-sm-left">

                                        <div class="mb-1 mt-50 line-height-2">
                                            <small>آخرین بازدید: -</small>
                                        </div>

                                        {$actionButtons}

                                    </div>

                                </div>

                            </div>

                            <div class="col-12 col-sm-3 mt-1">

                                <h6 class="text-center">مشخصات کارتابل</h6>

                                <p>عنوان: {$cartableDefinition->form_persian_title}</p>

                                <span>وضعیت:</span>

                                <div class="badge badge-light-{$processDictionary[$getData->process_status]['bs-color']}">
                                    {$processDictionary[$getData->process_status]['label']}
                                </div>

                            </div>

                            <div class="col-12 pb-1 text-center">

                                <section id="collapsible">
                                    <div class="collapsible">
                                        <button type="button"
                                                class="btn btn-sm p-0"
                                                data-toggle="collapse"
                                                role="button"
                                                data-target="#collapse_{$cartableDefinition->form_english_title}"
                                                aria-expanded="true"
                                                aria-controls="collapse_{$cartableDefinition->form_english_title}">

                                            مشاهده جزئیات
                                            <i class="bx bx-down-arrow"></i>

                                        </button>
                                    </div>
                                </section>

                            </div>

                        </div>

                    </div>
                            
                    <div id="collapse_{$cartableDefinition->form_english_title}"
                         class="collapse border"
                         role="tabpanel"
                         aria-labelledby="headingCollapse1"
                         style="overflow-y:auto;max-height:60vh">

                        <div class="card-content p-1">

                            <ul class="widget-timeline">
                                <div class="col-12">
                                    {$cycleElement}
                                </div>
                            </ul>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    HTML;

        }
        return $html;
    }

    /**
     * @throws Exception
     */
    public
    function getData()
    {
        $get = $this->getDataModel()->find($this->getRequestId());

        if ($get) {
            return $get;
        } else {
            throw new Exception('request not found');
        }
    }

}