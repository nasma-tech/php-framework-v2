
{if $getData.productPart->count() <= 0}
    <div class="card shadow-sm">
        <div class="card-body text-center bg-warning  rounded">
            <i class="bx bx-info-circle text-white font-large-2 mb-1"></i>
            <h4 class="mb-0 text-white">هنوز اعلام خروجی ثبت نشده است</h4>
        </div>
    </div>
{else}
    {foreach $getData.productPart as $key => $part}
        {$addressDetail = $addressData[$key]|default:[]}
        {$compair = false}
        {if ($addressDetail['proforma_invoice_id']|default:[] == $getData['id'] && $addressDetail['part_id']|default:[] == $part['id'])}
            {$compair = True}
        {/if}
        <form action="/ProformaInvoice/AddressAnnouncement/{$getData['id']}" method="POST"
              enctype="multipart/form-data">
            <input type="hidden" value="{$part->id}" name="part_number">
            <div class="card shadow">
                <div class="card-body">
                    <div class="divider mt-1">
                        <div class="divider-text">
                            پارت شماره
                            <code>
                                {$number->numberToWords($key + 1)}
                            </code>
                        </div>
                    </div>

                    <div class="row mt-1">
                        <div class="col-md-3">
                            <label>کشور</label>
                            <select name="country_id"
                                    data-key="{$key + 1}"
                                    {if $compair}
                                        class="form-control select2"
                                        disabled
                                    {else}
                                        class="form-control select2 country_id"
                                        required
                                    {/if}
                            >
                                {if $addressData}{/if}
                                <option disabled selected>یکی از موارد زیر رو انتخاب کنید</option>
                                {foreach $countries as $data}
                                    {if $compair}
                                        <option value="{$data['id']}"
                                                {if $addressDetail->cityData->states->country_id == $data['id']}selected{/if}>{$data['persian_title']}</option>
                                    {else}
                                        <option value="{$data['id']}">{$data['persian_title']}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label>استان</label>
                            <select name="state_id"
                                    class="form-control select2 state_id"
                                    data-key="{$key + 1}"
                                    required disabled>
                                <option disabled selected>کشور را انتخاب کنید</option>
                                {if $compair}
                                    <option value="" selected>{$addressDetail->cityData->states->title}</option>
                                {/if}
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label>شهر</label>
                            <select name="city_id"
                                    class="form-control select2 city_id"
                                    data-key="{$key + 1}"
                                    required disabled>
                                <option disabled selected>استان را انتخاب کنید</option>
                                {if $compair}
                                    <option value="" selected>{$addressDetail->cityData->title}</option>
                                {/if}
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>فرم اعلام آدرس</label>
                            <div class="input-group">
                                <input type="file"
                                       class="form-control addressFile"
                                       name="addressFile"
                                       accept="image/*,.pdf"
                                        {if $compair}
                                            disabled
                                        {else}
                                            required
                                        {/if}
                                >