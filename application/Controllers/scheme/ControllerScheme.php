<?php

namespace App\Controllers\scheme;

use Carbon\Carbon;
use Exception;
use Illuminate\Database\Eloquent\Model;
use JetBrains\PhpStorm\NoReturn;
use Packages\View\handleHttpErrorView;

class ControllerScheme
{
    const singleName = '';
    const pluralName = '';

    const allowGetAllPermissionIds = [];

    protected $model;
    protected $modelInstance;
    protected $modelClass;

    public function __construct()
    {
        $this->Model();
    }

    /**
     * داینامیک پیدا کردن مدل متناظر با کنترلر
     */
//    protected function Model()
//    {
//        $controllerClass = get_class($this); // App\Controllers\Countries\Countries
//        $parts = explode('\\', $controllerClass);
//        $controllerName = array_pop($parts); // Countries
//
//        $modelName = str_replace('Controller', '', $controllerName) . 'Model';
//
//        foreach ($parts as &$part) {
//            if (strtolower($part) === 'controllers') {
//                $part = 'Models';
//                break;
//            }
//        }
//
//        array_pop($parts);
//        $parts[] = $modelName;
//
//        $modelClass = '\\' . implode('\\', $parts) . '\\' . $modelName;
//
//        if (!class_exists($modelClass)) {
//            throw new Exception("❌ Model class {$modelClass} not found");
//        }
//
//        $this->modelClass = $modelClass;
//        $this->modelInstance = new $modelClass();
//        $this->setModel($this->modelInstance->getTable());
//    }

    protected function Model()
    {
        $controllerClass = get_class($this);
        $controllerName = (new \ReflectionClass($this))->getShortName();

        // مدل پیش‌بینی شده convention
        $predictedModel = '\\App\\Models\\' . $controllerName . 'Model';

//        var_print($predictedModel);
//        die();

        // مدل fallback: اگر override شده باشد
        $fallbackModel = property_exists($this, 'defaultModel') ? $this->defaultModel : null;
        if ($fallbackModel !== false) {
            // اگر مدل convention وجود دارد، همیشه استفاده شود
            if (class_exists($predictedModel)) {
                $modelClass = $predictedModel;
            } // اگر convention وجود ندارد، ولی defaultModel ست شده باشد، استفاده شود
            elseif ($fallbackModel && class_exists($fallbackModel)) {
                $modelClass = $fallbackModel;
            } else {
                throw new \Exception(
                    "❌ Model class for controller {$controllerName} not found. Expected: {$predictedModel}" .
                    ($fallbackModel ? " or fallback: {$fallbackModel}" : "")
                );
            }

            $this->modelClass = $modelClass;
            $this->modelInstance = new $modelClass();
            $this->setModel($this->modelInstance->getTable());
        }
    }


    public function getModelInstance()
    {
        return $this->modelInstance;
    }

    protected function validateCSRF()
    {
        csrf->csrfValidate();
    }

    public function add()
    {
        $this->validateCSRF();
        /** @var Model $model */
        $model = $this->modelInstance;
        $data = $this->requestArray();
        $fillable = $model->getFillable();
        $successForm = true;
        $formNotCovered = [];
        foreach ($data as $field => $item) {
            if (!in_array($field, $fillable)) {
                $formNotCovered[] = $field;
                $successForm = false;
            }
        }
        $insertData = array_intersect_key($data, array_flip($fillable));
        if (in_array('user_id', $fillable) && isset(userObject()->userId)) {
            $insertData['user_id'] = userObject()->userId;
        }
        try {
            if ($successForm) {
                $created = $this->modelClass::create($insertData);
                $this->handleFileUpload($created->id);
                $this->successCallBack('main');
            } else {
                if (permissionHelper->isDeveloper()) {
                    $this->failedCallBack('addIndex', 'نام گذاری ناهماهنگ (نام گذاری موارد فرم با جدول مطابقت ندارد) | ' . json_encode($formNotCovered));
                } else {
                    $this->failedCallBack('addIndex');
                }
            }
            exit;
        } catch (Exception $e) {
            if (permissionHelper->isDeveloper()) {
                $this->failedCallBack('addIndex', $e->getMessage());
            } else {
                $this->failedCallBack('addIndex');
            }
            exit;
        }
    }

