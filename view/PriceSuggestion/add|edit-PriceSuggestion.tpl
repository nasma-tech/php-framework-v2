{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">{$singleName} | مشتری :
                            <code>{$contactProjectData.contactData.first_name} {$contactProjectData.contactData.last_name}</code>
                            {if $getData.created_at|default:null}
                                | تاریخ صدور اولین پیشنهاد
                                <code>{jdate("Y/m/d",strtotime($getData.created_at))}</code>
                            {/if}
                        </h4>
                        {$buttonHelper->refreshAndBackButton()}
                    </div>
                </div>
            </div>
        </div>
        <form {if !$getData|default:null}
            action="/PriceSuggestion/addPriceSuggestion/{$contactProjectData.id}/{$contactProjectFollowUpData.id}"
        {else}
            action="/PriceSuggestion/updatePriceSuggestion/{$getData.id}"
        {/if}
                method="post"
                enctype="multipart/form-data">
            {$csrf->csrfTokenInput()}
            <div class="row">
                <div class="col-md-8">
                    <div class="card shadow" style="margin-top: 3px">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="divider divider-left">
                                            <div class="divider-text font-small-2">اطلاعات اولیه</div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="">تیم فروش</label>
                                        <select class="form-control select2" id="sale_team_id"
                                                name="sale_team_id"></select>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="">برند</label>
                                        <select class="form-control select2" id="brand_id" name="brand_id">
                                            <option selected disabled>یک مورد را انتخاب کنید</option>
                                            {foreach $brands as $item}
                                                <option value="{$item.id}"
                                                        {if $getData.brand_id|default:null == $item.id}selected{/if}>{$item.label}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        {if $getData|default:null}
                                            <label for="">تاریخ ویرایش</label>
                                        {else}
                                            <label for="">تاریخ صدور</label>
                                        {/if}
                                        <input class="form-control text-center" readonly="readonly"
                                               value="{jdate("Y/m/d")}">
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="">روز اعتبار</label>
                                        <select class="form-control select2" id="day_validity" name="day_validity">
                                            {for $day=1 to 30}
                                                <option value="{$day}">{$day}</option>
                                            {/for}
                                        </select>
                                    </div>
                                    <div class="col-md-4 mt-2">
                                        <label for="">کشور</label>
                                        <select class="form-control select2" id="country_id" name="country_id">
                                            {foreach $countries|default:[] as $item}
                                                <option value="{$item.id}" {if $getData.country_id|default:102 == $item.id} selected {/if} >{$item.persian_title}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="col-md-4 mt-2">
                                        <label for="">استان</label>
                                        <select class="form-control select2" id="state_id" name="state_id" required>
                                            <option selected disabled>یک استان انتخاب کنید</option>
                                            {foreach $states as $item}
                                                <option value="{$item.id}"
                                                        {if $getData.state_id|default:null == $item.id}selected{/if}>{$item.title}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="col-md-4 mt-2">
                                        <label for="">شهر</label>
                                        <select class="form-control select2" id="city_id" name="city_id"
                                                {if !$getData.city_id|default:null}disabled{/if}
                                                required>
                                            {foreach $cities|default:[] as $item}
                                                <option value="{$item.id}"
                                                        {if $getData.city_id|default:null == $item.id}selected{/if}>{$item.title}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card shadow" style="margin-top: 3px">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="divider divider-left">
                                            <div class="divider-text font-small-2">اطلاعات درخواست</div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
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
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card shadow" style="margin-top: 3px">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="divider divider-left">
                                            <div class="divider-text font-small-2">توضیحات</div>
                                        </div>
                                        <textarea class="form-control" rows="8" style="resize: none" id="description"
                                                  name="description">{$getData.description|default:null}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 pl-md-0">
                    <div class="card shadow" style="margin-top: 3px">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="divider divider-left">
                                            <div class="divider-text font-small-2">مجموع</div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-striped">
                                                <tr>
                                                    <td>جمع کل</td>
                                                    <td class="text-right">
                                                        <span id="sumAllProductRow" dir="rtl">0</span><span> ریال</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>جمع تخفیف</td>
                                                    <td class="text-right">
                                                        <span id="sumAllDiscountRow"
                                                              dir="rtl">0</span><span> ریال</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card shadow" style="margin-top: 3px">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="divider divider-left">
                                            <div class="divider-text font-small-2">معرف(بازاریاب)</div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-striped text-center">
                                                <tr>
                                                    <td>بازاریاب</td>
                                                    <td>
                                                        <select class="form-control"></select>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="card shadow" style="margin-top: 3px">
                        <div class="card-content">
                            <div class="card-body d-flex flex-sm-row flex-column justify-content-end">
                                {if $getData|default:null}
                                    <button type="submit" class="btn btn-sm btn-success glow">
                                        ویرایش {$singleName}</button>
                                {else}
                                    <button type="submit" class="btn btn-sm btn-primary glow">
                                        صدور {$singleName}</button>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


{include 'sections/footer.tpl'}