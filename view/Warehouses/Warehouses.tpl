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
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndAddButton($singleName)}
                        </div>
                    </div>
                    <hr>
                    <div class="card-content">

                        <div class="card-body">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead class="thead-dark">
                                        <tr>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $getData AS $data}
                                            <tr>

                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}