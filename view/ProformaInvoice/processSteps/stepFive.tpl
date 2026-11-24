{foreach $ProductExitParts as $part}

    {$check = null}

    {if $AddressAnnouncementData}
        {$check = $AddressAnnouncementData->where('product_exit_part_id', $part['id'])->first()}
    {/if}

    {$exist = !empty($check)}
    <form action="/ProformaInvoice/AddressAnnouncement/{$getData['id']}"
          method="POST"
          enctype="multipart/form-data">

        <div class="location-form">
            <input type="hidden" value="{$part['id']}" name="partId">

            <div class="card">
                <div class="card-header">
                    <div class="col-md-12 text-center">
                        <div class="divider">
                            <div class="divider-text">
                                <code>p - {$part['id']}</code> پارت
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="row" dir="rtl">

                            <div class="col-md-3">
                                <label>کشور</label>
                                {if $exist}
                                    <input type="text" disabled class="form-control"
                                           value="{$check->countryData->persian_title}">
                                {else}
                                    <select class="form-control select2 country_id" name="country_id" required>
                                        <option disabled selected>یکی از موارد زیر را انتخاب کنید</option>

                                        {foreach $countries as $data}
                                            <option value="{$data['id']}">{$data['persian_title']}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </div>

                            <div class="col-md-3">
                                <label>استان</label>
                                {if $exist}
                                    <input type="text" disabled class="form-control"
                                           value="{$check->stateData->title}">
                                {else}
                                    <select name="state_id" class="form-control select2 state_id" required
                                            disabled></select>
                                {/if}
                            </div>

                            <div class="col-md-3">
                                <label>شهر</label>
                                {if $exist}
                                    <input type="text" disabled class="form-control"
                                           value="{$check->cityData->title}">
                                {else}
                                    <select name="city_id" class="form-control select2 city_id" required
                                            disabled></select>
                                {/if}
                            </div>

                            <div class="col-md-3">
                                <label>فایل آدرس</label>
                                <div class="input-group">
                                    <input type="file"
                                           class="form-control address_file"
                                           name="address_file"
                                           accept="image/*,.pdf"
                                           required
                                            {if $exist}
                                                disabled
                                            {/if}
                                    >
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-sm btn-primary viewFile"
                                                {if $exist}
                                                    data-id="{$check->id}"
                                                    data-file="{$check['address_file']}"
                                                {/if}
                                        >
                                            <i class="bx bx-file"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <div class="col-md-12">
                        <label>آدرس</label>
                        <textarea class="form-control"
                                  name="address"
                                  cols="30"
                                  rows="5"
                                  style="resize: none"
                                   {if $exist}
                                       disabled
                                   {/if}
                        >{if $exist}{$check->address}{/if}</textarea>
                    </div>
                </div>

                <div class="mt-auto pt-3">
                    {if $exist}
                        <button type="button" class="btn btn-success text-white glow w-100">
                            در تاریخ
                            <code>{(jdate("Y/m/d",strtotime($check->create_at)))}</code>
                            توسط
                            <code>{$check->userData->full_name}</code>
                            اعلام آدرس شد
                        </button>
                    {else}
                        <button type="submit" class="btn btn-primary glow w-100">
                            ثبت اعلام آدرس
                        </button>
                    {/if}
                </div>
            </div>
        </div>
    </form>
    <hr>
{/foreach}

