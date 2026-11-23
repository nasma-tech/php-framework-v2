<style>

    /* =====================================
       Contract Financial Cards
    ===================================== */

    .cc-contract-stat {
        position: relative;
        overflow: hidden;
        border: 1px solid #edf0f5;
        border-radius: 12px;
        box-shadow: 0 3px 12px rgba(25, 42, 70, 0.05);
        transition: all 0.25s ease;
    }

    .cc-contract-stat:hover {
        transform: translateY(-3px);
        box-shadow: 0 7px 20px rgba(25, 42, 70, 0.09);
    }

    .cc-contract-stat .card-body {
        padding: 18px 17px !important;
        position: relative;
        z-index: 1;
    }

    .cc-contract-stat::after {
        content: "";
        position: absolute;
        width: 95px;
        height: 95px;
        border-radius: 50%;
        left: -28px;
        bottom: -48px;
        opacity: 0.06;
        background: currentColor;
        pointer-events: none;
    }

    .cc-contract-stat-top {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 18px;
    }

    .cc-contract-stat-icon {
        width: 38px;
        height: 38px;
        min-width: 38px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        font-size: 21px;
    }

    .cc-contract-stat-label {
        font-size: 12px;
        font-weight: 600;
        color: #65718a;
    }

    .cc-contract-stat-value {
        direction: ltr;
        text-align: right;
        font-size: 23px;
        font-weight: 800;
        line-height: 1.5;
        letter-spacing: -0.5px;
        white-space: nowrap;
    }

    .cc-contract-stat-value small {
        font-size: 11px;
        font-weight: 500;
        margin-right: 3px;
        letter-spacing: 0;
    }

    .cc-contract-stat-footer {
        display: flex;
        align-items: center;
        justify-content: space-between;
        border-top: 1px solid rgba(130, 145, 170, 0.13);
        margin-top: 14px;
        padding-top: 11px;
        font-size: 10px;
        color: #8a94a6;
    }

    .cc-contract-stat-footer i {
        font-size: 17px;
    }

    /* =====================================
       1. Total Contract - Blue
    ===================================== */

    .cc-contract-total {
        color: #315fbd;
        background: linear-gradient(135deg, #ffffff 0%, #f1f5ff 100%);
        border-right: 3px solid #4779dc;
    }

    .cc-contract-total .cc-contract-stat-icon {
        background: #e5edff;
        color: #4779dc;
    }

    .cc-contract-total .cc-contract-stat-value {
        color: #263f70;
    }

    .cc-contract-total .cc-contract-stat-footer i {
        color: #4779dc;
    }

    /* =====================================
       2. Total Paid - Green
    ===================================== */

    .cc-contract-paid {
        color: #15966b;
        background: linear-gradient(135deg, #ffffff 0%, #effaf5 100%);
        border-right: 3px solid #24ae7b;
    }

    .cc-contract-paid .cc-contract-stat-icon {
        background: #ddf6e9;
        color: #20a875;
    }

    .cc-contract-paid .cc-contract-stat-value {
        color: #16865e;
    }

    .cc-contract-paid .cc-contract-stat-footer i {
        color: #20a875;
    }

    /* =====================================
       3. Approved Payments - Dark Green
    ===================================== */

    .cc-contract-approved {
        color: #16834b;
        background: linear-gradient(135deg, #ffffff 0%, #edf9f0 100%);
        border-right: 3px solid #16834b;
    }

    .cc-contract-approved .cc-contract-stat-icon {
        background: #d9f1df;
        color: #16834b;
    }

    .cc-contract-approved .cc-contract-stat-value {
        color: #126b3d;
    }

    .cc-contract-approved .cc-contract-stat-footer i {
        color: #16834b;
    }

    /* =====================================
       4. Pending Payments - Orange
    ===================================== */

    .cc-contract-pending {
        color: #dc8b17;
        background: linear-gradient(135deg, #ffffff 0%, #fff7eb 100%);
        border-right: 3px solid #e99a28;
    }

    .cc-contract-pending .cc-contract-stat-icon {
        background: #fff0d6;
        color: #dc8b17;
    }

    .cc-contract-pending .cc-contract-stat-value {
        color: #bd7815;
    }

    .cc-contract-pending .cc-contract-stat-footer i {
        color: #dc8b17;
    }

    /* =====================================
       Responsive
    ===================================== */

    @media (max-width: 575px) {
        .cc-contract-stat .card-body {
            padding: 15px !important;
        }

        .cc-contract-stat-value {
            font-size: 20px;
        }
    }


    /* Contract Convert Action */

    .cc-convert-card {
        margin-top: 20px;
        border: 1px solid #e4eee8;
        border-radius: 12px;
        background: linear-gradient(120deg, #ffffff 0%, #f3faf6 100%);
        box-shadow: 0 3px 12px rgba(25, 42, 70, 0.04);
        overflow: hidden;
    }

    .cc-convert-card .card-body {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 20px;
        padding: 17px 20px;
    }

    .cc-convert-info {
        display: flex;
        align-items: center;
        gap: 13px;
        min-width: 0;
    }

    .cc-convert-icon {
        width: 43px;
        height: 43px;
        min-width: 43px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 11px;
        background: #e1f3e8;
        color: #23965b;
        font-size: 23px;
    }

    .cc-convert-text h6 {
        margin: 0 0 5px;
        color: #24583c;
        font-size: 13px;
        font-weight: 700;
    }

    .cc-convert-text p {
        margin: 0;
        color: #82918a;
        font-size: 11px;
        line-height: 1.8;
    }

    .cc-convert-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        flex-shrink: 0;
        padding: 10px 18px;
        border: 0;
        border-radius: 8px;
        background: linear-gradient(135deg, #28a66a, #198653);
        color: #fff !important;
        font-size: 12px;
        font-weight: 600;
        box-shadow: 0 4px 10px rgba(32, 145, 88, 0.18);
        transition: all 0.2s ease;
    }

    .cc-convert-btn i {
        font-size: 17px;
    }

    .cc-convert-btn:hover {
        background: linear-gradient(135deg, #218e5a, #147447);
        box-shadow: 0 6px 14px rgba(32, 145, 88, 0.25);
        transform: translateY(-2px);
    }

    @media (max-width: 576px) {
        .cc-convert-card .card-body {
            align-items: stretch;
            flex-direction: column;
            gap: 15px;
        }

        .cc-convert-btn {
            width: 100%;
        }
    }


</style>

<div class="row">
    <div class="col-md-4">
        <div class="card cc-contract-stat cc-contract-total">
            <div class="card-content">
                <div class="card-body">
                    <div class="cc-contract-stat-top">
                        <div class="cc-contract-stat-icon">
                            <i class="bx bx-file"></i>
                        </div>
                        <span class="cc-contract-stat-label">
                                مبلغ کل قرارداد
                            </span>
                    </div>
                    <div class="cc-contract-stat-value">
                        {$numberNormalizer->floatNumberFormat($getData.invoiceDetail.invoice_sum_total)}
                        <small>ریال</small>
                    </div>
                    <div class="cc-contract-stat-footer">
                        <span>ارزش نهایی قرارداد</span>
                        <i class="bx bx-trending-up"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card cc-contract-stat cc-contract-paid">
            <div class="card-content">
                <div class="card-body">
                    <div class="cc-contract-stat-top">
                        <div class="cc-contract-stat-icon">
                            <i class="bx bx-wallet"></i>
                        </div>
                        <span class="cc-contract-stat-label">
                                مجموع واریزی
                            </span>
                    </div>
                    <div class="cc-contract-stat-value">
                        {$numberNormalizer->floatNumberFormat($getData.paymentAllocation->sum('payment_amount'))}
                        <small>ریال</small>
                    </div>

                    <div class="cc-contract-stat-footer">
                        <span>مبلغ دریافت‌شده</span>
                        <i class="bx bx-check-circle"></i>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card cc-contract-stat cc-contract-approved">
            <div class="card-content">
                <div class="card-body">
                    <div class="cc-contract-stat-top">
                        <div class="cc-contract-stat-icon">
                            <i class="bx bx-wallet"></i>
                        </div>
                        <span class="cc-contract-stat-label">
                                مجموع واریزی تایید شده
                            </span>
                    </div>
                    <div class="cc-contract-stat-value">
                        {$numberNormalizer->floatNumberFormat($getData.paymentAllocation->where('status',1)->sum('payment_amount'))}
                        <small>ریال</small>
                    </div>
                    <div class="cc-contract-stat-footer">
                        <span>مبلغ دریافت‌شده</span>
                        <i class="bx bx-check-circle"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="card cc-convert-card">
            <div class="card-content">
                {if $getData.contract}
                    <div class="card-body">
                        <div class="cc-convert-info">
                            <div class="cc-convert-icon">
                                <i class="bx bx-file-blank"></i>
                            </div>
                            <div class="cc-convert-text">
                                <h6>به قرارداد تبدیل شده است</h6>
                                <p>در تاریخ ..... توسط .......... به قرارداد تبدیل شده است</p>
                            </div>
                        </div>
                    </div>
                {else}
                    <div class="card-body">
                        <div class="cc-convert-info">
                            <div class="cc-convert-icon">
                                <i class="bx bx-file-blank"></i>
                            </div>
                            <div class="cc-convert-text">
                                <h6>آماده استعلام و تبدیل پیشفاکتور به قرارداد هستید؟</h6>
                                <p>برای نهایی‌سازی پیش‌فاکتور و تبدیل آن به قرارداد، از دکمه مقابل استفاده کنید.</p>
                            </div>
                        </div>
                        <button type="button" class="btn cc-convert-btn" id="convertToContractButton">
                            <i class="bx bx-transfer-alt"></i>
                            تبدیل به قرارداد
                        </button>
                    </div>
                {/if}

            </div>
        </div>
    </div>
</div>