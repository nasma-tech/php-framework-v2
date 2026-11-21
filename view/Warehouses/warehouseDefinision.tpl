<div class="col-md-12 row">
    <div class="col-md-3">
        <label for="wareHouseName">عنوان انبار</label>
        <input class="form-control" type="text" name="wareHouseName" required>
    </div>
    <div class="col-md-3">
        <label for="warehouseBrand">برند</label>
        <select name="warehouseBrand" required class="form-control select2">
            <option disabled selected>یکی از موارد را انتخاب کنید</option>
            {foreach $brands As $data}
                <option value="{$data['id']}">{$data['label']}</option>
            {/foreach}
        </select>
    </div>
    <div class="col-md-3">
        <label for="warehouseBrand">نوع انبار</label>
        <select name="warehouseBrand" required class="form-control select2">
            <option disabled selected>یکی از موارد را انتخاب کنید</option>
            {foreach $warehouseType As $data}
                <option value="{$data['id']}">{$data['label']}</option>
            {/foreach}
        </select>
    </div>
    <div class="col-md-3">
        <label for="warehouseBrand">کاربرد انبار</label>
        <select name="warehouseBrand" required class="form-control select2">
            <option disabled selected>یکی از موارد را انتخاب کنید</option>
            {foreach $brands As $data}
                <option value="{$data['id']}">{$data['label']}</option>
            {/foreach}
        </select>
    </div>
</div>