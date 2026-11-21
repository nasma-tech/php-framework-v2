<div class="col-md-12 row">
    <div class="col-md-3">
        <label for="ware_house_name">عنوان انبار</label>
        <input class="form-control" type="text" name="ware_house_name" id="ware_house_name" required>
    </div>
    <div class="col-md-3">
        <label for="warehouse_brand_id">برند</label>
        <select name="warehouse_brand_id" required class="form-control select2" id="warehouse_brand_id">
            <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
            {foreach $brands As $data}
                <option value="{$data['id']}">{$data['label']}</option>
            {/foreach}
        </select>
    </div>
    <div class="col-md-3">
        <label for="warehouse_type_id">نوع انبار</label>
        <select name="warehouse_type_id" required class="form-control select2" id="warehouse_type_id">
            <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
            {foreach $warehouseType As $data}
                <option value="{$data['id']}">{$data['label']}</option>
            {/foreach}
        </select>
    </div>
    <div class="col-md-3">
        <label for="warehouse_usage_id">کاربرد انبار</label>
        <select name="warehouse_usage_id" required class="form-control select2" id="warehouse_usage_id">
            <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
            {foreach $warehouseUsageTypes As $data}
                <option value="{$data['id']}">{$data['label']}</option>
            {/foreach}
        </select>
    </div>
</div>