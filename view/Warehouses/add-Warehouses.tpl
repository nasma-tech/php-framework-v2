{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content warehouse-page">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>
                        {$buttonHelper->refreshAndBackButton()}
                    </div>
                    <hr>
                    <div class="card-content">
                        <form action="/Warehouses/add">
                        <div class="card-body">
                            <ul class="nav nav-tabs nav-justified" id="myTab2" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="definision-tab-justified" data-toggle="tab"
                                       href="#definision-just" role="tab" aria-controls="definision-just"
                                       aria-selected="true">
                                        اطلاعات انبار
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="physicalAddress-tab-justified" data-toggle="tab"
                                       href="#physicalAddress-just" role="tab" aria-controls="physicalAddress-just"
                                       aria-selected="true">
                                        آدرس انبار
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab-justified" data-toggle="tab"
                                       href="#ownership-just" role="tab" aria-controls="profile-just"
                                       aria-selected="true">
                                        مالکیت انبار
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="team-tab-justified" data-toggle="tab" href="#team-just"
                                       role="tab" aria-controls="team-just" aria-selected="false">
                                        تیم انبار
                                    </a>
                                </li>
                            </ul>
                            <!-- Tab panes -->
                            <div class="tab-content pt-1">
                                <div class="tab-pane active" id="definision-just" role="tabpanel"
                                     aria-labelledby="definision-tab-justified">
                                    <div class="col-md-12 row">
                                        <div class="col-md-3">
                                            <label for="wareHouseName">عنوان انبار</label>
                                            <input class="form-control" type="text" name="wareHouseName" required>
                                        </div>
                                        <div class="col-md-3">
                                            <label for="warehouseBrand">برند</label>
                                            <select name="warehouseBrand" required class="form-control select2">
                                                <option disabled selected>یکی از موارد را انتخاب کنید</option>
                                                {foreach $brands As $data}
                                                    <option value="{$data['id']}">{$data['label']}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <label for="warehouseBrand">نوع انبار</label>
                                            <select name="warehouseBrand" required class="form-control select2">
                                                <option disabled selected>یکی از موارد را انتخاب کنید</option>
                                                {foreach $warehouseType As $data}
                                                    <option value="{$data['id']}">{$data['label']}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <label for="warehouseBrand">کاربرد انبار</label>
                                            <select name="warehouseBrand" required class="form-control select2">
                                                <option disabled selected>یکی از موارد را انتخاب کنید</option>
                                                {foreach $brands As $data}
                                                    <option value="{$data['id']}">{$data['label']}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="physicalAddress-just" role="tabpanel"
                                     aria-labelledby="physicalAddress-tab-justified">
                                    <div class="col-md-12 row">
                                        <div class="col-md-2">
                                            <label for="country_id">کشور</label>
                                            <select class="form-control select2" name="country_id" id="country_id">
                                                <option disabled selected>یکی از موارد زیر را انتخاب کنید</option>
                                                {foreach $countries as $data}
                                                    <option value="{$data['id']}">{$data['persian_title']}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="state_id">استان</label>
                                            <select name="state_id" id="state_id" class="form-control select2"
                                                    disabled></select>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="city_id">شهر</label>
                                            <select name="city_id" id="city_id" class="form-control select2"
                                                    disabled></select>
                                        </div>
                                        <div class="col-md-3">
                                            <label for="post_code">کد پستی</label>
                                            <input type="text" name="post_code" class="form-control" id="post_code">
                                        </div>
                                        <div class="col-md-3">
                                            <label for="post_code">شماره تلفن ثابت انبار</label>
                                            <div class="input-group">
                                                <input type="text" name="warehousePhoneNumber" class="form-control"
                                                       id="warehousePhoneNumber">
                                                <div class="input-group-append">
                                                    <span class="input-group-text" id="area_code" dir="ltr"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mt-2">
                                        <label for="wareHouceFullAdress">آدرس </label>
                                        <textarea class="form-control" style="resize: none" id="wareHouceFullAdress"
                                                  name="wareHouceFullAdress"></textarea>
                                    </div>
                                </div>
                                <div class="tab-pane" id="ownership-just" role="tabpanel"
                                     aria-labelledby="ownership-tab-justified">
                                    <div class="card-body">
                                        <ul class="nav nav-tabs justify-content-center" role="tablist">
                                            {foreach $personTypes as $key => $data}
                                                <li class="nav-item current">
                                                    <button type="radio" class="nav-link {if $key == 1}active{/if}"
                                                            id="{$data['tag_label']}-tab-center" data-id="{$data['id']}"
                                                            data-toggle="tab" href="#{$data['tag_label']}-center"
                                                            aria-controls="{$data['tag_label']}-center" role="tab"
                                                            aria-selected="false"
                                                            name="person_type"
                                                    >
                                                        {$data['label']}
                                                    </button>
                                                </li>
                                            {/foreach}
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="Legal-center"
                                                 aria-labelledby="Legal-tab-center" role="tabpanel">

                                                <div class="col-md-12 row">
                                                    <div class="col-md-3">
                                                        <label for="full_name">نام کامل سازمان</label>
                                                        <input type="text" class="form-control" name="full_name"
                                                               id="full_name">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label for="registration_date">تاریخ ثبت</label>
                                                        <input type="text" class="form-control" name="registration_date"
                                                               id="registration_date">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label for="registration_number">شماره ثبت</label>
                                                        <input type="text" class="form-control"
                                                               name="registration_number" id="registration_number">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label for="national_code">شناسه ملی</label>
                                                        <input type="text" class="form-control" name="national_code"
                                                               id="national_code">
                                                    </div>
                                                    <div class="col-md-3 mt-2">
                                                        <label for="economic_code">کد اقتصادی</label>
                                                        <input type="text" class="form-control" name="economic_code"
                                                               id="economic_code">
                                                    </div>
                                                    <div class="col-md-3 mt-2">
                                                        <label for="postal_code">کد پستی</label>
                                                        <input type="text" class="form-control" name="postal_code"
                                                               id="postal_code">
                                                    </div>
                                                    <div class="col-md-3 mt-2">
                                                        <label for="">صاحبین امضا</label>
                                                        <select multiple="multiple" name="person_type[]" class="form-control select2" id="personType">
                                                        </select>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <label for="customer_company_address"></label>
                                                        <input type="text" class="form-control"
                                                               name="customer_company_address"
                                                               id="customer_company_address">
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="tab-pane" id="naturalPerson-center"
                                                 aria-labelledby="naturalPerson-tab-center" role="tabpanel">
                                                <div class="col-md-12 row">
                                                    <div class="col-md-2">
                                                        <label for="full_name">نام مالک</label>
                                                        <input type="text" class="form-control" name="full_name">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label for="national_code">کد ملی</label>
                                                        <input type="text" class="form-control" name="national_code"
                                                               id="national_code">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label for="birth_date">تاریخ تولد</label>
                                                        <input type="text" class="form-control" name="birth_date"
                                                               id="birth_date">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label for="email">ایمیل</label>
                                                        <input type="email" class="form-control" name="email">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label for="owner_date">تاریخ مالکیت</label>
                                                        <input type="text" class="form-control" name="owner_date"
                                                               id="owner_date">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label for="owner_document">سند مالکیت</label>
                                                        <div class="input-group">
                                                            <input type="file" class="form-control"
                                                                   name="owner_document" id="owner_document">
                                                            <div class="input-group-append" id="showDucomnet">
                                                                <span class="input-group-text"><i
                                                                            class="bx bxs-file"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="team-just" role="tabpanel"
                                     aria-labelledby="team-tab-justified">
                                    <form action="/Warehouses/addTeam" method="post" id="mainForm">

                                        <div class="card shadow">
                                            <div class="card-content">
                                                <div class="card-header">
                                                    <button class="btn btn-xs btn-primary float-right" type="button" style="margin-right: 0.35rem"
                                                            id="btnAddRoot"><i
                                                                class="bx bx-plus" style="font-size: 0.9rem"></i>افزودن Root جدید
                                                    </button>
                                                    <button class="btn btn-xs btn-danger float-right" type="button" style="margin-right: 0.35rem"
                                                            id="btnUndo"><i
                                                                class="bx bx-undo" style="font-size: 0.9rem"></i>Undo
                                                    </button>
                                                    <button class="btn btn-xs btn-success float-right" type="button" style="margin-right: 0.35rem"
                                                            id="btnRedo"><i
                                                                class="bx bx-redo" style="font-size: 0.9rem"></i>Redo
                                                    </button>
                                                    <button class="hidden" id="btnExport">Export JSON</button>
                                                    <button class="hidden" id="btnImport">Import JSON</button>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <label>عنوان تیم</label>
                                                            <input class="form-control" id="team_title" name="team_title">
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <div id="orgChartDiv" dir="ltr"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card shadow mt-1">
                                            <div class="card-content">
                                                <div class="card-body">

                                                    {$csrf->csrfTokenInput()}

                                                    <input name="jsonOutput" type="hidden" id="jsonOutput" value=''>

                                                    <button class="btn btn-sm btn-primary" type="submit" id="submit">ثبت تیم</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}