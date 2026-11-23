{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<style>

    /* =========================================
       Invoice Converted To Contract
    ========================================= */

    .cc-invoice-contract-notice {
        position: relative;
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 20px 22px;
        margin-top: 3px;
        overflow: hidden;
        border: 1px solid #dce7f7;
        border-right: 4px solid #4779dc;
        border-radius: 5px;
        background: linear-gradient(115deg, #ffffff 0%, #f4f8ff 100%);
        box-shadow: 0 4px 16px rgba(39, 83, 151, 0.055);
        transition: all 0.25s ease;
    }

    /* Main Icon */

    .cc-invoice-contract-icon {
        position: relative;
        width: 49px;
        height: 49px;
        min-width: 49px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
        background: #e8f0ff;
        color: #4779dc;
        font-size: 26px;
    }

    .cc-invoice-contract-check {
        position: absolute;
        left: -5px;
        bottom: -5px;
        width: 19px;
        height: 19px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 2px solid #fff;
        border-radius: 50%;
        background: #22a477;
        color: #fff;
        font-size: 12px;
    }

    /* Content */

    .cc-invoice-contract-content {
        flex: 1;
        min-width: 0;
    }

    .cc-invoice-contract-heading {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 10px;
        margin-bottom: 8px;
        color: #263f70;
        font-size: 13px;
        font-weight: 700;
    }

    /* Status Badge */

    .cc-invoice-contract-badge {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 10px;
        border-radius: 20px;
        background: #e5f5ed;
        color: #21865c;
        font-size: 10px;
        font-weight: 600;
        white-space: nowrap;
    }

    .cc-invoice-contract-badge i {
        font-size: 13px;
    }

    /* Description */

    .cc-invoice-contract-content p {
        margin: 0;
        color: #78879e;
        font-size: 11px;
        line-height: 2.1;
    }

    .cc-invoice-contract-content p strong {
        color: #315fbd;
        font-weight: 700;
    }

    /* Decorative Conversion Flow */

    .cc-invoice-contract-arrow {
        display: flex;
        align-items: center;
        gap: 5px;
        padding: 10px 13px;
        border: 1px solid #e5ecf8;
        border-radius: 10px;
        background: rgba(255, 255, 255, 0.75);
        color: #8ba4ce;
        font-size: 19px;
    }

    .cc-invoice-contract-arrow i:last-child {
        color: #4779dc;
    }

    /* Responsive */

    @media (max-width: 576px) {
        .cc-invoice-contract-notice {
            gap: 12px;
            padding: 15px;
        }

        .cc-invoice-contract-icon {
            width: 42px;
            height: 42px;
            min-width: 42px;
            font-size: 22px;
        }

        .cc-invoice-contract-arrow {
            display: none;
        }

        .cc-invoice-contract-heading {
            font-size: 12px;
        }
    }

</style>
<div class="app-content content">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title">
                            {if $getData.contract|default}
                                الحاقیه قرارداد
                            {elseif $getData|default:null}
                                ویرایش {$singleName}
                            {else}
                                صدور{$singleName}
                            {/if}
                            | مشتری :
                            <code>{$priceSuggestionData.contactData.first_name|default:$getData.contact.first_name} {$priceSuggestionData.contactData.last_name|default:$getData.contact.last_name}</code>
                        </h4>
                        {$buttonHelper->refreshAndBackButton()}
                    </div>
                </div>
            </div>
            {if $getData.contract}
                <div class="col-md-12">
                    <div class="cc-invoice-contract-notice">

                        <div class="cc-invoice-contract-icon">
                            <i class="bx bx-file-blank"></i>
                            <span class="cc-invoice-contract-check">
            <i class="bx bx-check"></i>
        </span>
                        </div>

                        <div class="cc-invoice-contract-content">

                            <div class="cc-invoice-contract-heading">
                                <span>این پیش‌فاکتور به قرارداد تبدیل شده است</span>

                                <span class="cc-invoice-contract-badge">
                <i class="bx bx-check-circle"></i>
                قرارداد فعال
            </span>
                            </div>

                            <p>
                                از این پس، هرگونه ویرایش یا تغییر در اطلاعات این پیش‌فاکتور،
                                به‌عنوان <strong>الحاقیه قرارداد</strong> محسوب شده و
                                در سوابق قرارداد ثبت خواهد شد.
                            </p>

                        </div>

                        <div class="cc-invoice-contract-arrow">
                            <i class="bx bx-file-blank"></i>
                            <i class="bx bx-left-arrow-alt"></i>
                            <i class="bx bx-file"></i>
                        </div>

                    </div>
                </div>
            {/if}
        </div>
        {$flashMessageHelper->formCallBack()}
        {$csrf->csrfTokenInput()}
        <form action="{if $getData|default:null}/ProformaInvoice/edit/{$getData.id} {else}/ProformaInvoice/add{/if}"
              method="post">
            {$csrf->csrfTokenInput()}
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
                                <button class="btn btn-primary btn-icon float-right submitButton"
                                        style="display: none">
                                    ثبت نهایی
                                    <i class="bx bx-check"></i>
                                </button>
                                <button class="btn btn-primary btn-icon float-left previousStepButton"
                                        type="button">
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



