<?php

namespace App\Controllers\Products;

use App\Controllers\scheme\ControllerScheme;
use App\Models\brandsModel\brandsModel;
use App\Models\MeasurementUnitModel\MeasurementUnitModel;
use App\Models\ProductGradeModel\ProductGradeModel;
use App\Models\ProductGroupModel\ProductGroupModel;
use App\Models\ProductModel\ProductModel;
use App\Models\ProductQualitiesModel\ProductQualitiesModel;

class Products extends ControllerScheme
{
    const string singleName = 'محصول';
    const string pluralName = 'محصولات';
    protected string $defaultModel = ProductModel::class;

    public function main()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->setModel($this->defaultModel::all());
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
            'js/Products/Products'
        ],
            ['vendors/css/tables/datatable/datatables.min'],
            [
            ])->display('Products/Products.tpl');
    }

    public function addIndex()
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        view->ui([
            'vendors/js/charts/apextree.min',
            'vendors/js/splide/splide.min',
            'js/Products/add-Products'
        ], [
            'vendors/css/splide/splide.min',
            'css/Products/add-Products'
        ],
            [
                "parentProducts" => ProductModel::all(),
                "productGroups" => ProductGroupModel::all(),
                'measurement_unit' => measurementUnitModel::all(),
                'brands' => brandsModel::all(),
                'productQualities' => ProductQualitiesModel::all(),
                'productGrades' => ProductGradeModel::all()
            ]
        )->display('Products/add-Products.tpl');
    }

    public function editIndex($id)
    {
        view->setPageTitle(self::pluralName);
        view->setSingleName(self::singleName);
        view->setPluralName(self::pluralName);
        //name this model
        view->setModel();
        view->ui([
            //'js/Products/edit-Products'
        ], [], [
            //var
        ])->display('Products/edit-Products.tpl');
    }

    public function add()
    {
        csrf->csrfValidate();
        $data = $this->requestArray();

        $needle = [
            "parent_id",
            "parent_unit_ratio",
            "label",
            "serial_number",
            "group_id",
            "brand_id",
            "quality_level_id",
            "measurement_unit_id",
            "cost_price",
            "sale_price",
            "customer_price",
            "description",
            "complete_description",
        ];

        if (validator->validateRequestsData($needle)) {
            $files = fileHelper->normalizeUploadedFiles('images');

            $add = $this->defaultModel::query()->create([
                "parent_id" => ($data['parent_id'] ?: null),
                "parent_unit_ratio" => numberNormalizer->removePriceSeparator(($data['parent_unit_ratio'] ?: 0)),
                "label" => trim($data['label']),
                "serial_number" => trim($data['serial_number']),
                "group_id" => $data['group_id'],
                "brand_id" => $data['brand_id'],
                "quality_level_id" => $data['quality_level_id'],
                "measurement_unit_id" => $data['measurement_unit_id'],
                "cost_price" => numberNormalizer->removePriceSeparator($data['cost_price']),
                "sale_price" => numberNormalizer->removePriceSeparator($data['sale_price']),
                "customer_price" => numberNormalizer->removePriceSeparator($data['customer_price']),
                "description" => trim($data['description']),
                "complete_description" => trim($data['complete_description']),
                "user_id" => userObject()->userId
            ]);

            if ($add) {
                var_print('hi');
            }
        }
    }

    public function getProductDataFilterByBrand(): void
    {
        $_ENV['APP_DEBUG'] = 1;
        $brandId = $this->requestArray()['brandId'];
        if ($brandId){
            echo json_encode(array_map(function ($item) {
                return [
                    'id' => $item['id'],
                    'title' => $item['label'],
                    'unitPrice'=>$item['sale_price'],
                    'unitName' => $item['measurement_unit_data']['label'],
                ];
            }, ProductModel::query()
                ->with([
                    'measurementUnitData'
                ])->where('brand_id',$brandId)->get()->toArray()));
        }
    }

    public function getProductData(): void
    {
        echo json_encode(array_map(function ($item) {
            return [
                'id' => $item['id'],
                'title' => $item['label'],

            ];
        }, ProductModel::query()
            ->get()->toArray()));
    }
}