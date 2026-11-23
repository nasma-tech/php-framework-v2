<div class="col-md-12 row">
    <div class="col-md-2">
        <label for="country_id">کشور</label>
        <select class="form-control select2" name="country_id" id="country_id" required>
            <option disabled selected>یکی از موارد زیر را انتخاب کنید</option>
            {foreach $countries as $data}
                <option value="{$data['id']}">{$data['persian_title']}</option>
            {/foreach}
        </select>
    </div>
    <div class="col-md-2">
        <label for="state_id">استان</label>
        <select name="state_id" id="state_id" class="form-control select2" required
                disabled>
        </select>
    </div>
    <div class="col-md-2">
        <label for="city_id">شهر</label>
        <select name="city_id" id="city_id" class="form-control select2" required
                disabled></select>
    </div>
    <div class="col-md-3">
        <label for="post_code">کد پستی</label>
        <input type="text" name="post_code" class="form-control" id="post_code" required>
    </div>
    <div class="col-md-3">
        <label for="warehouse_phone_number">شماره تلفن ثابت انبار</label>
        <div class="input-group">
            <input type="text" name="warehouse_phone_number" class="form-control"
                   id="warehouse_phone_number" required>
            <div class="input-group-append">
                <span class="input-group-text" id="area_code" dir="ltr"></span>
            </div>
        </div>
    </div>
</div>
<div class="col-md-12 mt-2">
    <label for="warehouse_full_address">آدرس انبار</label>
    <textarea class="form-control" style="resize: none" id="warehouse_full_address"
              name="warehouse_full_address" required></textarea>
</div>