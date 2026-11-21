<div class="card-body ownership">
        <ul class="nav nav-tabs justify-content-center" role="tablist">
        {foreach $personTypes as $key => $data}
            <li class="nav-item current">
                <button type="radio" class="nav-link {if $key == 1}active{/if}"
                        id="{$data['tag_label']}-tab-center"
                        data-id="{$data['id']}"
                        data-toggle="tab"
                        href="#{$data['tag_label']}-center"
                        aria-controls="{$data['tag_label']}-center" role="tab"
                        aria-selected="false"
                        name="person_type">
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
                    <input type="text" class="form-control"
                           name="registration_date"
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
                    <select multiple="multiple" name="person_type[]"
                            class="form-control select2" id="personType">
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
                            <span class="input-group-text"><i class="bx bxs-file"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>