<?php

namespace App\Controllers\dashboard;

use App\Controllers\CartableDefinition\CartableDefinition;
use App\Models\RoleModel\RoleModel;
use App\Models\UserModel\UserModel;
use SmartyException;
use Exception;

class dashboard
{
    const string singleName = 'داشبورد';
    const string pluralName = 'داشبورد';

    /**
     * @throws SmartyException
     * @throws Exception
     */
    public function main(): void
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        $cartable = new CartableDefinition();

        $tabData = [
            [
                'persianTitle' => 'کارتابل من',
                'englishTitle' => 'cartable',
                'tabIcon' => 'bx-mail-send',
                'isActive' => true,
                'tabHeaders' => [
                    'عنوان کارتابل',
                    'وضعیت',
                    'درخواست دهنده',
                    'ارجاع دهنده',
                    'تاریخ ارجاع',
                    'ساعت ارجاع',
                    'عملیات',
                ],
                'data' => call_user_func(function () use ($cartable) {
                    $cartables = $cartable->getAllCartableData();

                    $output = [];

                    foreach ($cartables as $cartableData) {
                        foreach ($cartableData['data'] as $cartableItem) {
                            $output[] = [
                                'dateSend' => $cartableItem['dataCartable']['dateSend'],
                                'timeSend' => $cartableItem['dataCartable']['timeSend'],
                                'description' => $cartableItem['dataCartable']['description'],
                                'viewAddress' => preg_replace_callback(
                                    '/\{(\w+)\}/',
                                    fn($matches) => $cartableItem['dataCartable']['requestData'][$matches[1]] ?? $matches[0],
                                    $cartableData['definitionData']['view_address']
                                ),
                                'cartableData' => [
                                    'definitionId' => $cartableData['definitionData']['id'],
                                    'persianTitle' => $cartableData['definitionData']['form_persian_title'],
                                    'requestId' => $cartableItem['dataCartable']['requestId'],
                                ],
                                'statusData' => [
                                    'code' => $cartableItem['dataCartable']['statusCode'],
                                    'title' => $cartableItem['dataCartable']['statusName'],
                                ],
                                'senderData' => [
                                    'userId' => $cartableItem['dataCartable']['userSenderId'],
                                    'userFullName' => $cartableItem['dataCartable']['userSenderName'],
                                ],
                                'requesterData' => [
                                    'userId' => $cartableItem['dataCartable']['userRequestId'],
                                    'userFullName' => $cartableItem['dataCartable']['userRequestName'],
                                ],
                            ];
                        }
                    }


                    return $output;
                })
            ]
        ];
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
            'vendors/js/charts/apexcharts4.min',
            'iranMap/jsMap/highmaps',
            'iranMap/jsMap/exporting',
            'js/dashboard/dashboard',
        ],
            [
                'iranMap/cssMap/mapStyle',
                'vendors/css/tables/datatable/datatables.min',
                'vendors/css/charts/apexcharts4.min',
            ],
            [
                'user' => UserModel::query()->find(userObject()->userId),
                'role' => RoleModel::query()->find(userObject()->userId),
                'tabData' => $tabData,
                'labelColorData' => [
                    0 => 'bg-rgba-info',
                    1 => 'bg-rgba-success',
                    2 => 'bg-rgba-danger',
                    3 => 'bg-rgba-warning',
                ],
            ]
        )->display('dashboard/dashboard.tpl');
    }
}
