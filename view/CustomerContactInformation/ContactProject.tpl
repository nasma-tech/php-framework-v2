<div class="card shadow cc-request-info" style="margin-top: 4px;height: 100%">
    <div class="card-content">
        <div class="card-header">
            <div class="divider divider-left">
                <div class="divider-text" style="font-size: 11px">اطلاعات درخواست</div>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <label for="industry_type_id">نوع صنعت</label>
                    <select class="form-control select2" required="required" id="industry_type_id"
                            name="industry_type_id" {($getData)?'disabled':''}>
                        <option selected disabled>یک مورد را انتخاب کنید</option>
                        {foreach $IndustryType as $item}
                            <option value="{$item->id}"{(($getData.industry_type_id|default:'') == $item.id)?'selected':''}>{$item->title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="payment_type">نوع پرداخت</label>
                    <select class="form-control select2" required="required" id="payment_type"
                            name="payment_type" {($getData)?'disabled':''}>
                        <option selected disabled>یک مورد را انتخاب کنید</option>
                        <option value="1" {(($getData.payment_type|default:'') == 1)?'selected':''}>نقد</option>
                        <option value="2" {(($getData.payment_type|default:'') == 2)?'selected':''}>اقساط</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="purchase_type">نوع خرید</label>
                    <select class="form-control select2" required="required" id="purchase_type"
                            name="purchase_type" {($getData)?'disabled':''}>
                        <option selected disabled>یک مورد را انتخاب کنید</option>
                        <option value="1" {(($getData.purchase_type|default:'') == 1)?'selected':''}>نو</option>
                        <option value="2" {(($getData.purchase_type|default:'') == 2)?'selected':''}>کارکرده</option>
                    </select>
                </div>

                <div class="table-responsive mt-3">
                    <table class="table text-center">
                        <thead class="thead-dark">
                        <tr>
                            <th class="border">عنوان محصول</th>
                            <th class="border">مقدار</th>
                            <th class="border">عملیات</th>
                        </tr>
                        </thead>
                        <tbody id="productRequestTableBody">
                        {foreach $getData.projectRequests|default:[] as $key => $item}
                            <tr>
                                <td class="border">
                                    <select class="form-control projectOptionsSelect carTipId select2"
                                            data-product_id="{$item.productInfo.id|default:'-'}"
                                            id="projectRequest[{$key}][product_id]"
                                            name="projectRequest[{$key}][product_id]">
                                        <option selected disabled>یکی از موارد رو انتخاب کنید</option>
                                        {foreach $Products|default:[] AS $data}
                                            <option value="{$data.id}"
                                                    {if $data.id = $item.productInfo.id|default:'-'}selected{/if} >{$data.title}</option>
                                        {/foreach}
                                    </select>
                                </td>

                                <td class="border" width="150">
                                    <input class="form-control requestAmount"
                                           dir="ltr"
                                           type="text"
                                           value="{$item.request_amount|default:''}"
                                           id="projectRequest[{$key}][request_amount]"
                                           name="projectRequest[{$key}][request_amount]">
                                </td>

                                <td class="border">
                                    <div class="dropup">
                    <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer"
                          data-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                          role="menu"></span>

                                        <div class="dropdown-menu">
                                            <a class="dropdown-item text-danger removeRequestRow">
                                                <i class="bx bx-trash text-danger mr-1"></i>
                                                حذف
                                            </a>
                                            <a class="dropdown-item text-primary inquiryRequestRow">
                                                <i class="bx bx-search text-primary mr-1"></i>
                                                استعلام
                                            </a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                        <tfoot>
                        <tr>
                            <th class="border" colspan="6">
                                <button class="btn btn-xs btn-success w-100" id="productAppend" type="button">
                                    <i class="bx bx-plus" style="font-size: 14px"></i>
                                </button>
                            </th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
                {if !empty($getData.id)}
                    <div class="card-footer">
                        <button class="btn btn-sm btn-primary float-right" type="submit">ثبت محصولات</button>
                    </div>
                {/if}
            </div>
        </div>
    </div>
</div>
