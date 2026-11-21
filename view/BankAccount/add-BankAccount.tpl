{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        <div class="container">
            {$flashMessageHelper->formCallBack()}
            <div class="row">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>
                            {$buttonHelper->refreshAndBackButton()}
                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 3px">
                    <div class="card shadow">
                        <div class="card-body">
                            <form action="/BankAccount/add" method="post" enctype="multipart/form-data">
                                {$csrf->csrfTokenInput()}
                                <div class="row">
                                    <div class="col-md-3 mt-3">
                                        <div class="checkbox checkbox-primary">
                                            <input type="checkbox" class="taxesInput" style="margin-top: 6px" value="1"
                                                   checked="checked" name="has_card_number" id="has_card_number">
                                            <label for="has_card_number">دارای شماره کارت</label>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="bank_list_id">بانک</label>
                                        <select class="form-control select2" disabled="disabled" id="bank_list_id" name="bank_list_id">
                                            <option value="0" selected disabled>یک مورد را انتخاب کنید</option>
{*                                            {foreach $bankList as $item}*}
{*                                                <option value="{$item->id}" data-code='{$item->bank_list_code}'>{$item->bank_list_name}</option>*}
{*                                            {/foreach}*}
                                        </select>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="bank_branch_name">نام شعبه</label>
                                        <input class="form-control" required name="bank_branch_name" id="bank_branch_name">
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="bank_account_number">شماره حساب</label>
                                        <input class="form-control" dir="ltr" required name="bank_account_number"
                                               id="bank_account_number">
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="bank_card_number">شماره کارت</label>
                                        <div class="input-group">
                                            <input class="form-control" required dir="ltr" name="bank_card_number"
                                                   id="bank_card_number">
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <i class="bx bx-credit-card"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="bank_sheba_number">شماره شبا</label>
                                        <div class="input-group">
                                            <input class="form-control" required dir="ltr" name="bank_sheba_number" id="bank_sheba_number">
                                            <div class="input-group-append">
                                                <span class="input-group-text">IR</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="bank_person">نام و نام خانوادگی صاحب حساب</label>
                                        <input class="form-control" required name="bank_person" id="bank_person">
                                    </div>
                                    <div class="col-md-3 mt-2">
                                        <label for="bank_last_value">موجودی اولیه</label>
                                        <div class="input-group">
                                            <input class="form-control" required dir="ltr" name="bank_last_value" id="bank_last_value">
                                            <div class="input-group-append">
                                                <span class="input-group-text">ریال</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mt-3">
                                        <label>وضعیت حساب</label>
                                        <div class="checkbox checkbox-primary">
                                            <input type="checkbox" class="taxesInput" value="1" style="margin-top: 6px"
                                                   checked="checked" name="bank_status" id="bank_status">
                                            <label for="bank_status">فعال</label>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mt-3">
                                        <button class="btn btn-sm btn-primary float-right">ثبت</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}