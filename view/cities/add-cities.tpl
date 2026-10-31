{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
<div class="content-wrapper">
    {$csrf->formCallBack()}
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
                        <form action="/cities/add" method="post" enctype="multipart/form-data">
                            {$csrf->csrfTokenInput()}
                            <div class="row">

                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>انتخاب کشور</label>
                                            <select class="form-control select2" name="country_id" required>
                                                <option selected disabled>لطفا یک کشور را انتخاب کنید</option>
                                                {foreach $country as $item}
                                                    <option value="{$item->id}" {(($item->id == 102)?'selected':'')}>{$item->persian_title}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>انتخاب استان</label>
                                            <select class="form-control select2" name="state_id" required>
                                                <option selected disabled>لطفا یک استان را انتخاب کنید</option>
                                                {foreach $states as $item}
                                                    <option value="{$item->id}">{$item->title}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>نام شهر</label>
                                            <input type="text" name="title" class="form-control" autofocus
                                                   placeholder="نام شهر" required
                                                   data-validation-required-message="وارد کردن نام شهر الزامی است">
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
                                        class="btn btn-primary glow">
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