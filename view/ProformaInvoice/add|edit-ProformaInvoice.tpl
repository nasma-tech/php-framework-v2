{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title">صدور {$singleName} | مشتری :  <code>{$priceSuggestionData.contactData.first_name} {$priceSuggestionData.contactData.last_name}</code></h4>
                        {$buttonHelper->refreshBtn()}
                    </div>
                </div>
            </div>
        </div>
        {$csrf->csrfTokenInput()}
        <form action="/ProformaInvoice/add" method="post">
            <div class="row">
                <div class="col-md-12">
                    {include 'ProformaInvoice/steps/one.tpl'}
                    {include 'ProformaInvoice/steps/two.tpl'}
                    {include 'ProformaInvoice/steps/three.tpl'}
                    {include 'ProformaInvoice/steps/four.tpl'}
                </div>
                <div class="col-md-12">
                    <div class="card shadow pb-2" style="margin-top: 3px">
                        <div class="card-content">
                            <div class="card-body">
                                <button class="btn btn-primary btn-icon float-right nextStepButton" type="button">
                                    بعدی
                                    <i class="bx bx-left-arrow"></i>
                                </button>
                                <button class="btn btn-primary btn-icon float-right submitButton" style="display: none">
                                    ثبت نهایی
                                    <i class="bx bx-check"></i>
                                </button>
                                <button class="btn btn-primary btn-icon float-left previousStepButton" type="button">
                                    <i class="bx bx-right-arrow"></i>
                                    قبلی
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

{include 'sections/footer.tpl'}



