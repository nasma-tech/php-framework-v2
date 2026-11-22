{include "sections/header.tpl"}
{include "sections/top-bar.tpl"}
{include "sections/side-menu.tpl"}
<div class="app-content content">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title"><code> {$packageData->title} - {$packageData->warehouseData->ware_house_name} </code></h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndBackBtn()}
                            {$csrf->csrfTokenInput()}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <table class="table table-hover table-striped text-center" id="mainTable"
                                   style="background-color: #fff;border-radius: 5px;">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border">#</th>
                                    <th class="border">کد محصول</th>
                                    <th class="border">عنوان</th>
                                    <th class="border">مقدار</th>
                                    <th class="border">واحد</th>
                                    <th class="border">عملیات</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $getData as $item}
                                    <tr id="row_{$item['id']}">
                                        <td class="border">{counter}</td>
                                        <td class="border">{$item->productData->serial_number}</td>
                                        <td class="border">{$item->productData->label}</td>
                                        <td class="border">{$numberNormalizer->floatNumberFormat($item['amount'])}</td>
                                        <td class="border">{$item->productData->measurementUnit->label}</td>
                                        <td class="border">
                                            <button class="btn btn-icon rounded-circle editRow btn-light-warning"
                                                    data-amount="{$item['amount']}"
                                                    data-unit_title="{$item->productData->measurementUnit->label}"
                                                    data-product_id="{$item['product_id']}"
                                                    data-id="{$item['id']}">
                                                <i class="bx bx-edit"></i>
                                            </button>
                                            <button class="btn btn-icon rounded-circle deleteRow btn-light-danger"
                                                    data-id="{$item['id']}"
                                                    data-product_id="{$item['product_id']}">
                                                <i class="bx bx-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{include "sections/footer.tpl"}

