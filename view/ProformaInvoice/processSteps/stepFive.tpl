{foreach $ProductExitParts as $part}
    <form action="/ProformaInvoice/AddressAnnouncement/{$getData['id']}" method="POST">
        <input type="hidden" value="{$part['id']}" name="partId">
        <div class="card">
            <div class="card-header">
                <div class="col-md-12 text-center">
                    <div class="divider">
                        <div class="divider-text"><code>p - {$part['id']}</code> پارت</div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="row" dir="rtl">
                        <div class="col-md-3">
                            <label for="country_id">کشور</label>
                            <select class="form-control select2" name="country_id" id="country_id" required>
                                <option disabled selected>یکی از موارد زیر را انتخاب کنید</option>
                                {foreach $countries as $data}
                                    <option value="{$data['id']}">{$data['persian_title']}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="state_id">استان</label>
                            <select name="state_id" id="state_id" class="form-control select2" required
                                    disabled>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="city_id">شهر</label>
                            <select name="city_id" id="city_id" class="form-control select2" required
                                    disabled></select>
                        </div>
                        <div class="col-md-3">
                                <label for="address_file_{$key}">فایل آدرس</label>
                            <div class="input-group">
                                <input type="file" class="form-control address_file" name="address_file"
                                       id="address_file_{$key}" required>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-sm btn-light viewFile" data-id="address_file_{$key}">
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
                    <label for="address">آدرس</label>
                    <textarea class="form-control" name="address" id="address" cols="30" rows="10"
                              style="resize: none"></textarea>
                </div>
            </div>
        </div>
        <div class="mt-auto pt-3">
            <button class="btn btn-primary glow w-100">ثبت {$singleName}</button>
        </div>
    </form>
{/foreach}