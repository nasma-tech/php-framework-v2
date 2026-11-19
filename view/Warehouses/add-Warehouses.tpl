{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content warehouse-page">
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
                        <form action="/Warehouses/add" id="mainForm" method="post">
                            <div class="card-body">
                                <ul class="nav nav-tabs nav-justified" id="myTab2" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="definision-tab-justified" data-toggle="tab"
                                           href="#definision-just" role="tab" aria-controls="definision-just"
                                           aria-selected="true">
                                            اطلاعات انبار
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="physicalAddress-tab-justified" data-toggle="tab"
                                           href="#physicalAddress-just" role="tab" aria-controls="physicalAddress-just"
                                           aria-selected="true">
                                            آدرس انبار
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="profile-tab-justified" data-toggle="tab"
                                           href="#ownership-just" role="tab" aria-controls="profile-just"
                                           aria-selected="true">
                                            مالکیت انبار
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="team-tab-justified" data-toggle="tab" href="#team-just"
                                           role="tab" aria-controls="team-just" aria-selected="false">
                                            تیم انبار
                                        </a>
                                    </li>
                                </ul>
                                <!-- Tab panes -->
                                <div class="tab-content pt-1">
                                    <div class="tab-pane active" id="definision-just" role="tabpanel"
                                         aria-labelledby="definision-tab-justified">
                                        {include "view/Warehouses/warehouseDefinision.tpl"}
                                    </div>
                                    <div class="tab-pane" id="physicalAddress-just" role="tabpanel"
                                         aria-labelledby="physicalAddress-tab-justified">
                                        {include "view/Warehouses/warehousePhysicalAddress.tpl"}
                                    </div>
                                    <div class="tab-pane" id="ownership-just" role="tabpanel"
                                         aria-labelledby="ownership-tab-justified">
                                        {include "view/Warehouses/warehouseOwnership.tpl"}
                                    </div>
                                    <div class="tab-pane" id="team-just" role="tabpanel"
                                         aria-labelledby="team-tab-justified">
                                        {include "view/Warehouses/warehouseTeam.tpl"}
                                    </div>
                                </div>
                                <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1 submit">
                                    <button type="submit"
                                            class="btn btn-sm btn-primary glow">
                                        ثبت {$singleName}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}