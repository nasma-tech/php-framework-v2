{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>
                        {$flashMessageHelper->formCallBack()}
                    </div>
                </div>
            </div>
        </div>
        <form id="mainForm" enctype="multipart/form-data">
            {$csrf->csrfTokenInput()}
            <div class="card mt-1 shadow">
                <div class="card-body">
                    <input type="hidden" value="person" id="marketer_type" name="marketer_type">
                    <ul class="nav nav-tabs justify-content-center" role="tablist">
                        <li class="nav-item current">
                            <a class="nav-link marketerTypeButton active" id="person-tab-center" data-toggle="tab"
                               href="#person"
                               aria-controls="person" role="tab" aria-selected="true">
                                حقیقی
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link marketerTypeButton" id="legal-tab-center" data-toggle="tab" href="#legal"
                               aria-controls="legal" role="tab" aria-selected="false">
                                حقوقی
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="person" aria-labelledby="person-tab-center"
                             role="tabpanel">
                            <div class="row">
                                <div class="col-md-3 mt-2 genderMain">
                                    <label>جنسیت</label>
                                    <select class="form-control select2" name="marketer_gender" required>
                                        <option selected disabled>لطفا یک مورد را انتخاب کنید</option>
                                        <option value="Mr">آقا</option>
                                        <option value="Mrs">خانم</option>
                                    </select>
                                </div>
                                <div class="col-md-3 mt-2">
                                    <label>نام و نام خانوادگی</label>
                                    <input class="form-control" name="marketer_full_name" required>
                                </div>
                                <div class="col-md-3 mt-2">
                                    <label>تاریخ تولد</label>
                                    <input class="form-control" id="birth_date" readonly name="birth_date" required>
                                </div>
                                <div class="col-md-3 mt-2">
                                    <label>شماره ملی</label>
                                    <input class="form-control" dir="ltr" name="marketer_national_code"
                                           id="marketer_national_code" required>
                                </div>
                                <div class="col-md-4 mt-2">
                                    <label>تصویر روی کارت ملی</label>
                                    <div class="input-group">
                                        <input class="form-control" type="file"
                                               name="front_national_card_image"
                                               id="front_national_card_image">
                                        <div class="input-group-append">
                                            <button class="bn btn-sm btn-primary viewFront_national_card_image"
                                                    type="button"><i class="bx bx-file"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 mt-2">
                                    <label>تصویر پشت کارت ملی</label>
                                    <div class="input-group">
                                        <input class="form-control" type="file"
                                               name="back_national_card_image"
                                               id="back_national_card_image">
                                        <div class="input-group-append">
                                            <button class="bn btn-sm btn-primary viewBack_national_card_image"
                                                    type="button"><i class="bx bx-file"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 mt-2">
                                    <label>تصویر قرارداد امضا شده</label>
                                    <div class="input-group">

                                    <input class="form-control" type="file"  name="contract_image"
                                           id="contract_image">
                                        <div class="input_group_append">
                                            <button class="bn btn-sm btn-primary viewContract_image"
                                                    type="button"><i class="bx bx-file"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="legal" aria-labelledby="legal-tab-center" role="tabpanel">
                            <div class="row">
                                <div class="col-md-3 mt-2">
                                    <label>شناسه ملی</label>
                                    <input class="form-control" dir="ltr" name="company_national_code"
                                           id="company_national_code" maxlength="11">
                                </div>
                                <div class="col-md-3 mt-2">
                                    <label>نام شرکت</label>
                                    <input class="form-control" name="company_name" id="company_name">
                                </div>
                                <div class="col-md-2 mt-2">
                                    <label>تاریخ ثبت</label>
                                    <input class="form-control" name="registration_date" id="registration_date">
                                </div>
                                <div class="col-md-2 mt-2">
                                    <label>نام و نام خانودگی مدیر عامل</label>
                                    <input class="form-control" name="ceo_full_name"
                                           id="ceo_full_name">
                                </div>
                                <div class="col-md-2 mt-2">
                                    <label>نام و نام خانودگی رابط</label>
                                    <input class="form-control" name="connector_full_name" id="connector_full_name">
                                </div>
                                <div class="col-md-4 mt-2">
                                    <label>تصویر قرارداد امضا شده</label>
                                    <input class="form-control" type="file" dir="ltr" name="contract_image_legal"
                                           id="contract_image_legal">
                                </div>
                                <div class="col-md-4 mt-2">
                                    <label>تصویر آخرین روزنامه رسمی</label>
                                    <input class="form-control" type="file" dir="ltr" name="official_newspaper_image"
                                           id="official_newspaper_image">
                                </div>
                                <div class="col-md-4 mt-2">
                                    <label>تصویر گواهی آخرین تغییرات</label>
                                    <input class="form-control" type="file" dir="ltr" name="last_changes_image"
                                           id="last_changes_image">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mt-1 shadow">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 mt-2">
                            <label>گروه بازاریابی</label>
                            <div class="input-group">
                                <select class="form-control" name="marketing_group_id"
                                        id="marketing_group_id">
                                    <option value="" disabled selected>یکی از موارد رو انتخاب کنید</option>
                                    {foreach $marketingGroups as $data}
                                        <option value="{$data['id']}">{$data['title']}</option>
                                    {/foreach}
                                </select>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-sm btn-primary"
                                            data-toggle="modal" data-target="#marketingGroupModal">
                                        <i class="bx bx-cog"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 mt-2">
                            <label>کارشناس</label>
                            <select class="form-control select2" name="expert_id" id="expert_id">
                                <option selected disabled>لطفا یک کارشناس را انتخاب کنید</option>
                                {foreach $experts as $expert}
                                    <option value="{$expert.id}">{$expert.full_name}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="col-md-3 mt-2">
                            <label>استان</label>
                            <select class="form-control select2" name="state_id" id="state_id" required>
                                <option selected disabled>لطفا یک مورد را انتخاب کنید</option>
                                {foreach $states as $item}
                                    <option value="{$item->id}">{$item->title}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="col-md-3 mt-2">
                            <label>شهر</label>
                            <select class="form-control select2" name="city_id" id="city_id" disabled></select>
                        </div>
                        <div class="col-md-1 mt-2">
                            <label>درصد کمیسیون</label>
                            <div class="input-group">
                                <input type="text" class="form-control text-center" name="commissionPercentage"
                                       id="commissionPercentage" required>
                                <div class="input-group-append">
                                    <span class="input-group-text">%</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mt-2">
                            <label>شماره کارت</label>
                            <input class="form-control text-center" dir="ltr" name="marketer_cardNumber"
                                   id="marketer_cardNumber">
                        </div>
                        <div class="col-md-3 mt-2">
                            <label>بانک</label>
                            <select class="form-control select2" id="bank_name" name="bank_name">
                                <option value="" disabled selected>یکی از موارد را انتخاب کنید</option>
                                {foreach $bankData as $data}
                                    <option value="{$data['id']}">{$data['title']}</option>
                                {/foreach}
                            </select>

                        </div>
                        <div class="col-md-2 mt-2">
                            <label>شماره حساب</label>
                            <input class="form-control" dir="ltr" name="marketer_accountNumber"
                                   id="marketer_accountNumber">
                        </div>
                        <div class="col-md-3 mt-2">
                            <label>شماره شبا</label>
                            <div class="input-group">
                                <input type="text" class="form-control" dir="ltr" name="marketer_shebaNumber"
                                       id="marketer_shebaNumber">
                                <div class="input-group-append">
                                    <span class="input-group-text">IR</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 mt-2">
                            <label>آدرس</label>
                            <textarea class="form-control" name="marketer_address" rows="3" style="resize: none"
                            ></textarea>
                        </div>
                        <div class="col-md-6 mt-2 border">
                            <label class="mt-2">شماره تماس ثابت</label>
                            <div class="row mb-5 mainPhone">
                                <div class="col-lg-12 mt-2">
                                    <button type="button" class="btn btn-primary btn-sm addPhoneButton"
                                            data-original-title="افزودن فیلد شماره تماس ثابت"><i class="bx bx-plus"></i>
                                    </button>
                                </div>
                                <div class="col-md-6 mt-2">
                                    <label>شماره تماس ثابت</label>
                                    <input class="form-control" name="marketer_phones[]" required>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mt-2 border">
                            <label class="mt-2">شماره همراه</label>
                            <div class="row mb-5 mainMobile">
                                <div class="col-lg-12 mt-2">
                                    <button type="button" class="btn btn-primary btn-sm addMobileButton"
                                            data-toggle="tooltip" data-placement="left" title=""
                                            data-original-title="افزودن فیلد شماره موبایل"><i class="bx bx-plus"></i>
                                    </button>
                                </div>
                                <div class="col-md-6 mt-2">
                                    <label>شماره موبایل</label>
                                    <input class="form-control" name="marketer_mobiles[]" required>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 mt-2">
                        <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                            <button
                                    class="btn btn-primary btn-sm glow mb-1 mb-sm-0 mr-0 mr-sm-1">ثبت
                                اطلاعات
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </div>
</div>


{include 'sections/footer.tpl'}
<div class="modal fade" id="marketingGroupModal" tabindex="-1" role="dialog"
     aria-labelledby="marketingGroupModalLabel" aria-hidden="true">

    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="marketingGroupModalLabel">
                    مدیریت گروه‌های بازاریابی
                </h5>

                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <div id="marketingGroupContent">
                    <div class="text-center p-3">
                        در حال دریافت اطلاعات...
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                    بستن
                </button>
            </div>

        </div>
    </div>
</div>