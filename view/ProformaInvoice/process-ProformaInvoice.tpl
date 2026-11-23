{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="card shadow">
            <div class="card-header">
                <h4 class="card-title" style="float: right">
                    {$singleName}
                    <span class="bg-secondary bg-light rounded"
                          style="font-family: monospace; padding: 5px 10px;">{$getData->invoice_number}</span>
                </h4>
                {$buttonHelper->refreshAndBackButton(2)}
                <div dir="rtl" class="btn-group mb-1 float-right">
                    <div class="dropdown">
                        <button class="btn btn-sm btn-primary dropdown-toggle" type="button" id="dropdownMenuButtonIcon"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="bx bx-dots-vertical-rounded"></i> گزینه های فرایند
                        </button>
                        <div class="dropdown-menu dropdown-menu-right text-center"
                             aria-labelledby="dropdownMenuButtonIcon"
                             x-placement="bottom-end"
                             style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(178px, 38px, 0px);">

                            {foreach $optionsConfig as $optionConfig}
                                {if $optionConfig['show']|default:null}
                                    {if !isset($optionConfig['type']) || $optionConfig['type'] == 'a'}
                                        <a href="{$optionConfig['href']|default:'#'}"
                                           target="{$optionConfig['target']|default:"_self"}"
                                           data-toggle="tooltip"
                                           id="option_{$optionConfig['name']}"
                                           data-original-title="{$optionConfig['description']}"
                                           class="dropdown-item {$optionConfig['class']|default:""}">
                                            <i class="bx mr-50 {$optionConfig['icon']|default:"bx-dots-vertical-rounded"}"></i>{$optionConfig['title']}
                                        </a>
                                    {elseif $optionConfig['type'] == 'button'}
                                        <button type="button"
                                                id="option_{$optionConfig['name']}"
                                                data-toggle="tooltip"
                                                data-original-title="{$optionConfig['description']}"
                                                class="btn btn-sm dropdown-item {$optionConfig['class']|default:""}">
                                            <i class="bx mr-50 {$optionConfig['icon']|default:"bx-dots-vertical-rounded"}"></i>{$optionConfig['title']}
                                        </button>
                                    {/if}
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="display: none">
            <input type="hidden" id="invoiceId" value="{$getData.id}">
        </div>
        <div class="row mt-1">
            <div class="col-12 col-md-3 mb-1">
                <div class="card shadow h-100">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <img class="p-1 w-100" width="256"
                                     src="{(($brand) ? "/Storage/brands/{$brand->logo_address}" : "/public/images/logo/logo-side-menu.png")}"
                                     alt="logo">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-3 mb-1">
                <div class="card shadow h-100">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <h6 class="mb-1"><i class="bx align-middle bx-support text-primary"></i>مشخصات کارشناس
                                </h6>
                                <div>
                                    {$expert->full_name}
                                    |
                                    {$saleTeam->team_title|default:'<span class="danger">بدون تیم</span>'}
                                </div>
                                <div>
                                    بازاریاب: -
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-3 mb-1">
                <div class="card shadow h-100">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <h6 class="mb-1"><i class="bx align-middle bx-user-voice text-primary"></i>اطلاعات مشتری
                                </h6>
                                <div>
                                    <a target="_blank"
                                       href="/CustomerContactInformation/contactDetail/{$contact->id}">{$contact->contact_code}
                                        | {$contact->contactFullName()}</a>
                                </div>
                                <div>
                                    {$company->company_name|default:''}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-3 mb-1">
                <div class="card shadow h-100">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <h6 class="mb-1"><i class="bx align-middle bx-file text-primary"></i>اطلاعات پیش فاکتور
                                </h6>
                                <div>
                                    تاریخ و ساعت صدور: <span
                                            dir="ltr">{jdate("Y/m/d H:i" , strtotime($getData->created_at))}</span>
                                </div>
                                <div>
                                    زمان تحویل: <u>{$getData->delivery_date}</u> روز کاری
                                </div>
                                <div>
                                    استان و شهر: {$state->title} - {$city->title}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        {*        {if $getData->checkInvoiceValidity()}*}
        {if true}
            {$csrf->csrfTokenInput()}
            <div class="card shadow">
                <div class="card-content">
                    <div class="card-body">
                        <ul class="nav nav-pills nav-justified">
                            {foreach $sectionsConfig['mainSections']|default:[] as $mainSection}
                                <li class="nav-item">
                                    <a class="nav-link {((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'active' : '')}"
                                       id="{$mainSection['name']}-tab-justified"
                                       data-toggle="pill"
                                       href="#{$mainSection['name']}-justified"
                                       aria-expanded="{((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'true' : 'false')}"><i
                                                class="bx {$mainSection['icon']} align-middle"></i>{$mainSection['title']}
                                    </a>
                                </li>
                            {/foreach}

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle h-100" data-toggle="dropdown" href="#" role="button"
                                   aria-haspopup="true" aria-expanded="false">
                                    <i class="bx bx-dots-vertical-rounded mr-50 align-middle"></i>بیشتر
                                </a>
                                <div class="dropdown-menu">
                                    {foreach $sectionsConfig['moreSections']|default:[] as $moreSection}
                                        <a class="dropdown-item" id="{$moreSection['name']}-tab-justified"
                                           href="#{$moreSection['name']}-justified"
                                           data-toggle="pill" role="tab"><i
                                                    class="bx {$moreSection['icon']} mr-50"></i> {$moreSection['title']}
                                        </a>
                                        {if isset($moreSection['appendAfterDivider']) && $moreSection['appendAfterDivider']}
                                            <div class="dropdown-divider"></div>
                                        {/if}
                                    {/foreach}
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="tab-content">
                {foreach $sectionsConfig|default:[] as $mainSectionData}
                    {foreach $mainSectionData as $mainSectionDatum}
                        <div class="tab-pane {((isset($mainSectionDatum['activeStep']) && $mainSectionDatum['activeStep']) ? 'active' : '')}"
                             id="{$mainSectionDatum['name']}-justified" role="tabpanel"
                             aria-labelledby="{$mainSectionDatum['name']}-tab-justified"
                             aria-expanded="{((isset($mainSectionDatum['activeStep']) && $mainSectionDatum['activeStep']) ? 'true' : 'false')}">
                            {include $mainSectionDatum['sectionFile']}
                        </div>
                    {/foreach}
                {/foreach}
            </div>
        {else}
            <div class="card shadow mt-1 text-center">
                <div class="card-content">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 bg-rgba-danger rounded">
                                <h6 class="my-1">اعتبار پیش فاکتور به پایان رسیده است</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
</div>

<script src="/public/vendors/js/extensions/jquery.steps.min.js"></script>
<script src="/public/vendors/js/forms/validation/jquery.validate.min.js"></script>
<script src="/public/js/scripts/forms/wizard-steps.js"></script>

{include 'sections/footer.tpl'}