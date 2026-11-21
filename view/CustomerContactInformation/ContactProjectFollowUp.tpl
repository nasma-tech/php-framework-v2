<div class="card shadow cc-initial-info" style="margin-top: 4px;height: 100%">
    <div class="card-content">
        <div class="card-header">
            <div class="divider divider-left">
                <div class="divider-text" style="font-size: 11px">ثبت پیگیری</div>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <label for="toDay">تاریخ روز</label>
                    <input class="form-control text-center" id="toDay" value="{jdate("Y/m/d")}" disabled>
                </div>
                <div class="col-md-4">
                    <label for="next_followUp_date">تاریخ پیگیری بعدی</label>
                    <input class="form-control text-center" data-jdp-min-date="{jdate("Y/m/d")}" required
                           id="next_followUp_date"
                           name="next_followUp_date">
                </div>
                <div class="col-md-4">
                    <label for="FollowUp_action_id">عنوان پیگیری بعد</label>
                    <select class="form-control select2" required="required" id="FollowUp_action_id" name="FollowUp_action_id">
                        <option selected disabled>یک مورد را انتخاب کنید</option>
                        {foreach $FollowUpActionsTitle as $item}
                            <option value="{$item->id}">{$item->title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-12 mt-2">
                    <label for="followUp_description">توضیحات</label>
                    <textarea class="form-control" id="followUp_description" name="followUp_description" rows="6"
                              style="resize: none"></textarea>
                </div>
            </div>
        </div>
    </div>
    {if isset($getData)}
        <div class="card-footer">
            <button class="btn btn-sm btn-primary float-right" type="submit">ثبت پیگیری</button>
        </div>
    {/if}
</div>
