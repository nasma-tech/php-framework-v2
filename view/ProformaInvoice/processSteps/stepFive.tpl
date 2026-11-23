<div class="card">
    <div class="card-body">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-4">
                    <label for="country_id">کشور</label>
                    <select id="country_id" name="country_id" class="form-control select2" required>
                        <option disabled selected>یکی از موارد زیر رو انتخاب کنید</option>
                        {foreach $countries as $data}
                            <option value="{$data['id']}">{$data['persian_title']}</option>
                        {/foreach}
                    </select>

                </div>
                <div class="col-md-4">
                    <label for="state_id">استان</label>
                    <select name="state_id" id="state_id" class="form-control select2" required disabled>
                        <option disabled selected>کشور را انتخاب کنید</option>
                    </select>

                </div>
                <div class="col-md-4">
                    <label for="city_id">شهر</label>
                    <select name="city_id" id="city_id" class="form-control select2" required disabled>
                        <option disabled selected>استان را انتخاب کنید</option>
                    </select>

                </div>
            </div>
        </div>
    </div>
</div>