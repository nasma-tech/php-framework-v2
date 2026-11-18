<div class="card shadow stepsCard" style="margin-top: 3px" data-step="2" id="step_2">
    <div class="card-content">
        <div class="card-body">
            <div class="divider divider-left">
                <div class="divider-text" style="font-size: 12px">انتخاب برند و محصول</div>
            </div>
            <div class="row">
                <div class="col-md-3 mt-2">
                    <label for="">برند محصول</label>
                    <select class="form-control select2" id="brand_id" name="brand_id">
                        <option selected disabled>یک برند انتخاب کنید</option>
                        {foreach $brands as $item}
                            <option value="{$item.id}">{$item.label}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-8">
                    <div class="divider divider-left">
                        <div class="divider-text" style="font-size: 12px">انتخاب محصول</div>
                    </div>
                    <div class="table-responsive-md table-responsive">
                        <table class="table table-striped table-hover text-center">
                            <thead class="thead-dark">
                            <tr>
                                <th class="border">ردیف</th>
                                <th class="border">محصول</th>
                                <th class="border">مقدار</th>
                                <th class="border">واحد</th>
                                <th class="border">قیمت واحد (ریال)</th>
                                <th class="border">مجموع</th>
                                <th class="border">عملیات</th>
                            </tr>
                            </thead>
                            <tbody id="mainProduct">
                            {foreach $getDataProduct|default:[] as $key=>$item}
                                <tr>
                                    <td class="border">
                                        {$key+1}
                                    </td>
                                    <td class="border">
                                        <select class="form-control select2 product_id"
                                                id="product_id_{$key+1}"
                                                name="productList[{$key+1}][product_id]">
                                            {foreach $products as $product}
                                                <option value="{$product.id}">{$product.label}</option>
                                            {/foreach}
                                        </select>
                                        <input class="form-control" dir="ltr"
                                               value="{$item.id}"
                                               type="hidden"
                                               readonly name="productList[{$key+1}][productId]"/>
                                    </td>
                                    <td class="border">
                                        <input class="form-control product_amount" dir="ltr"
                                               value="{$numberNormalizer->floatNumberFormat($item.amount)}"
                                               {if !$getData|default:null}readonly{/if} required
                                               id="" name="productList[{$key+1}][product_amount]"/>
                                    </td>
                                    <td class="border">
                                        <span>-</span>
                                    </td>
                                    <td class="border">
                                        <input class="form-control product_unit_price"
                                               {if !$getData|default:null}readonly{/if}
                                               required id="" dir="ltr"
                                               value="{$numberNormalizer->floatNumberFormat($item.unit_price)}"
                                               name="productList[{$key+1}][product_unit_price]"/>
                                    </td>
                                    <td class="border">
                                        <div class="input-group">
                                            <input class="form-control text-center productSumRow"
                                                   value="{$numberNormalizer->floatNumberFormat($item.total_product_price)}"
                                                   readonly id="" name="">
                                            <div class="input-group-append">
                                                <span class="input-group-text font-small-2">ریال</span>
                                            </div>
                                        </div>
                                        <input class="form-control discountType" type="hidden"
                                               readonly placeholder="نوع تحفیف"
                                               value="{($item.discount_type != 'noDiscount')?$item.discount_type:null}"
                                               name="productList[{$key+1}][discount_type]">
                                        <div class="input-group" style="margin-top: 3px">
                                            <div class="input-group-append">
                                                <span class="input-group-text font-small-2">واحد تخفیف</span>
                                            </div>
                                            <input class="form-control discountUnitAmount text-center"
                                                   readonly placeholder="واحد تخفیف"
                                                   value="{$numberNormalizer->floatNumberFormat($item.discount_unit_amount)}"
                                                   name="productList[{$key+1}][discount_unit_amount]">
                                        </div>
                                        <div class="input-group" style="margin-top: 3px">
                                            <div class="input-group-append">
                                                <span class="input-group-text font-small-2">مجموع تخفیف</span>
                                            </div>
                                            <input class="form-control discountAmount text-center"
                                                   readonly placeholder="مجموع تخفیف"
                                                   value="{$numberNormalizer->floatNumberFormat($item.discount_amount)}"
                                                   name="productList[{$key+1}][discount_amount]">
                                            <div class="input-group-append">
                                                <span class="input-group-text font-small-2">ریال</span>
                                            </div>
                                        </div>
                                        <div class="input-group" style="margin-top: 3px">
                                            <div class="input-group-append">
                                                                    <span class="input-group-text font-small-2">
                                                                        قیمت واحد پس از تخفیف
                                                                    </span>
                                            </div>
                                            <input class="form-control text-center unitPriceAfterDiscount"
                                                   value="{$numberNormalizer->floatNumberFormat($item.total_unit_price)}"
                                                   readonly placeholder="قیمت واحد پس از تخفیف"
                                                   name="productList[{$key+1}][unit_price_after_discount]">
                                            <div class="input-group-append">
                                                                    <span class="input-group-text font-small-2">
                                                                        ریال
                                                                    </span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="border">
                                        <div class="dropup">
                                                                <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer"
                                                                      data-toggle="dropdown" aria-haspopup="true"
                                                                      aria-expanded="false" role="menu">
                                                                </span>
                                            <div class="dropdown-menu" x-placement="bottom-start">
                                                <a class="dropdown-item text-danger removeProductRowButton"
                                                   data-id="{$item.id}"
                                                   style="cursor: pointer">
                                                    <i class="bx bx-trash-alt text-danger mr-1"></i>
                                                    حذف ردیف
                                                </a>
                                                <a class="dropdown-item text-primary discountButton"
                                                   data-type="percentage"
                                                   style="cursor: pointer;{($item.discount_type != 'noDiscount')?'display: none':''}">
                                                    <i class="bx bxs-discount text-primary mr-1"></i>
                                                    تخفیف درصدی
                                                </a>
                                                <a class="dropdown-item text-secondary discountButton"
                                                   data-type="cash"
                                                   style="cursor: pointer;{($item.discount_type != 'noDiscount')?'display: none':''}">
                                                    <i class="bx bx-money text-secondary mr-1"></i>
                                                    تخفیف ریالی
                                                </a>
                                                <a class="dropdown-item text-danger removeDiscountButton"
                                                   style="cursor: pointer;{($item.discount_type != 'noDiscount')?'':'display: none'}">
                                                    <i class="bx bx-x text-danger mr-1"></i>
                                                    حذف تخفیف
                                                </a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border" colspan="7">
                                    <div class="d-flex flex-column justify-content-end">
                                        <button type="button"
                                                class="btn btn-sm btn-primary btn-icon glow"
                                                id="addProductButton">
                                            <i class="bx bx-plus"></i>
                                        </button>
                                    </div>
                                </th>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="col-md-4 pl-md-0">
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th class="border text-center" colspan="2">
                                                مجموع
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>جمع</td>
                                            <td class="text-right">
                                                <span id="sumAllProductRow" dir="rtl">0</span><span> ریال</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>تخفیف</td>
                                            <td class="text-right">
                                                <span id="sumAllDiscountRow" dir="rtl">0</span><span> ریال</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>جمع خالص</td>
                                            <td class="text-right">
                                                <span id="netSumAllProductRow" dir="rtl">0</span><span> ریال</span>
                                            </td>
                                        </tr>
                                        </tbody>
                                        <tbody id="mainChargesDeductionsSumTr"></tbody>
                                        <tfoot>
                                        <tr class="border-top">
                                            <td>جمع کل</td>
                                            <td class="text-right">
                                                <span id="finalSum" dir="rtl">0</span><span> ریال</span>
                                            </td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped text-center">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th class="border text-center" colspan="2">
                                                اعمال محاسبات
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody id="mainChargesDeductions"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th class="border text-center" colspan="2">
                                                معرف
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>معرف</td>
                                            <td>
                                                <select class="form-control select2"></select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>درصد</td>
                                            <td>3</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th class="border text-center" colspan="2">
                                                لوکیشن
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>کشور</td>
                                            <td>
                                                <select class="form-control select2"></select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>استان</td>
                                            <td>
                                                <select class="form-control select2"></select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>شهر</td>
                                            <td>
                                                <select class="form-control select2"></select>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>