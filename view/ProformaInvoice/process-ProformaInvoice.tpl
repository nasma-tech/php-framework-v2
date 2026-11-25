{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<style>

    /* =========================================
       CANCELLED CONTRACT NOTICE
    ========================================= */

    .cc-contract-cancelled {
        position: relative;
        display: flex;
        align-items: center;
        gap: 16px;
        width: 100%;
        padding: 17px 20px;
        margin-bottom: 18px;
        overflow: hidden;
        background: linear-gradient(110deg, #fffafa 0%, #fff3f2 100%);
        border: 1px solid #f3d6d4;
        border-right: 4px solid #d9534f;
        border-radius: 10px;
        box-shadow: 0 3px 12px rgba(180, 55, 55, .045);
        direction: rtl;
        box-sizing: border-box;
    }

    .cc-contract-cancelled-icon {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 48px;
        height: 48px;
        flex-shrink: 0;
        color: #c64b47;
        background: #ffe8e6;
        border: 1px solid #f7d1ce;
        border-radius: 11px;
        font-size: 27px;
    }

    .cc-contract-cancelled-mark {
        position: absolute;
        left: -5px;
        top: -5px;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 21px;
        height: 21px;
        color: #fff;
        background: #d9534f;
        border: 2px solid #fff;
        border-radius: 50%;
        font-size: 13px;
    }

    .cc-contract-cancelled-content {
        flex: 1;
        min-width: 0;
    }

    .cc-contract-cancelled-title {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 10px;
    }

    .cc-contract-cancelled-title strong {
        color: #923b38;
        font-size: 14px;
        font-weight: 700;
    }

    .cc-contract-cancelled-badge {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 9px;
        color: #c04440;
        background: #ffe7e5;
        border: 1px solid #f7d1ce;
        border-radius: 20px;
        font-size: 10px;
        font-weight: 600;
    }

    .cc-contract-cancelled-content p {
        margin: 8px 0 0;
        color: #8b6664;
        font-size: 12px;
        line-height: 1.9;
    }

    .cc-contract-cancelled-content p strong {
        color: #a9433f;
        font-weight: 700;
    }

    .cc-contract-cancelled-lock {
        display: flex;
        align-items: center;
        gap: 7px;
        flex-shrink: 0;
        padding: 9px 12px;
        color: #a64b47;
        background: rgba(217, 83, 79, .07);
        border: 1px solid rgba(217, 83, 79, .13);
        border-radius: 7px;
        font-size: 11px;
        font-weight: 600;
    }

    .cc-contract-cancelled-lock i {
        font-size: 17px;
    }

    /* Responsive */

    @media (max-width: 600px) {
        .cc-contract-cancelled {
            align-items: flex-start;
            flex-wrap: wrap;
            padding: 14px;
            gap: 12px;
        }

        .cc-contract-cancelled-icon {
            width: 42px;
            height: 42px;
            font-size: 23px;
        }

        .cc-contract-cancelled-content {
            flex-basis: calc(100% - 58px);
        }

        .cc-contract-cancelled-lock {
            margin-right: 54px;
        }
    }

</style>
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
                             style="position: absolute; will-change: transform; top: 0; left: 0; transform: translate3d(178px, 38px, 0px);">

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
        {if $getData.contract.cancelContract|default:''}
            <div class="card shadow" style="margin-top: 3px">
                <div class="card-content">
                    <div class="card-body">
                        <div class="cc-contract-cancelled">
                            <div class="cc-contract-cancelled-icon">
                                <i class="bx bx-file-blank"></i>
                                <span class="cc-contract-cancelled-mark">
                                    <i class="bx bx-x"></i>
                                </span>
                            </div>

                            <div class="cc-contract-cancelled-content">
                                <div class="cc-contract-cancelled-title">
                                    <strong>این قرارداد لغو شده است</strong>
                                    <span class="cc-contract-cancelled-badge"><i class="bx bx-x-circle"></i>لغو شده</span>
                                </div>
                                <p>
                                    این قرارداد به دلیل لغو شدن، از اعتبار خارج شده است و
                                    <strong>امکان انجام هیچ‌گونه عملیات یا ویرایشی روی آن وجود ندارد.</strong>
                                </p>
                            </div>

                            <div class="cc-contract-cancelled-lock">
                                <i class="bx bx-lock-alt"></i>
                                <span>دسترسی غیرفعال</span>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            {else}
            <div style="display: none">
                <input type="hidden" id="invoiceId" value="{$getData.id}">
            </div>
            <div class="row">
                <div class="col-12 col-md-3">
                    <div class="card shadow h-100" style="margin: 3px 0;">
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
                <div class="col-12 col-md-3 pl-md-0">
                    <div class="card shadow h-100" style="margin-top: 3px">
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
                <div class="col-12 col-md-3 pl-md-0">
                    <div class="card shadow h-100" style="margin-top: 3px">
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
                <div class="col-12 col-md-3 pl-md-0">
                    <div class="card shadow h-100" style="margin-top: 3px">
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
                <div class="card shadow" style="margin-top: 10px">
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

        {/if}



    </div>
</div>

<script src="/public/vendors/js/extensions/jquery.steps.min.js"></script>
<script src="/public/vendors/js/forms/validation/jquery.validate.min.js"></script>
<script src="/public/js/scripts/forms/wizard-steps.js"></script>

{include 'sections/footer.tpl'}