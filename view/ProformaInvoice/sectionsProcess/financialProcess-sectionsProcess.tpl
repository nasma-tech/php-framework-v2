{*<div class="row">*}
{*    <div class="col-md-12">*}
{*        <div class="card shadow" style="margin-top: 3px">*}
{*            <div class="card-body">*}
{*                <ul class="nav nav-tabs nav-justified" id="myTab2" role="tablist">*}
{*                    <li class="nav-item">*}
{*                        <a class="nav-link active" id="totalPrice-tab-justified" data-toggle="tab"*}
{*                           href="#totalPrice-just" role="tab" aria-controls="totalPrice-just" aria-selected="false">*}
{*                            مبلغ کل*}
{*                        </a>*}
{*                    </li>*}
{*                </ul>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*</div>*}

{*<div class="tab-pane active " id="totalPrice-just" role="tabpanel" aria-labelledby="totalPrice-tab-justified">*}
{*    <div class="col-md-12">*}
{*        <div class="row">*}
{*            <div class="col-md-3 pl-md-0">*}
{*                <div class="card shadow text-center" style="margin-top: 3px">*}
{*                    <div class="card-content">*}
{*                        <div class="card-body py-1">*}
{*                            <div class="badge-circle badge-circle-lg badge-circle-light-success mx-auto my-75">*}
{*                                <i class="bx bx-wallet font-medium-5"></i>*}
{*                            </div>*}
{*                            <div class="text-muted line-ellipsis line-height-2 mb-50">مبلغ کل</div>*}
{*                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['invoice_sum_total'])}*}
{*                                <span>ریال</span>*}
{*                            </h3>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*            <div class="col-md-2 pl-md-0">*}
{*                <div class="card shadow text-center" style="margin-top: 3px">*}
{*                    <div class="card-content">*}
{*                        <div class="card-body py-1">*}
{*                            <div class="badge-circle badge-circle-lg badge-circle-light-primary mx-auto my-75">*}
{*                                <i class="bx bx-check font-medium-5"></i>*}
{*                            </div>*}
{*                            <div class="text-muted line-ellipsis line-height-2 mb-50"> واریزی تایید شده</div>*}
{*                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['approvedPayment'])}</h3>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*            <div class="col-md-2 pl-md-0">*}
{*                <div class="card shadow text-center" style="margin-top: 3px">*}
{*                    <div class="card-content">*}
{*                        <div class="card-body py-1">*}
{*                            <div class="badge-circle badge-circle-lg badge-circle-light-danger mx-auto my-75">*}
{*                                <i class="bx bx-timer font-medium-5"></i>*}
{*                            </div>*}
{*                            <div class="text-muted line-ellipsis line-height-2 mb-50">واریزی درانتظار تایید</div>*}
{*                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['preparingPayment'])}</h3>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*            <div class="col-md-2 pl-md-0">*}
{*                <div class="card shadow text-center" style="margin-top: 3px">*}
{*                    <div class="card-content">*}
{*                        <div class="card-body py-1">*}
{*                            <div class="badge-circle badge-circle-lg badge-circle-light-danger mx-auto my-75">*}
{*                                <i class="bx bx-x font-medium-5"></i>*}
{*                            </div>*}
{*                            <div class="text-muted line-ellipsis line-height-2 mb-50">واریزی تایید نشده</div>*}
{*                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['canceledPayment'])}</h3>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*            <div class="col-md-3 pl-md-0 pr-md-0">*}
{*                <div class="card shadow text-center" style="margin-top: 3px">*}
{*                    <div class="card-content">*}
{*                        <div class="card-body py-1">*}
{*                            <div class="badge-circle badge-circle-lg badge-circle-light-warning mx-auto my-75">*}
{*                                <i class="bx bx-money font-medium-5"></i>*}
{*                            </div>*}
{*                            <div class="text-muted line-ellipsis line-height-2 mb-50"> مانده مبلغ</div>*}
{*                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['invoice_sum_total'] - $paymentData['approvedPayment'])}</h3>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    <div class="divider">*}
{*        <div class="divider-text">اطلاعات اولیه</div>*}
{*    </div>*}
{*    <div class="card mt-2 shadow" style="margin-top: 3px">*}
{*        <div class="card-body">*}
{*            <div class="row">*}
{*                <div class="col-12">*}
{*                    <div class="table-responsive">*}
{*                        <table class="table table-bordered table-striped">*}
{*                            <thead class="thead-dark">*}
{*                            <tr class="text-center">*}
{*                                <th class="border">نحوه پرداخت</th>*}
{*                                <th class="border">بانک</th>*}
{*                                <th class="border">شناسه واریز</th>*}
{*                                <th class="border">شماره چک</th>*}
{*                                <th class="border">تاریخ واریز</th>*}
{*                                <th class="border">مبلغ پرداختی</th>*}
{*                                <th class="border">توضیحات</th>*}
{*                                <th class="border">وضعیت پرداخت</th>*}
{*                                <th class="border">کاربر ثبت‌کننده</th>*}
{*                            </tr>*}
{*                            </thead>*}
{*                            <tbody>*}
{*                            {foreach $invoicePaymentDetail as $data}*}
{*                                <tr class="text-center">*}
{*                                    <td>{$data.payment.paymentMethodData.title|default:'-'}</td>*}
{*                                    <td>{$data.payment.bankAccountData.bank_branch_name|default:'-'}</td>*}
{*                                    <td>{$data.payment.reference_no|default:'-'}</td>*}
{*                                    <td>{$data.payment.chequeData.cheque_number|default:'-'}</td>*}
{*                                    <td>{jdate("Y/m/d",$data.payment.date_deposit)|default:'-'}</td>*}
{*                                    <td>{number_format($data.payment.amount_paid)|default:'-'}</td>*}
{*                                    <td>*}
{*                                        <button class="btn btn-sm btn-primary viewDescription"*}
{*                                                data-text="{$data.payment.payment_description|default:'-'}">*}
{*                                            <i class="bx bx-note"></i>*}
{*                                        </button>*}
{*                                    </td>*}
{*                                    <td>*}
{*                                        {if $data.status === 0}*}
{*                                            <div class="btn btn-sm btn-warning w-100 text-white">*}
{*                                                درانتظار تایید*}
{*                                            </div>*}
{*                                        {elseif $data.status === 1}*}
{*                                            <div class="btn btn-sm btn-success w-100 text-white">*}
{*                                                تایید شده*}
{*                                            </div>*}
{*                                        {elseif $data.status === 2}*}
{*                                            <div class="btn btn-sm btn-danger w-100 text-white">*}
{*                                                عدم تایید*}
{*                                            </div>*}
{*                                        {else}*}
{*                                            <div class="btn btn-sm btn-warning w-100 text-white">*}
{*                                                برسی مجدد*}
{*                                            </div>*}
{*                                        {/if}*}
{*                                    </td>*}
{*                                    <td>{$data.payment.userData.full_name|default:'-'}</td>*}
{*                                </tr>*}
{*                            {/foreach}*}
{*                            </tbody>*}
{*                        </table>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*</div>*}

