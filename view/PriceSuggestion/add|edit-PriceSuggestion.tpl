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
                        </h4>
                        {$buttonHelper->refreshAndBackButton()}
                    </div>
                </div>
            </div>
        </div>
        <form action="/PriceSuggestion/addPriceSuggestion/{$contactProjectData.id}/{$contactProjectFollowUpData.id}" method="post" enctype="multipart/form-data">
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
                                        <select class="form-control select2" id="sale_team_id" name="sale_team_id"></select>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="">برند</label>
                                        <select class="form-control select2" id="brand_id" name="brand_id">
                                            <option selected disabled>یک مورد را انتخاب کنید</option>
                                            {foreach $brands as $item}
                                                <option value="{$item.id}">{$item.label}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="">تاریخ صدور</label>
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
                                                <option value="{$item.id}"{($item.id == 102) ? 'selected' : ''}>{$item.persian_title}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="col-md-4 mt-2">
                                        <label for="">استان</label>
                                        <select class="form-control select2" id="state_id" name="state_id" required>
                                            <option selected disabled>یک استان انتخاب کنید</option>
                                            {foreach $states as $item}
                                                <option value="{$item.id}">{$item.title}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="col-md-4 mt-2">
                                        <label for="">شهر</label>
                                        <select class="form-control select2" id="city_id" name="city_id" disabled
                                                required></select>
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
                                                <tbody id="mainProduct"></tbody>
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
                                        <textarea class="form-control" rows="8" style="resize: none" id="description" name="description"></textarea>
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
                                <button type="submit" class="btn btn-sm btn-primary glow">صدور {$singleName}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


{include 'sections/footer.tpl'}