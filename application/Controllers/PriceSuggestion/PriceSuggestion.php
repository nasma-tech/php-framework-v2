<?php

namespace App\Controllers\PriceSuggestion;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\ContactProjectsFollowUpModel\ContactProjectsFollowUpModel;
use App\Models\ContactProjectsModel\ContactProjectsModel;
use App\Models\CountryModel\CountryModel;
use App\Models\PriceSuggestionModel\PriceSuggestionModel;
use App\Models\PriceSuggestionProductModel\PriceSuggestionProductModel;
use App\Models\StateModel\StateModel;

class PriceSuggestion extends ControllerScheme
{
    const string singleName = 'پیشنهاد قیمت';
    const string pluralName = 'پیشنهادات قیمت';
    protected string $defaultModel = PriceSuggestionModel::class;

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
            //'js/PriceSuggestion/PriceSuggestion'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
                //vars
            ])->display('PriceSuggestion/PriceSuggestion.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            //'js/PriceSuggestion/add-PriceSuggestion'
        ], [],
            [//vars
            ]
        )->display('PriceSuggestion/add|edit-PriceSuggestion.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/PriceSuggestion/edit-PriceSuggestion'
        ], [], [
            //var
        ])->display('PriceSuggestion/add|edit-PriceSuggestion.tpl');
    }

    public function createPriceSuggestion($projectId, $followUpId): void
    {
        $contactProjectData = ContactProjectsModel::query()
            ->with([
                'contactData'
            ])->find($projectId);
        $contactProjectFollowUpData = ContactProjectsFollowUpModel::query()->find($followUpId);
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'js/PriceSuggestion/createPriceSuggestion'
        ], [],
            [
                'contactProjectData' => $contactProjectData,
                'contactProjectFollowUpData' => $contactProjectFollowUpData,
                'brands' => brandsModel::query()->get(),
                'countries' => CountryModel::query()->get(),
                'states' => StateModel::query()->where('country_id', 102)->get()
            ]
        )->display('PriceSuggestion/add|edit-PriceSuggestion.tpl');
    }

    private function makePriceSuggestionNumber($id): string
    {
        $today = date('Y-m-d 00:00:00');
        $count = PriceSuggestionModel::query()->where('created_at', '>=', $today)->count();
        return 'PS-' . jdate("Ymd") . $count . '-' . $id;
    }

    public function addPriceSuggestion($projectId, $followUpId): void
    {
        csrf->csrfValidate();
        $data = $this->requestArray();
        $this->checkRequired([
            'productList' => 'محصولات انتخاب نشده است',
        ], $data);
        $contactProjectData = ContactProjectsModel::query()
            ->with([
                'contactData'
            ])->find($projectId);
        $makeData = [
            'contact_id' => $contactProjectData->contactData->id,
            'contact_project_id' => $projectId,
            'contact_project_followup_id' => $followUpId,
            'brand_id' => $data['brand_id'] ?? null,
            'sale_team_id' => $data['sale_team_id'] ?? null,
            'country_id' => $data['country_id'],
            'state_id' => $data['state_id'],
            'city_id' => $data['city_id'],
            'marketer_id' => $data['marketer_id'] ?? null,
            'description' => $data['description'],
            'day_validity' => $data['day_validity'],
            'day_validity_timestamp' => time() + $data['day_validity'] * 86400,
            'user_id' => userObject()->userId
        ];
        $addPriceSuggestion = PriceSuggestionModel::query()->create($makeData);
        if ($addPriceSuggestion) {
            $addPriceSuggestion->update([
                'price_suggestion_number' => $this->makePriceSuggestionNumber($addPriceSuggestion->id)
            ]);
            foreach ($data['productList'] as $item) {
                $discountAmount = 0;
                if ($item['discount_type'] == 'percentage') {
                    $discountAmount = numberNormalizer->removePriceSeparator($item['discount_amount']);
                } else if ($item['discount_type'] == 'cash') {
                    $discountAmount = numberNormalizer->removePriceSeparator($item['discount_unit_amount']);
                }
                $makeProduct = [
                    'price_suggestion_id' => $addPriceSuggestion->id,
                    'product_id' => $item['product_id'],
                    'amount' => numberNormalizer->removePriceSeparator($item['product_amount']),
                    'unit_price' => numberNormalizer->removePriceSeparator($item['product_unit_price']),
                    'discount_type' => (($item['discount_type']) ?: 'noDiscount'),
                    'discount_unit_amount' => numberNormalizer->removePriceSeparator($item['discount_unit_amount']),
                    'discount_amount' => numberNormalizer->removePriceSeparator($item['discount_amount']),
                    'total_unit_price' => numberNormalizer->removePriceSeparator($item['product_unit_price']) - $discountAmount,
                    'total_product_price' => numberNormalizer->removePriceSeparator($item['product_amount']) * (numberNormalizer->removePriceSeparator($item['product_unit_price']) - $discountAmount),
                ];
                PriceSuggestionProductModel::query()->create($makeProduct);
            }
            $this->successCallBack("/ContactProjects/ContactProjectDetail/{$projectId}", 'پیشنهاد قیمت با موفقیت ثبت شد');
        } else {
            $this->failedCallBack("/PriceSuggestion/createPriceSuggestion/{$projectId}/{$followUpId}", 'خطا در ثبت پیشنهاد قیمت');
        }

    }
}
