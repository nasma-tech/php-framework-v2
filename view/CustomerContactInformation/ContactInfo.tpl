<div class="card shadow cc-initial-info" style="margin-top: 2px;height: 100%">
    <div class="card-content">
        <div class="card-header">
            <div class="divider divider-left">
                <div class="divider-text" style="font-size: 11px">اطلاعات اولیه</div>
            </div>
        </div>
        <div class="card-body">
            <input type="hidden" readonly="readonly" id="contact_type" name="contact_type" value="">
            <div class="row mb-4">
                <div class="col-md-6">
                    <button class="btn btn-sm btn-light-primary {(($contactData.contact_type|default:'') == 1) ? 'active' : ''} w-100 selectContactTypeButton"
                            type="button"
                            data-type="real">حقیقی
                    </button>
                </div>
                <div class="col-md-6 pl-md-0">
                    <button class="btn btn-sm btn-light-primary {(($contactData.contact_type|default:'') == 2) ? 'active' : ''} w-100 selectContactTypeButton"
                            type="button"
                            data-type="legal">
                        حقوقی
                    </button>
                </div>
            </div>
            <div class="row" id="mainContactForm">
                <div class="col-md-4">
                    <label for="first_name">نام</label>
                    <input class="form-control" required="required" id="first_name" name="first_name"
                           value="{$contactData.first_name|default:''}">
                </div>
                <div class="col-md-4">
                    <label for="last_name">نام خانوادگی</label>
                    <input class="form-control" required="required" id="last_name" name="last_name"
                           value="{$contactData.last_name|default:''}">
                </div>
                <div class="col-md-4">
                    <label for="contact_group_id">گروه مشتری</label>
                    <select class="form-control select2" required="required" id="contact_group_id" name="contact_group_id">
                        <option selected disabled>یک مورد را انتخاب کنید</option>
                        {foreach $ContactGroups|default:[] as $item}
                            <option value="{$item->id}"{(($contactData.contact_group_id|default:'') == $item.id) ? 'selected' : ''}>{$item.title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-4 mt-2">
                    <label for="contact_acquisition_source_id">نحوه آشنایی</label>
                    <select class="form-control select2" required="required" id="contact_acquisition_source_id"
                            name="contact_acquisition_source_id">
                        <option selected disabled>یک مورد را انتخاب کنید</option>
                        {foreach $ContactAcquisitionSources|default:[] as $item}
                            <option value="{$item.id}"{(($contactData.contact_acquisition_source_id|default:'') == $item.id)?'selected':''}>{$item.title}</option>
                        {/foreach}
                    </select>
                </div>
                {if (($contactData.contact_type|default:'') == 1)}
                    <div class="col-md-4 mt-2">
                        <label for="national_code">کد ملی</label>
                        <input class="form-control" value="{$contactData.national_code|default:''}"
                               id="national_code" name="national_code">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="state_id">استان محل سکونت</label>
                        <select class="form-control select2" required="required" id="state_id" name="state_id">
                            <option selected disabled>یک استان را انتخاب کنید</option>
                            {foreach $states as $item}
                                <option value="{$item.id}"{(($contactData.state_id|default:'') == $item.id)?'selected':''}>{$item.title}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="city_id">شهر محل سکونت</label>
                        <select class="form-control select2" required="required" id="city_id" name="city_id">
                            {foreach $cities as $item}
                                <option value="{$item.id}"{(($contactData.city_id) == $item.id)?'selected':''}>{$item.title}</option>
                            {/foreach}
                        </select>
                    </div>
                {else}
                    <div class="col-md-4 mt-2">
                        <label for="national_ID">شناسه ملی</label>
                        <input class="form-control" id="national_ID" name="national_ID">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="economic_code">کد اقتصادی</label>
                        <input class="form-control" id="economic_code" name="economic_code">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="company_name">عنوان شرکت</label>
                        <input class="form-control" id="company_name" name="company_name">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="establishment_date">تاریخ تاسیس</label>
                        <input class="form-control" id="establishment_date" name="establishment_date">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="company_status">وضعیت</label>
                        <input class="form-control" id="company_status" name="company_status">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="registration_number">تاریخ ثبت</label>
                        <input class="form-control" id="registration_number" name="registration_number">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="address">آدرس</label>
                        <input class="form-control" id="address" name="address">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label for="postal_code">کدپستی</label>
                        <input class="form-control" id="postal_code" name="postal_code">
                    </div>
                {/if}
            </div>
        </div>
    </div>
    {if isset($contactData) && ($smarty.session.roleId == 0 || $smarty.session.userId == $contactData.userId)}
        <div class="card-footer">
            <button class="btn btn-sm btn-primary float-right">ویرایش اطلاعات اولیه</button>
        </div>
    {/if}
</div>
