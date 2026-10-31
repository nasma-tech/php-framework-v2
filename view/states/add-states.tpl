{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
<div class="content-wrapper">
    {$flashMessageHelper->formCallBack()}
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>
                    {$buttonHelper->refreshAndBackButton()}
                </div>
                <hr>
                <div class="card-content">
                    <div class="card-body">
                        <form id="mainForm" enctype="multipart/form-data">
                            {$csrf->csrfTokenInput()}
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>انتخاب کشور</label>
                                            <select class="form-control select2" name="country_id">
                                                <option selected disabled>لطفا یک مورد را انتخاب کنید</option>
                                                {foreach $countries as $item}
                                                    <option value="{$item->id}" {(($item->id == 102)?'selected':'')}>{$item->persian_title}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>استان</label>
                                            <input type="text" name="title" class="form-control"
                                                   autofocus placeholder="استان" required
                                                   data-validation-required-message="وارد کردن استان الزامی است">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>پیش شماره استان</label>
                                            <input type="text" name="area_code" class="form-control"
                                                   autofocus placeholder="پیش شماره" required
                                                   data-validation-required-message="وارد کردن پیش شماره الزامی است">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <label>لوکیشن</label>
                                    <div id="map"></div>
                                </div>
                            </div>
                            <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                <button type="submit"
                                        class="btn btn-primary btn-sm glow">
                                    ثبت {$singleName}</button>
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