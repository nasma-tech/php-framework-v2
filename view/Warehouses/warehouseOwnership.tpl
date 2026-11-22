<div class="card-body ownership">
    <input type="hidden" name="person_type" id="person_type">
    <ul class="nav nav-tabs justify-content-center" role="tablist">
        {foreach $personTypes as $key => $data}
            <li class="nav-item {(($key == 0) ? 'current' : '')}">
                <button class="nav-link {(($key == 0) ? 'active' : '')} changePersonTypeButton"
                        id="{$data['tag_label']}-tab-center"
                        data-id="{$data['id']}"
                        data-toggle="tab"
                        href="#{$data['tag_label']}-center"
                        aria-controls="{$data['tag_label']}-center" role="tab"
                        aria-selected="false"
                        data-value="{$data.id}">
                    {$data['label']}
                </button>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content" id="ownerDetailData">
        {foreach $personTypes as $key => $data}
            {if $data.id == 1}
                <div class="tab-pane ownerDetailDatum_{$data.id} active" id="naturalPerson-center"
                     aria-labelledby="naturalPerson-tab-center" role="tabpanel">
                    <div class="col-md-12 row">
                        <div class="col-md-2">
                            <label for="owner_full_name">نام مالک</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][owner_full_name]" id="owner_full_name">
                        </div>
                        <div class="col-md-2">
                            <label for="national_id">کد ملی</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][national_id]"
                                   id="national_id">
                        </div>
                        <div class="col-md-2">
                            <label for="owner_email">ایمیل</label>
                            <input type="email" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][owner_email]" id="owner_email">
                        </div>
                        <div class="col-md-2">
                            <label for="owner_date">تاریخ مالکیت</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][owner_date]"
                                   id="owner_date">
                        </div>
                        <div class="col-md-2">
                            <label for="owner_postal_code">کد پستی</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][owner_postal_code]"
                                   id="owner_postal_code">
                        </div>
                        <div class="col-md-2">
                            <label for="owner_document">سند مالکیت</label>
                            <div class="input-group">
                                <input type="file" class="form-control ownersInput_{$data.id}"
                                       name="owner_document" id="owner_document">
                                <div class="input-group-append" id="showDocument">
                                    <span class="input-group-text"><i class="bx bxs-file"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {elseif $data.id == 2}
                <div class="tab-pane ownerDetailDatum_{$data.id}" id="Legal-center"
                     aria-labelledby="Legal-tab-center" role="tabpanel">

                    <div class="col-md-12 row">
                        <div class="col-md-3">
                            <label for="company_full_name">نام کامل سازمان</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][company_full_name]"
                                   id="company_full_name">
                        </div>
                        <div class="col-md-3">
                            <label for="company_registration_date">تاریخ ثبت</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][company_registration_date]"
                                   id="company_registration_date">
                        </div>
                        <div class="col-md-3">
                            <label for="company_registration_number">شماره ثبت</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][company_registration_number]"
                                   id="company_registration_number">
                        </div>
                        <div class="col-md-3">
                            <label for="company_national_code">شناسه ملی</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][company_national_code]"
                                   id="company_national_code">
                        </div>
                        <div class="col-md-3 mt-2">
                            <label for="company_economic_code">کد اقتصادی</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][company_economic_code]"
                                   id="company_economic_code">
                        </div>
                        <div class="col-md-3 mt-2">
                            <label for="company_postal_code">کد پستی</label>
                            <input type="text" class="form-control ownersInput_{$data.id}"
                                   name="owners_data[{$data.id}][company_postal_code]"
                                   id="company_postal_code">
                        </div>
                        <div class="col-md-3 mt-2">
                            <label for="authorized_signatories">صاحبین امضا</label>
                            <select multiple="multiple" name="owners_data[{$data.id}][authorized_signatories][]"
                                    class="form-control ownersInput_{$data.id} select2" id="authorized_signatories">
                            </select>
                        </div>
                        <div class="col-md-12 mt-1">
                            <label for="customer_company_address">آدرس شرکت</label>
                            <textarea type="text" class="form-control ownersInput_{$data.id}"
                                      name="owners_data[{$data.id}][customer_company_address]" rows="6"
                                      id="customer_company_address" style="resize: none"></textarea>
                        </div>

                    </div>
                </div>
            {/if}
        {/foreach}
    </div>
</div>