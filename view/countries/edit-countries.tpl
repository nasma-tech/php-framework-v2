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
                    <h4 class="card-title" style="float: right">ویرایش {$singleName} </h4>
                    {$buttonHelper->refreshAndBackButton()}
                </div>
                <div class="card-content">
                    <div class="card-body">
                        <form action="edit/{$getData->id}" enctype="multipart/form-data">
                            {$csrf->csrfTokenInput()}
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>نام کشور</label>
                                            <input type="text" name="persian_title"
                                                   value="{($getData->persian_title)?$getData->persian_title:''}"
                                                   class="form-control" autofocus placeholder="نام کشور" required
                                                   data-validation-required-message="وارد کردن نام کشور الزامی است">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label>نام لاتین کشور</label>
                                    <input type="text" name="english_title"
                                           value="{($getData->english_title)?$getData->english_title:''}"
                                           class="form-control">
                                </div>
                                <div class="col-md-2">
                                    <label>نام استاندارد کشور</label>
                                    <input type="text" name="abbreviated_name"
                                           value="{($getData->abbreviated_name)?$getData->abbreviated_name:''}"
                                           class="form-control">
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>پیش شماره</label>
                                            <input type="text" name="persian_title"
                                                   value="{($getData->persian_title)?$getData->persian_title:''}"
                                                   class="form-control" autofocus placeholder="پیش شماره" required
                                                   data-validation-required-message="وارد کردن پیش شماره الزامی است">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                <button type="submit"
                                        class="btn btn-success btn-sm glow">ویرایش {$singleName}</button>
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