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
                          style="font-family: monospace; padding: 5px 10px;">-----</span>
                </h4>
                {$buttonHelper->refreshAndBackButton(2)}
                <div class="btn-group mb-1 float-right">
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
                            {/foreach}
                            {*                            <a class="dropdown-item"*}
                            {*                               href="#"><i*}
                            {*                                        class="bx bx-edit text-success mr-50"></i>ویرایش*}
                            {*                                پیش*}
                            {*                                فاکتور</a>*}
                            {*                            <a class="dropdown-item"*}
                            {*                               href="#"><i*}
                            {*                                        class="bx bx-plus-circle mr-50 text-warning"></i>ثبت*}
                            {*                                الحاقیه</a>*}
                            {*                            <a class="dropdown-item" style="cursor: pointer"><i*}
                            {*                                        class="bx bx-check-shield mr-50"></i>ثبت تضامین</a>*}
                            {*                            <a class="dropdown-item" id="depositAllocationButton" style="cursor: pointer"><i*}
                            {*                                        class="bx bx-money mr-50"></i>تخصیص واریزی</a>*}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow" style="margin-top: 3px">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3 text-center" style="border-left: 1px dotted">
                        <img class="p-1" width="256"
                             src="" alt="logo">
                    </div>
                    <div class="col-md-3 text-center" style="border-left: 1px dotted">
                        <h6 class="my-1"><i class="bx bx-support"></i>مشخصات کارشناس</h6>
                    </div>
                    <div class="col-md-3 text-center" style="border-left: 1px dotted">
                        <h6 class="my-1"><i class="bx bx-user-voice"></i>اطلاعات مشتری</h6>
                    </div>
                    <div class="col-md-3 text-center">
                        <h6 class="my-1"><i class="bx bx-file"></i>اطلاعات پیش فاکتور</h6>
                    </div>
                </div>
            </div>
        </div>
        {*        {if $getData->checkInvoiceValidity()}*}
        {if true}
            {$csrf->csrfTokenInput()}
            <div class="card shadow" style="margin-top: 3px">
                <div class="card-content">
                    <div class="card-body">
                        <ul class="nav nav-pills nav-justified">
                            {foreach $sectionsConfig['mainSections']|default:[] as $mainSection}
                                <li class="nav-item">
                                    <a class="nav-link {((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'active' : '')}"
                                       id="{$mainSection['name']}-tab-justified"
                                       data-toggle="pill"
                                       href="#{$mainSection['name']}-justified"
                                       aria-expanded="{((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'true' : 'false')}">{$mainSection['title']}
                                    </a>
                                </li>
                            {/foreach}

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
                                   aria-haspopup="true" aria-expanded="false">
                                    بیشتر
                                </a>
                                <div class="dropdown-menu">
                                    {foreach $sectionsConfig['moreSections']|default:[] as $moreSection}
                                        <a class="dropdown-item" id="{$moreSection['name']}-tab-justified"
                                           href="#{$moreSection['name']}-justified"
                                           data-toggle="pill" role="tab">{$moreSection['title']}</a>
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
            <div class="card shadow" style="margin-top: 3px">
                <div class="card-content">
                    <div class="card-body">
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
                    </div>
                </div>
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