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
                        <form action="/countries/add" method="post" enctype="multipart/form-data">
                            {$csrf->csrfTokenInput()}
                            <div class="row">
                                <div class="col-md-2">
                                    <label>نام کشور</label>
                                    <input type="text" name="persian_title" class="form-control">
                                </div>
                                <div class="col-md-2">
                                    <label>نام لاتین کشور</label>
                                    <input type="text" name="english_title" class="form-control">
                                </div>
                                <div class="col-md-2">
                                    <label>نام استاندارد کشور</label>
                                    <input type="text" name="abbreviated_name" class="form-control">
                                </div>
                                <div class="col-md-2">
                                    <label>پیش شماره</label>
                                    <input type="text" name="persian_title" class="form-control">
                                </div>
                            </div>
                            <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                <button type="submit"
                                        class="btn btn-sm btn-primary glow">
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