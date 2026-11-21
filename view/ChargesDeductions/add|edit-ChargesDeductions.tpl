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
                            <h4 class="card-title" style="float: right">افزودن {$singleName}</h4>
                            {$buttonHelper->refreshAndBackBtn()}
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <form action="/ChargesDeductions/{if !$getData|default:null}add {else}edit/{$getData.id}{/if}" enctype="multipart/form-data" method="post">
                        <div class="card shadow" style="margin-top: 3px">
                            <div class="card-content">
                                <div class="card-body">

                                    {$csrf->csrfTokenInput()}
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label for="">شناسه</label>
                                            <input class="form-control" required value="{$getData.identifier|default:''}" id="identifier" name="identifier">
                                        </div>
                                        <div class="col-md-3">
                                            <label for="">عنوان</label>
                                            <input class="form-control" required id="title" value="{$getData.title|default:''}" name="title">
                                        </div>
                                        <div class="col-md-3">
                                            <label for="">ضریب</label>
                                            <input class="form-control" required id="coefficient" value="{$getData.coefficient|default:''}" name="coefficient">
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <hr>
                                    <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                        <button type="submit" class="btn btn-sm btn-primary glow">ثبت
                                            اطلاعات
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

{include 'sections/footer.tpl'}