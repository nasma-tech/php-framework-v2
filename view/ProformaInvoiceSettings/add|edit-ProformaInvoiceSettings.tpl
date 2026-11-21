{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<style>
    .drag-handle {
        cursor: grab;
        color: #64748b;
    }

    .drag-handle:active {
        cursor: grabbing;
    }

    .sortable-ghost {
        opacity: 0.3;
        background: #dbeafe !important;
    }

    .sortable-chosen {
        background: #f1f5f9 !important;
    }
</style>
<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">افزودن {$singleName}</h4>
                        {$buttonHelper->refreshAndBackBtn()}
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <form action="/ProformaInvoiceSettings/{if !$getData|default:null}add {else}edit/{$getData.id}{/if}"
                      enctype="multipart/form-data" method="post">
                    {$csrf->csrfTokenInput()}
                    <div class="row">
                        <div class="col-md-7">
                            <div class="card shadow" style="margin-top: 3px">
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="divider divider-left">
                                            <div class="divider-text" style="font-size: 12px">تنظیمات ظاهری</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <label>برند</label>
                                                <select class="form-control select2" id="" name="brand_id">
                                                    <option selected disabled>یک برند انتخاب کنید</option>
                                                    {foreach $brands as $item}
                                                        <option value="{$item.id}">{$item.label}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-4">
                                                <label>لوگو</label>
                                                <input type="file" class="form-control" id="" name="">
                                                <small class="text-danger">در صورتی که این قسمت آپلود شود جایگزین لوگی
                                                    اصلی نمایش داده میشود</small>
                                            </div>
                                            <div class="col-md-4">
                                                <label>عنوان برند</label>
                                                <input class="form-control" id="" name="">
                                                <small class="text-danger">در صورتی که این قسمت پر شود جایگزین نام برند
                                                    اصلی نمایش داده میشود</small>
                                            </div>
                                            <div class="col-md-6">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card shadow" style="margin-top: 3px">
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="divider divider-left">
                                            <div class="divider-text" style="font-size: 12px">متن های پیشفاکتور</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 mt-2">
                                                <div class="divider">
                                                    <div class="divider-text" style="font-size: 12px">متن بالای پیشفاکتور</div>
                                                </div>
                                                <textarea class="form-control joditEditor" id="top_invoice_text" name="top_invoice_text"></textarea>
                                            </div>
                                            <div class="col-md-12 mt-2">
                                                <div class="divider">
                                                    <div class="divider-text" style="font-size: 12px">متن پایین پیشفاکتور</div>
                                                </div>
                                                <textarea class="form-control joditEditor" id="bottom_invoice_text" name="bottom_invoice_text"></textarea>
                                            </div>
                                            <div class="col-md-12 mt-2">
                                                <div class="divider">
                                                    <div class="divider-text" style="font-size: 12px">شرایط پرداخت</div>
                                                </div>
                                                <textarea class="form-control joditEditor" id="payment_terms" name="payment_terms"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5 pl-md-0">
                            <div class="card shadow" style="margin-top: 3px">
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="divider divider-left">
                                            <div class="divider-text" style="font-size: 12px">هزینه و کسورات</div>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover text-center">
                                                <thead class="thead-dark">
                                                <tr>
                                                    <th class="border" width="50">#</th>
                                                    <th class="border" width="100">فعال/غیرفعال</th>
                                                    <th class="border" width="100">جمع خالص</th>
                                                    <th class="border">عنوان</th>
                                                    <th class="border">ضریب</th>
                                                </tr>
                                                </thead>
                                                <tbody id="sortableRows">
                                                {foreach $chargesDeductions as $key=>$item}
                                                    <tr data-id="{$item.id}">
                                                        <td class="border drag-handle">
                                                            {$key+1}
                                                        </td>
                                                        <td class="border drag-handle">
                                                            <div class="checkbox checkbox-primary checkbox-glow">
                                                                <input type="checkbox" value="1" checked
                                                                       name="chargesDeductions[{$item.id}][activeOrDeActive]"
                                                                       id="chargesDeductionsActive_{$item.id}">
                                                                <label for="chargesDeductionsActive_{$item.id}"></label>
                                                            </div>
                                                        </td>
                                                        <td class="border drag-handle">
                                                            <div class="checkbox checkbox-primary checkbox-glow">
                                                                <input type="checkbox" value="0"
                                                                       name="chargesDeductions[{$item.id}][netSum]"
                                                                       id="NetSumActionActive_{$item.id}">
                                                                <label for="NetSumActionActive_{$item.id}"></label>
                                                            </div>
                                                        </td>
                                                        <td class="border drag-handle">
                                                            {$item.title}
                                                        </td>
                                                        <td class="border drag-handle">
                                                            {$item.coefficient}
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card shadow" style="margin-top: 3px">
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="divider divider-left">
                                            <div class="divider-text" style="font-size: 12px">شماره های تماس</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="card shadow" style="margin-top: 3px">
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                            <button type="submit" class="btn btn-sm btn-primary glow">ثبت
                                                اطلاعات
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </form>
            </div>
        </div>
    </div>
</div>
{include 'sections/footer.tpl'}