    public function successCallBack($redirectTo, $message = 'رکورد با موفقیت اضافه شد', $second = 1)
    {
        setcookie('successMessage', $message, time() + $second, '/');
        header("Location: $redirectTo");
    }

    public function failedCallBack($redirectTo, $message = 'خطا در ذخیره‌سازی رکورد', $second = 1)
    {
        setcookie('failedMessage', $message, time() + $second, '/');
        header("Location: $redirectTo");
    }

    public function edit($id)
    {
        $this->validateCSRF();
        /** @var Model $record */
        $record = $this->modelClass::find($id);

        if (!$record) {
            return $this->jsonResponseFailed("NotFound", "رکورد پیدا نشد");
        }

        $data = $_POST ?: json_decode(file_get_contents('php://input'), true);
        if (empty($data)) {
            return $this->jsonResponseFailed("EmptyData", "هیچ داده‌ای ارسال نشده است");
        }

        $model = $this->modelInstance;
        $fillable = $model->getFillable();
        $successForm = true;
        $formNotCovered = [];
        foreach ($data as $field => $item) {
            if (!in_array($field, $fillable)) {
                $formNotCovered[] = $field;
                $successForm = false;
            }
        }

        if (property_exists($record, 'timestamps') && $record->timestamps === false) {
            $data['updated_at'] = Carbon::now();
        }

        $getBaseUrl = current(array_filter(explode('/', $_SERVER['REQUEST_URI'])));

        try {
            if ($successForm) {
                $record->fill($data);
                $this->handleFileUpload($id);
                $record->save();
                $this->successCallBack("/$getBaseUrl/main", 'رکورد با موفقیت بروزرسانی شد');
            } else {
                if (permissionHelper->isDeveloper()) {
                    $this->failedCallBack("/$getBaseUrl/editIndex/$id", 'نام گذاری ناهماهنگ (نام گذاری موارد فرم با جدول مطابقت ندارد) | ' . json_encode($formNotCovered));
                } else {
                    $this->failedCallBack("/$getBaseUrl/editIndex/$id");
                }
            }
            exit;
        } catch (Exception $e) {
            if (permissionHelper->isDeveloper()) {
                $this->failedCallBack('addIndex', $e->getMessage());
                $this->failedCallBack("/$getBaseUrl/editIndex/$id", 'خطا در بروزرسانی رکورد');
            } else {
                $this->failedCallBack('addIndex');
            }
            exit;
        }
    }


    public function delete($id)
    {
        $record = $this->modelClass::find($id);
        if (!$record) {
            return $this->jsonResponseFailed("NotFound", "رکورد مورد نظر یافت نشد");
        }

        try {
            if (in_array('soft_delete', $record->getFillable())) {
                $record->soft_delete = 1;
                $record->save();
            } else {
                $record->delete();
            }

            return $this->jsonResponseSuccess("Successful", "رکورد با موفقیت حذف شد");
        } catch (Exception $e) {
            return $this->jsonResponseFailed("Failed", "خطا در حذف رکورد", $e->getMessage());
        }
    }

    /**
     * حذف گروهی
     */
    public function groupDelete()
    {
        $items = $this->requestArray()['itemDelete'] ?? [];

        foreach ($items as $id) {
            $record = $this->modelClass::find($id);
            if ($record) {
                $record->soft_delete = 1;
                $record->save();
            }
        }

        return $this->jsonResponseSuccess("Successful", "رکوردها با موفقیت حذف شدند");
    }

    /**
     * آپلود فایل
     */
    protected function handleFileUpload($id)
    {
        $explodeName = explode('\\', get_class($this));
        foreach ($_FILES ?? [] as $key => $item) {
            if ($item['size'] > 0) {
                $path = fileHelper->fileUpload(end($explodeName), $key, $id);
                $record = $this->modelClass::find($id);
                $record->$key = $path;
                $record->save();
            }
        }
    }

