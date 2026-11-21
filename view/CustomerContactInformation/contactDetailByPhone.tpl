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
                <div class="card shadow">
                    <div class="card-content">
                        <div class="card-body">

                            <ul class="nav nav-pills nav-justified cc-modern-tabs">
                                <li class="nav-item">
                                    <a class="nav-link active"
                                       id="contact-tab-justified"
                                       data-toggle="pill"
                                       href="#contact-justified"
                                       aria-expanded="true">
                                        اطلاعات مخاطب
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link"
                                       id="projectList-tab-justified"
                                       data-toggle="pill"
                                       href="#projectList-justified"
                                       aria-expanded="false">
                                        لیست پروژه ها
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12 mb-5">
                <div class="tab-content" style="margin-top: 3px">
                    <div role="tabpanel" class="tab-pane active" id="contact-justified"
                         aria-labelledby="contact-tab-justified" aria-expanded="true">
                        <form action="/CustomerContactInformation/add" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    {include 'CustomerContactInformation/ContactInfo.tpl'}
                                </div>
                                <div class="col-md-6 pl-0">
                                    {include 'CustomerContactInformation/ContactPhones.tpl'}
                                </div>
                                <div class="col-md-6">
                                    {include 'CustomerContactInformation/ContactProjectFollowUp.tpl'}
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="projectList-justified" role="tabpanel"
                         aria-labelledby="projectList-tab-justified" aria-expanded="false">
                        {include 'CustomerContactInformation/ContactProjectList.tpl'}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




{include 'sections/footer.tpl'}
