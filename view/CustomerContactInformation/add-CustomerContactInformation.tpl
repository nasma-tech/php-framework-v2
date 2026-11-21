{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-overlay"></div>
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title">{$singleName}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndBackButton()}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 3px">
            <div class="col-md-12">
                <form action="/CustomerContactInformation/add" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            {include 'CustomerContactInformation/ContactInfo.tpl'}
                        </div>
                        <div class="col-md-6 pl-0">
                            {include 'CustomerContactInformation/ContactPhones.tpl'}
                        </div>
                        <div class="col-md-6">
                            {include 'CustomerContactInformation/ContactProject.tpl'}
                        </div>
                        <div class="col-md-6 pl-0">
                            {include 'CustomerContactInformation/ContactProjectFollowUp.tpl'}
                        </div>
                        <div class="col-md-12">
                            <div class="card shadow mt-1 mb-5">
                                <div class="card-content">
                                    <div class="card-body pb-3">
                                        <button class="btn btn-sm btn-primary float-right">ثبت
                                            مرکز تماس
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}