<style>

    /* =========================================
       PROFORMA PAYMENT - LIGHT PROFESSIONAL UI
    ========================================= */

    .pd-payment-page {
        direction: rtl;
        width: 100%;
        color: #27364b;
        font-family: inherit;
    }

    /* Heading */
    .pd-payment-heading {
        display: flex;
        align-items: center;
        gap: 13px;
        min-height: 76px;
        padding: 15px 19px;
        margin-bottom: 18px;
        background: #fff;
        border: 1px solid #e9edf3;
        border-radius: 12px;
    }

    .pd-payment-heading-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 44px;
        height: 44px;
        flex: 0 0 44px;
        border-radius: 11px;
        background: #edf2f9;
        color: #304b73;
        font-size: 23px;
    }

    .pd-payment-heading-info {
        flex: 1;
        min-width: 0;
    }

    .pd-payment-heading-info h4 {
        margin: 0 0 5px;
        color: #273c5b;
        font-size: 15px;
        font-weight: 800;
    }

    .pd-payment-heading-info span {
        color: #929dad;
        font-size: 11px;
    }

    .pd-payment-heading-tag {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 8px 12px;
        border: 1px solid #e9edf4;
        border-radius: 8px;
        background: #fafbfd;
        color: #65758b;
        font-size: 11px;
        font-weight: 600;
    }

    /* Statistics */
    .pd-payment-stats {
        display: grid;
        grid-template-columns: repeat(5, minmax(0, 1fr));
        gap: 13px;
        margin-bottom: 22px;
    }

    .pd-stat-card {
        position: relative;
        min-width: 0;
        padding: 17px 16px 14px;
        overflow: hidden;
        background: #fff;
        border: 1px solid #e9edf3;
        border-radius: 12px;
        transition: transform .2s ease, box-shadow .2s ease;
    }

    .pd-stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 22px rgba(30, 50, 80, .07);
    }

    .pd-stat-card::after {
        content: "";
        position: absolute;
        top: 0;
        right: 0;
        width: 3px;
        height: 100%;
        background: var(--pd-stat-color);
    }

    .pd-stat-top {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 17px;
    }

    .pd-stat-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 39px;
        height: 39px;
        flex: 0 0 39px;
        border-radius: 10px;
        background: var(--pd-stat-bg);
        color: var(--pd-stat-color);
        font-size: 21px;
    }

    .pd-stat-caption {
        color: #758196;
        font-size: 11px;
        font-weight: 600;
        line-height: 1.8;
    }

    .pd-stat-value {
        display: flex;
        align-items: baseline;
        flex-wrap: wrap;
        gap: 5px;
        color: #273b58;
        font-size: 19px;
        font-weight: 800;
        line-height: 1.7;
        overflow-wrap: anywhere;
        font-variant-numeric: tabular-nums;
    }

    .pd-stat-value small {
        color: #929dad;
        font-size: 10px;
        font-weight: 500;
    }

    .pd-stat-footer {
        margin-top: 8px;
        padding-top: 9px;
        border-top: 1px solid #f0f2f5;
        color: #a0a9b6;
        font-size: 10px;
    }

    /* Stat colors */
    .pd-stat-total {
        --pd-stat-color: #42628f;
        --pd-stat-bg: #edf2fa;
    }

    .pd-stat-approved {
        --pd-stat-color: #269365;
        --pd-stat-bg: #eaf7f0;
    }

    .pd-stat-pending {
        --pd-stat-color: #d39232;
        --pd-stat-bg: #fff6e8;
    }

    .pd-stat-rejected {
        --pd-stat-color: #d65b63;
        --pd-stat-bg: #fff0f0;
    }

    .pd-stat-balance {
        --pd-stat-color: #7959b4;
        --pd-stat-bg: #f3effb;
    }

    /* Table card */
    .pd-payment-table-card {
        overflow: hidden;
        background: #fff;
        border: 1px solid #e8edf3;
        border-radius: 13px;
    }

    .pd-payment-table-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 15px;
        padding: 17px 20px;
        border-bottom: 1px solid #edf0f4;
    }

    .pd-payment-table-title {
        display: flex;
        align-items: center;
        gap: 11px;
    }

    .pd-payment-table-title-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        border-radius: 10px;
        background: #f0f3f8;
        color: #344f76;
        font-size: 21px;
    }

    .pd-payment-table-title h5 {
        margin: 0 0 5px;
        color: #293d5b;
        font-size: 14px;
        font-weight: 800;
    }

    .pd-payment-table-title span {
        color: #929dad;
        font-size: 11px;
    }

    .pd-payment-table-label {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #8390a3;
        font-size: 11px;
    }

    /* Table */
    .pd-payment-table-wrapper {
        width: 100%;
        overflow-x: auto;
    }

    .pd-payment-table {
        width: 100%;
        min-width: 1050px;
        margin: 0;
        border-collapse: separate;
        border-spacing: 0;
        text-align: center;
    }

    .pd-payment-table thead th {
        padding: 14px 12px;
        background: #f7f9fc;
        border-bottom: 1px solid #e9edf3;
        color: #64738a;
        font-size: 11px;
        font-weight: 800;
        white-space: nowrap;
    }

    .pd-payment-table tbody td {
        padding: 14px 12px;
        border-bottom: 1px solid #f0f2f6;
        color: #536176;
        font-size: 11px;
        vertical-align: middle;
        white-space: nowrap;
    }

    .pd-payment-table tbody tr:last-child td {
        border-bottom: 0;
    }

    .pd-payment-table tbody tr {
        transition: background .15s ease;
    }

    .pd-payment-table tbody tr:hover {
        background: #fafbfd;
    }

    .pd-payment-method {
        color: #344d71;
        font-weight: 700;
    }

    .pd-payment-reference {
        direction: ltr;
        display: inline-block;
        color: #718096;
        font-size: 11px;
        font-variant-numeric: tabular-nums;
    }

    .pd-payment-date {
        color: #718096;
        font-variant-numeric: tabular-nums;
    }

    .pd-payment-amount {
        color: #2d425f;
        font-size: 12px;
        font-weight: 800;
        font-variant-numeric: tabular-nums;
    }

    .pd-payment-amount small {
        color: #98a2b0;
        font-size: 9px;
        font-weight: 500;
    }

    .pd-payment-user {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        color: #68778c;
    }

    .pd-payment-user i {
        color: #8293aa;
        font-size: 17px;
    }

    /* Description button */
    .pd-payment-description-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 33px;
        height: 33px;
        border: 1px solid #e4eaf2;
        border-radius: 8px;
        background: #f7f9fc;
        color: #49658e;
        font-size: 17px;
        cursor: pointer;
        transition: all .2s ease;
    }

    .pd-payment-description-btn:hover {
        border-color: #cbd8e9;
        background: #edf2fa;
        color: #304b73;
    }

    /* Status */
    .pd-payment-status {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
        padding: 6px 10px;
        border-radius: 7px;
        font-size: 10px;
        font-weight: 700;
        white-space: nowrap;
    }

    .pd-payment-status i {
        font-size: 14px;
    }

    .pd-status-pending {
        background: #fff6e8;
        color: #bd842b;
    }

    .pd-status-approved {
        background: #eaf7f0;
        color: #27845c;
    }

    .pd-status-rejected {
        background: #fff0f0;
        color: #cb515a;
    }

    .pd-status-review {
        background: #eef2fa;
        color: #526d99;
    }

    /* Empty state */
    .pd-payment-empty {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 40px 15px;
        color: #8793a5;
    }

    .pd-payment-empty i {
        font-size: 35px;
        color: #b5c0cf;
    }

    .pd-payment-empty strong {
        color: #526176;
        font-size: 13px;
    }

    .pd-payment-empty span {
        font-size: 11px;
    }

    /* Responsive */
    @media (max-width: 1200px) {
        .pd-payment-stats {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }
    }

    @media (max-width: 768px) {
        .pd-payment-heading {
            flex-wrap: wrap;
            padding: 13px;
        }

        .pd-payment-heading-tag {
            margin-right: 57px;
        }

        .pd-payment-stats {
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 9px;
        }

        .pd-stat-card {
            padding: 13px 12px;
        }

        .pd-stat-top {
            gap: 8px;
            margin-bottom: 12px;
        }

        .pd-stat-value {
            font-size: 16px;
        }

        .pd-payment-table-header {
            padding: 14px;
        }

        .pd-payment-table-label {
            display: none;
        }
    }

    @media (max-width: 420px) {
        .pd-payment-stats {
            grid-template-columns: 1fr;
        }

        .pd-stat-card {
            padding: 14px;
        }

        .pd-stat-top {
            margin-bottom: 9px;
        }

        .pd-stat-footer {
            margin-top: 5px;
        }
    }

