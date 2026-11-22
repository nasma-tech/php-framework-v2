<style>
    /* Contract financial cards */
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

    /* Total contract */
    .cc-contract-total {
        color: #315fbd;
        background: linear-gradient(135deg, #ffffff 0%, #f4f7ff 100%);
        border-right: 3px solid #4779dc;
    }

    .cc-contract-total .cc-contract-stat-icon {
        background: #e8efff;
        color: #4779dc;
    }

    .cc-contract-total .cc-contract-stat-value {
        color: #263f70;
    }

    .cc-contract-total .cc-contract-stat-footer i {
        color: #4779dc;
    }

    /* Paid amount */
    .cc-contract-paid {
        color: #15966b;
        background: linear-gradient(135deg, #ffffff 0%, #f1fbf6 100%);
        border-right: 3px solid #24ae7b;
    }

    .cc-contract-paid .cc-contract-stat-icon {
        background: #e2f7ed;
        color: #20a875;
    }

    .cc-contract-paid .cc-contract-stat-value {
        color: #167a58;
    }

    .cc-contract-paid .cc-contract-stat-footer i {
        color: #20a875;
    }
</style>
<div class="row">
    <div class="col-md-6">
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
                        1,250,000,000
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
    <div class="col-md-6">
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
                        450,000,000
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
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead class="thead-dark">
                    <tr>

                    </tr>
                </thead>
            </table>
        </div>
    </div>
</div>