    /**
     * متدهای کمکی
     */
    public function requestArray(): array
    {
        return match ($_SERVER['REQUEST_METHOD']) {
            'POST' => $_POST,
            'GET' => $_GET,
            default => [],
        };
    }

    public function changeRequestValues($key, $value): void
    {
        $_POST[$key] = $value;
    }

    public function setModel($model): void
    {
        $this->model = $model;
    }

    public function getModel()
    {
        return $this->model;
    }

    #[NoReturn]
    protected function jsonResponseSuccess($status = "Successful", $message = "عملیات موفق", $value = null): void
    {
        header('Content-Type: application/json');
        echo json_encode(['status' => $status, 'message' => $message, 'value' => $value], JSON_UNESCAPED_UNICODE);
        exit;
    }

    #[NoReturn]
    protected function jsonResponseFailed($status = "Failed", $message = "عملیات شکست خورد", $value = null): void
    {
        header('Content-Type: application/json');
        echo json_encode(['status' => $status, 'message' => $message, 'value' => $value], JSON_UNESCAPED_UNICODE);
        exit;
    }

    public function validateRequestsData(array $needle = [], array|null $hayStack = null, $model = null)
    {
        $staticColumns = [
            "cartable_definition_id",
            "schema_work_group",
            "cartable_circulation",
            "process_status",
            "process_log",
            "change_schema_log",
            "user_id",
            "create_at",
            "created_at",
            "updated_at",
            "deleted_at"
        ];

        if (is_null($model)) {
            $model = $this->modelInstance;
        }

        if (!$hayStack) {
            $hayStack = array_keys($this->requestArray());
        }
//        $needle = array_merge($this->modelInstance->getFillable(), $needle);

        $needle = array_values(array_unique(
            array_merge($model->getFillable(), $needle)
        ));

        $diff = array_diff(
            array_fill_keys(array_unique(array_merge($needle, $staticColumns)), null),
            array_fill_keys($hayStack, null)
        );

        return !$diff;

    }

    public function validatePermission(array $allowGetAllPermissionIds, bool $checkSuperAdmin = true): bool
    {

        if ($checkSuperAdmin) {
            return in_array(userObject()->permission, $allowGetAllPermissionIds) || permissionHelper->isSuperAdmin();
        }
        return in_array(userObject()->permission, $allowGetAllPermissionIds);
    }

    public function validateUser(array $allowUserIds, bool $checkSuperAdmin = true): bool
    {
        if ($checkSuperAdmin) {
            return in_array(userObject()->userId, $allowUserIds) || permissionHelper->isSuperAdmin();
        }
        return in_array(userObject()->userId, $allowUserIds);
    }

    public function defaultOutput(): array
    {
        return [
            'status' => 'danger',
            'message' => 'ثبت اطلاعات با شکست مواجه شد',
            'data' => []
        ];
    }

    public function successOutput(string $message = "ثبت اطلاعات با موفقیت انجام شد", array $data = []): array
    {
        return [
            'status' => 'success',
            'message' => trim($message),
            'data' => $data
        ];
    }

    public function defaultAjaxEndpoint(): void
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $output = $this->defaultOutput();

        $needle = [

        ];

        if (validator->validateRequestsData($needle)) {

        }

        echo json_encode($output, JSON_UNESCAPED_UNICODE);
    }

    public function checkRequired(array $required, array $request): void
    {
        $diff = array_diff(array_keys($required), array_keys($request));
        $errors = array_filter($required, function ($label, $key) use ($diff, $request) {
            return in_array($key, $diff, true) || !isset($request[$key]) || trim((string)$request[$key]) === '';
        }, ARRAY_FILTER_USE_BOTH);
        if (!empty($errors)) {
            handleHttpErrorView::handle(422, array_values($errors));
        }
    }
}