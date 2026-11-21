
{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}

        <div class="row">
            <div class="col-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title float-right">افزودن {$singleName} جدید</h4>
                        {$buttonHelper->refreshAndBackButton()}
                    </div>

                    <div class="card-content">
                        <div class="card-body">
                            <form action="add" method="POST" enctype="multipart/form-data">
                                {$csrf->csrfTokenInput()}

                                <input type="hidden" name="marketer_type" id="marketer_type" value="1">

                                <ul class="nav nav-pills nav-justified mb-3" id="marketerInfoTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#personalInfo" role="tab">
                                            اطلاعات شخص
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#generalInfo" role="tab">
                                            اطلاعات عمومی و همکاری
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#bankInfo" role="tab">
                                            اطلاعات بانکی
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#contactInfo" role="tab">
                                            اطلاعات تماس و آدرس
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#documentsInfo" role="tab">
                                            مدارک و مستندات
                                        </a>
                                    </li>
                                </ul>

                                <div class="tab-content pt-2">

                                    {* اطلاعات شخص حقیقی و حقوقی *}
                                    <div class="tab-pane fade show active" id="personalInfo" role="tabpanel">

                                        <ul class="nav nav-tabs nav-justified mb-3" id="marketerTypeTab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active"
                                                   data-toggle="tab"
                                                   href="#natural"
                                                   role="tab"
                                                   data-type="1">
                                                    حقیقی
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link"
                                                   data-toggle="tab"
                                                   href="#legal"
                                                   role="tab"
                                                   data-type="2">
                                                    حقوقی
                                                </a>
                                            </li>
                                        </ul>

                                        <div class="tab-content" id="marketerTypeContent">

                                            <div class="tab-pane fade show active" id="natural" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-md-4 form-group">
                                                        <label>نام و نام خانوادگی</label>
                                                        <input type="text" name="marketer_full_name" class="form-control">
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label>کد ملی</label>
                                                        <input type="text" name="marketer_national_code" class="form-control">
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label>جنسیت</label>
                                                        <select name="marketer_gender" class="form-control">
                                                            <option value="">انتخاب کنید</option>
                                                            <option value="1">مرد</option>
                                                            <option value="2">زن</option>
                                                        </select>
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label>تاریخ تولد</label>
                                                        <input type="text" name="birth_date" class="form-control">
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label>تصویر روی کارت ملی</label>
                                                        <input type="file" name="front_national_card_image" class="form-control-file" accept="image/*">
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label>تصویر پشت کارت ملی</label>
                                                        <input type="file" name="back_national_card_image" class="form-control-file" accept="image/*">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="legal" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-md-4 form-group">
                                                        <label>نام شرکت</label>
                                                        <input type="text" name="company_name" class="form-control">
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label>شناسه ملی شرکت</label>
                                                        <input type="text" name="company_national_code" class="form-control">
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label>تاریخ ثبت شرکت</label>
                                                        <input type="text" name="registration_date" class="form-control">
                                                    </div>

                                                    <div class="col-md-6 form-group">
                                                        <label>نام مدیرعامل</label>
                                                        <input type="text" name="ceo_full_name" class="form-control">
                                                    </div>

                                                    <div class="col-md-6 form-group">
                                                        <label>نام رابط شرکت</label>
                                                        <input type="text" name="connector_full_name" class="form-control">
                                                    </div>

                                                    <div class="col-md-6 form-group">
                                                        <label>روزنامه رسمی</label>
                                                        <input type="file" name="official_newspaper_image" class="form-control-file" accept="image/*,.pdf">
                                                    </div>

                                                    <div class="col-md-6 form-group">
                                                        <label>قرارداد حقوقی</label>
                                                        <input type="file" name="contract_image_legal" class="form-control-file" accept="image/*,.pdf">
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                    {* اطلاعات عمومی و همکاری *}
                                    <div class="tab-pane fade" id="generalInfo" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-4 form-group">
                                                <label>گروه بازاریابی</label>
                                                <div class="input-group">
                                                    <select name="marketing_group_id" class="form-control">
                                                        <option value="">انتخاب گروه</option>
                                                        {foreach $marketingGroups|default:[] as $group}
                                                            <option value="{$group.id}">{$group.title}</option>
                                                        {/foreach}
                                                    </select>

                                                    <div class="input-group-append">
                                                        <button type="button" class="btn btn-outline-primary"
                                                                data-toggle="modal" data-target="#marketingGroupModal">
                                                            مدیریت گروه‌ها
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-4 form-group">
                                                <label>درصد پورسانت</label>
                                                <div class="input-group">
                                                    <input type="number" name="commissionPercentage"
                                                           class="form-control" min="0" max="100" step="0.01">
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">%</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-4 form-group">
                                                <label>کارشناس مربوطه</label>
                                                <select name="expert_id" class="form-control">
                                                    <option value="">انتخاب کارشناس</option>
                                                    {foreach $experts|default:[] as $expert}
                                                        <option value="{$expert.id}">{$expert.full_name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    {* اطلاعات بانکی *}
                                    <div class="tab-pane fade" id="bankInfo" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-3 form-group">
                                                <label>بانک</label>
                                                <select name="bank_id" class="form-control">
                                                    <option value="">انتخاب بانک</option>
                                                    {foreach $banks|default:[] as $bank}
                                                        <option value="{$bank.id}">{$bank.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>

                                            <div class="col-md-3 form-group">
                                                <label>شماره حساب</label>
                                                <input type="text" name="marketer_accountNumber" class="form-control">
                                            </div>

                                            <div class="col-md-3 form-group">
                                                <label>شماره شبا</label>
                                                <input type="text" name="marketer_shebaNumber" class="form-control">
                                            </div>

                                            <div class="col-md-3 form-group">
                                                <label>شماره کارت</label>
                                                <input type="text" name="marketer_cardNumber" class="form-control">
                                            </div>
                                        </div>
                                    </div>

                                    {* اطلاعات تماس و آدرس *}
                                    <div class="tab-pane fade" id="contactInfo" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-4 form-group">
                                                <label>استان</label>
                                                <select name="state_id" id="state_id" class="form-control">
                                                    <option value="">انتخاب استان</option>
                                                    {foreach $states|default:[] as $state}
                                                        <option value="{$state.id}">{$state.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>

                                            <div class="col-md-4 form-group">
                                                <label>شهر</label>
                                                <select name="city_id" id="city_id" class="form-control">
                                                    <option value="">ابتدا استان را انتخاب کنید</option>
                                                </select>
                                            </div>

                                            <div class="col-md-4 form-group">
                                                <label>تلفن ثابت</label>
                                                <input type="text" name="marketer_phones" class="form-control">
                                            </div>

                                            <div class="col-md-4 form-group">
                                                <label>شماره موبایل</label>
                                                <input type="text" name="marketer_mobiles" class="form-control">
                                            </div>

                                            <div class="col-md-8 form-group">
                                                <label>آدرس</label>
                                                <textarea name="marketer_address" class="form-control" rows="2"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    {* مدارک و مستندات *}
                                    <div class="tab-pane fade" id="documentsInfo" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6 form-group">
                                                <label>تصویر قرارداد</label>
                                                <input type="file" name="contract_image" class="form-control-file" accept="image/*,.pdf">
                                            </div>

                                            <div class="col-md-6 form-group">
                                                <label>تصویر آخرین تغییرات</label>
                                                <input type="file" name="last_changes_image" class="form-control-file" accept="image/*,.pdf">
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="text-right mt-3">
                                    <button type="submit" class="btn btn-primary">
                                        ثبت بازاریاب
                                    </button>
                                    <a href="index" class="btn btn-light">بازگشت</a>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{* Modal مدیریت گروه‌های بازاریابی *}
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

<script>

</script>

{include 'sections/footer.tpl'}