</style>

<div class="pd-payment-page">

    <!-- عنوان بخش -->
    <div class="pd-payment-heading">
        <div class="pd-payment-heading-icon">
            <i class="bx bx-wallet"></i>
        </div>
        <div class="pd-payment-heading-info">
            <h4>گزارش مالی پیش‌فاکتور</h4>
            <span>خلاصه وضعیت پرداخت‌ها و گردش مالی</span>
        </div>
        <div class="pd-payment-heading-tag">
            <i class="bx bx-receipt"></i>
            اطلاعات مالی
        </div>
    </div>

    <!-- کارت‌های آماری -->
    <div class="pd-payment-stats">

        <div class="pd-stat-card pd-stat-total">
            <div class="pd-stat-top">
                <div class="pd-stat-icon">
                    <i class="bx bx-wallet"></i>
                </div>
                <span class="pd-stat-caption">مبلغ کل پیش‌فاکتور</span>
            </div>
            <div class="pd-stat-value">
                {number_format($paymentData['invoice_sum_total'])}
                <small>ریال</small>
            </div>
            <div class="pd-stat-footer">مبلغ نهایی پیش‌فاکتور</div>
        </div>

        <div class="pd-stat-card pd-stat-approved">
            <div class="pd-stat-top">
                <div class="pd-stat-icon">
                    <i class="bx bx-check-circle"></i>
                </div>
                <span class="pd-stat-caption">واریزی تأیید شده</span>
            </div>
            <div class="pd-stat-value">
                {number_format($paymentData['approvedPayment'])}
                <small>ریال</small>
            </div>
            <div class="pd-stat-footer">مجموع پرداخت‌های تأییدشده</div>
        </div>

        <div class="pd-stat-card pd-stat-pending">
            <div class="pd-stat-top">
                <div class="pd-stat-icon">
                    <i class="bx bx-time-five"></i>
                </div>
                <span class="pd-stat-caption">در انتظار تأیید</span>
            </div>
            <div class="pd-stat-value">
                {number_format($paymentData['preparingPayment'])}
                <small>ریال</small>
            </div>
            <div class="pd-stat-footer">پرداخت‌های بررسی‌نشده</div>
        </div>

        <div class="pd-stat-card pd-stat-rejected">
            <div class="pd-stat-top">
                <div class="pd-stat-icon">
                    <i class="bx bx-x-circle"></i>
                </div>
                <span class="pd-stat-caption">واریزی تأیید نشده</span>
            </div>
            <div class="pd-stat-value">
                {number_format($paymentData['canceledPayment'])}
                <small>ریال</small>
            </div>
            <div class="pd-stat-footer">مجموع پرداخت‌های ردشده</div>
        </div>

        <div class="pd-stat-card pd-stat-balance">
            <div class="pd-stat-top">
                <div class="pd-stat-icon">
                    <i class="bx bx-money"></i>
                </div>
                <span class="pd-stat-caption">مانده قابل پرداخت</span>
            </div>
            <div class="pd-stat-value">
                {number_format($paymentData['invoice_sum_total'] - $paymentData['approvedPayment'])}
                <small>ریال</small>
            </div>
            <div class="pd-stat-footer">مبلغ کل منهای واریزی تأییدشده</div>
        </div>

    </div>

    <!-- جدول پرداخت‌ها -->
    <div class="pd-payment-table-card">

        <div class="pd-payment-table-header">
            <div class="pd-payment-table-title">
                <div class="pd-payment-table-title-icon">
                    <i class="bx bx-list-ul"></i>
                </div>
                <div>
                    <h5>تاریخچه پرداخت‌ها</h5>
                    <span>جزئیات و وضعیت تمامی واریزی‌های ثبت‌شده</span>
                </div>
            </div>

            <div class="pd-payment-table-label">
                <i class="bx bx-detail"></i>
                جزئیات تراکنش‌ها
            </div>
        </div>

        <div class="pd-payment-table-wrapper">
            <table class="pd-payment-table">
                <thead>
                <tr>
                    <th>نحوه پرداخت</th>
                    <th>بانک</th>
                    <th>شناسه واریز</th>
                    <th>شماره چک</th>
                    <th>تاریخ واریز</th>
                    <th>مبلغ پرداختی</th>
                    <th>توضیحات</th>
                    <th>وضعیت پرداخت</th>
                    <th>کاربر ثبت‌کننده</th>
                </tr>
                </thead>

                <tbody>
                {foreach $invoicePaymentDetail as $data}
                    <tr>
                        <td>
                            <span class="pd-payment-method">
                                {$data.payment.paymentMethodData.title|default:'-'}
                            </span>
                        </td>

                        <td>{$data.payment.bankAccountData.bank_branch_name|default:'-'}</td>

                        <td>
                            <span class="pd-payment-reference">
                                {$data.payment.reference_no|default:'-'}
                            </span>
                        </td>

                        <td>{$data.payment.chequeData.cheque_number|default:'-'}</td>

                        <td>
                            <span class="pd-payment-date">
                                {jdate("Y/m/d",$data.payment.date_deposit)|default:'-'}
                            </span>
                        </td>

                        <td>
                            <span class="pd-payment-amount">
                                {number_format($data.payment.amount_paid)|default:'-'}
                                <small>ریال</small>
                            </span>
                        </td>

                        <td>
                            <button type="button"
                                    class="pd-payment-description-btn viewDescription"
                                    data-text="{$data.payment.payment_description|default:'-'}"
                                    title="مشاهده توضیحات">
                                <i class="bx bx-note"></i>
                            </button>
                        </td>

                        <td>
                            {if $data.status === 0}
                                <span class="pd-payment-status pd-status-pending">
                                    <i class="bx bx-time-five"></i>
                                    در انتظار تأیید
                                </span>
                            {elseif $data.status === 1}
                                <span class="pd-payment-status pd-status-approved">
                                    <i class="bx bx-check-circle"></i>
                                    تأیید شده
                                </span>
                            {elseif $data.status === 2}
                                <span class="pd-payment-status pd-status-rejected">
                                    <i class="bx bx-x-circle"></i>
                                    عدم تأیید
                                </span>
                            {else}
                                <span class="pd-payment-status pd-status-review">
                                    <i class="bx bx-refresh"></i>
                                    بررسی مجدد
                                </span>
                            {/if}
                        </td>

                        <td>
                            <div class="pd-payment-user">
                                <i class="bx bx-user-circle"></i>
                                {$data.payment.userData.full_name|default:'-'}
                            </div>
                        </td>
                    </tr>
                    {foreachelse}
                    <tr>
                        <td colspan="9">
                            <div class="pd-payment-empty">
                                <i class="bx bx-receipt"></i>
                                <strong>پرداختی ثبت نشده است</strong>
                                <span>هنوز هیچ تراکنشی برای این پیش‌فاکتور ثبت نشده است.</span>
                            </div>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>

    </div>

</div>
