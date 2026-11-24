{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<style>

    /* =========================================
       CONTRACT PAGE
    ========================================= */

    .cc-contract-page {
        direction: rtl;
        width: 100%;
        color: #263449;
        font-size: 13px;
    }

    .cc-contract-page * {
        box-sizing: border-box;
    }

    .cc-contract-page button {
        font-family: inherit;
        cursor: pointer;
    }

    /* =========================================
       HEADER
    ========================================= */

    .cc-contract-header {
        position: relative;
        overflow: hidden;
        padding: 22px 24px 18px;
        margin-bottom: 18px;
        background: linear-gradient(120deg, #172d50 0%, #244d7c 100%);
        border-radius: 12px;
        color: #fff;
        box-shadow: 0 5px 18px rgba(25, 52, 85, .12);
    }

    .cc-contract-header::before {
        content: "";
        position: absolute;
        top: 0;
        right: 0;
        width: 4px;
        height: 100%;
        background: #e45a5a;
    }

    .cc-contract-header-main {
        display: flex;
        align-items: center;
        gap: 14px;
    }

    .cc-contract-file-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 50px;
        height: 50px;
        flex-shrink: 0;
        background: rgba(255, 255, 255, .12);
        border: 1px solid rgba(255, 255, 255, .15);
        border-radius: 12px;
        font-size: 27px;
    }

    .cc-contract-heading {
        min-width: 0;
        flex: 1;
    }

    .cc-contract-title-row {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 12px;
    }

    .cc-contract-title-row h4 {
        margin: 0;
        color: #fff;
        font-size: 17px;
        font-weight: 700;
    }

    .cc-contract-status {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 10px;
        color: #b8f3d0;
        background: rgba(22, 163, 74, .19);
        border: 1px solid rgba(134, 239, 172, .25);
        border-radius: 20px;
        font-size: 11px;
    }

    .cc-contract-status-cancel {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 10px;
        color: #fecaca;
        background: rgba(220, 38, 38, .18);
        border: 1px solid rgba(248, 113, 113, .3);
        border-radius: 20px;
        font-size: 11px;
    }

    .cc-contract-subtitle {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 16px;
        margin-top: 9px;
        color: #d2deed;
        font-size: 12px;
    }

    .cc-contract-subtitle span {
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .cc-contract-header-actions {
        display: flex;
        align-items: center;
        gap: 8px;
        position: absolute;
        left: 24px;
        top: 24px;
    }

    .cc-contract-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        min-height: 36px;
        padding: 0 13px;
        border-radius: 7px;
        font-size: 12px;
        font-weight: 600;
        transition: .2s ease;
    }

    .cc-contract-btn i {
        font-size: 17px;
    }

    .cc-contract-btn-primary {
        color: #fff;
        background: #16845b;
        border: 1px solid #16845b;
    }

    .cc-contract-btn-primary:hover {
        background: #116b49;
    }

    .cc-contract-btn-light {
        color: #fff;
        background: rgba(255, 255, 255, .10);
        border: 1px solid rgba(255, 255, 255, .23);
    }

    .cc-contract-btn-light:hover {
        background: rgba(255, 255, 255, .18);
    }

    .cc-contract-header-meta {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 15px;
        margin-top: 22px;
        padding-top: 15px;
        border-top: 1px solid rgba(255, 255, 255, .13);
    }

    .cc-contract-meta-item {
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .cc-contract-meta-item span {
        color: #b9c9dc;
        font-size: 11px;
    }

    .cc-contract-meta-item strong {
        color: #fff;
        font-size: 12px;
        font-weight: 600;
    }

    /* =========================================
       FINANCIAL STATS
    ========================================= */

    .cc-contract-stats {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 13px;
        margin-bottom: 18px;
    }

    .cc-contract-stat {
        display: flex;
        align-items: center;
        gap: 12px;
        min-width: 0;
        padding: 15px;
        background: #fff;
        border: 1px solid #e9edf3;
        border-radius: 10px;
        box-shadow: 0 2px 9px rgba(30, 50, 80, .035);
    }

    .cc-contract-stat-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 43px;
        height: 43px;
        flex-shrink: 0;
        border-radius: 10px;
        font-size: 23px;
    }

    .cc-contract-stat-content {
        display: flex;
        flex-direction: column;
        min-width: 0;
        gap: 5px;
    }

    .cc-contract-stat-content span {
        color: #7b8797;
        font-size: 11px;
    }

    .cc-contract-stat-content strong {
        color: #263449;
        font-size: 15px;
        font-weight: 700;
        direction: ltr;
        text-align: right;
        white-space: nowrap;
    }

    .cc-contract-stat-content small {
        color: #9ba5b3;
        font-size: 10px;
    }

    .cc-stat-total .cc-contract-stat-icon {
        color: #2563eb;
        background: #edf4ff;
    }

    .cc-stat-paid .cc-contract-stat-icon {
        color: #15945c;
        background: #eaf8f0;
    }

    .cc-stat-pending .cc-contract-stat-icon {
        color: #d97706;
        background: #fff6e8;
    }

    .cc-stat-balance .cc-contract-stat-icon {
        color: #7c3aed;
        background: #f3efff;
    }

    /* =========================================
       TABS
    ========================================= */

    .cc-contract-tabs-card {
        overflow: hidden;
        margin-bottom: 18px;
        background: #fff;
        border: 1px solid #e8edf3;
        border-radius: 11px;
        box-shadow: 0 2px 10px rgba(30, 50, 80, .035);
    }

    .cc-contract-tabs {
        display: flex;
        align-items: center;
        gap: 4px;
        padding: 0 15px;
        border-bottom: 1px solid #edf0f4;
        overflow-x: auto;
    }

    .cc-contract-tab {
        position: relative;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        flex-shrink: 0;
        padding: 16px 13px;
        color: #788597;
        background: transparent;
        border: 0;
        font-size: 12px;
        font-weight: 500;
        transition: .2s ease;
    }

    .cc-contract-tab i {
        font-size: 17px;
    }

    .cc-contract-tab:hover {
        color: #244d7c;
    }

    .cc-contract-tab.active {
        color: #244d7c;
        font-weight: 700;
    }

    .cc-contract-tab.active::after {
        content: "";
        position: absolute;
        right: 10px;
        left: 10px;
        bottom: 0;
        height: 3px;
        background: #244d7c;
        border-radius: 5px 5px 0 0;
    }

    .cc-contract-tab-count {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 19px;
        height: 19px;
        padding: 0 5px;
        color: #24528a;
        background: #eaf1fa;
        border-radius: 20px;
        font-size: 10px;
    }

    .cc-contract-tab-content {
        padding: 22px;
    }

    /* =========================================
       SECTION HEADING
    ========================================= */

    .cc-contract-section-heading {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 15px;
        margin-bottom: 22px;
    }

    .cc-contract-section-heading h5,
    .cc-contract-info-heading h5 {
        display: flex;
        align-items: center;
        gap: 8px;
        margin: 0;
        color: #263b56;
        font-size: 14px;
        font-weight: 700;
    }

    .cc-contract-section-heading h5 i,
    .cc-contract-info-heading > i {
        color: #315d8b;
        font-size: 20px;
    }

    .cc-contract-section-heading p {
        margin: 7px 0 0;
        color: #929cab;
        font-size: 11px;
    }

    .cc-contract-total-badge {
        padding: 6px 11px;
        color: #315d8b;
        background: #edf4fb;
        border-radius: 6px;
        font-size: 11px;
        white-space: nowrap;
    }

    /* =========================================
       ADDENDUM TIMELINE
    ========================================= */

    .cc-contract-timeline {
        position: relative;
        padding-right: 25px;
    }

    .cc-contract-timeline::before {
        content: "";
        position: absolute;
        top: 18px;
        right: 10px;
        bottom: 38px;
        width: 2px;
        background: #e7edf4;
    }

    .cc-contract-timeline-item {
        position: relative;
        padding-bottom: 18px;
    }

    .cc-contract-timeline-item:last-child {
        padding-bottom: 0;
    }

    .cc-contract-timeline-marker {
        position: absolute;
        top: 15px;
        right: -25px;
        z-index: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 29px;
        height: 29px;
        color: #2862a1;
        background: #edf4fc;
        border: 2px solid #fff;
        border-radius: 50%;
        box-shadow: 0 0 0 1px #dce7f3;
        font-size: 15px;
    }

    .cc-contract-timeline-item.original .cc-contract-timeline-marker {
        color: #7d8794;
        background: #f0f2f5;
        box-shadow: 0 0 0 1px #e0e4e9;
    }

    .cc-contract-addendum {
        padding: 16px 17px;
        background: #fff;
        border: 1px solid #e8edf3;
        border-radius: 9px;
        transition: .2s ease;
    }

    .cc-contract-addendum:hover {
        border-color: #cbd9e9;
        box-shadow: 0 4px 13px rgba(34, 64, 100, .055);
    }

    .cc-contract-addendum-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 10px;
    }

    .cc-contract-addendum-title {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 9px;
    }

    .cc-contract-addendum-title strong {
        color: #2d4059;
        font-size: 13px;
        font-weight: 700;
    }

    .cc-contract-version {
        padding: 3px 7px;
        color: #75859a;
        background: #f1f4f8;
        border-radius: 4px;
        font-size: 10px;
    }

    .cc-contract-addendum-status {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 5px 9px;
        border-radius: 5px;
        font-size: 10px;
    }

    .cc-contract-addendum-status.approved {
        color: #16824f;
        background: #eaf7ef;
    }

    .cc-contract-addendum-status.original-status {
        color: #697586;
        background: #f0f2f5;
    }

    .cc-contract-addendum-meta {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 17px;
        margin-top: 12px;
        color: #8a96a6;
        font-size: 11px;
    }

    .cc-contract-addendum-meta span {
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .cc-contract-addendum-meta i {
        font-size: 15px;
    }

    .cc-contract-addendum-description {
        margin: 13px 0;
        color: #59697e;
        font-size: 12px;
        line-height: 1.9;
    }

    .cc-contract-change-box {
        display: flex;
        flex-wrap: wrap;
        gap: 35px;
        padding: 12px 14px;
        background: #f8fafc;
        border: 1px solid #edf1f5;
        border-radius: 7px;
    }

    .cc-contract-change-box > div {
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .cc-contract-change-box span {
        color: #8b97a7;
        font-size: 10px;
    }

    .cc-contract-change-box strong {
        color: #34445a;
        font-size: 12px;
        font-weight: 700;
    }

    .cc-contract-change-box strong.increase {
        color: #15945c;
    }

    .cc-contract-change-box strong.neutral {
        color: #7b8797;
    }

    .cc-contract-addendum-footer {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 13px;
        padding-top: 11px;
        border-top: 1px solid #edf0f4;
    }

    .cc-contract-addendum-footer > span {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        color: #8793a2;
        font-size: 11px;
    }

    .cc-contract-addendum-footer > span i {
        font-size: 16px;
    }

    .cc-contract-detail-btn {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 5px 8px;
        color: #315d8b;
        background: transparent;
        border: 0;
        border-radius: 5px;
        font-size: 11px;
        font-weight: 600;
    }

    .cc-contract-detail-btn:hover {
        color: #183e6a;
        background: #edf4fb;
    }

    .cc-contract-detail-btn i {
        font-size: 16px;
    }

    /* =========================================
       INFORMATION CARDS
    ========================================= */

    .cc-contract-info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
        margin-bottom: 18px;
    }

    .cc-contract-info-card {
        min-width: 0;
        padding: 18px;
        background: #fff;
        border: 1px solid #e8edf3;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(30, 50, 80, .035);
    }

    .cc-contract-info-heading {
        display: flex;
        align-items: center;
        gap: 9px;
        margin-bottom: 16px;
    }

    .cc-contract-info-heading h5 {
        flex: 1;
    }

    .cc-contract-info-list {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 0 20px;
    }

    .cc-contract-info-list > div {
        display: flex;
        flex-direction: column;
        gap: 6px;
        padding: 11px 0;
        border-bottom: 1px solid #f0f2f5;
    }

    .cc-contract-info-list > div:nth-last-child(-n+2) {
        border-bottom: 0;
    }

    .cc-contract-info-list span {
        color: #929cab;
        font-size: 10px;
    }

    .cc-contract-info-list strong {
        color: #34445a;
        font-size: 12px;
        font-weight: 600;
    }

    /* =========================================
       DOCUMENTS
    ========================================= */

    .cc-contract-document {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 11px 0;
        border-bottom: 1px solid #f0f2f5;
    }

    .cc-contract-document:last-child {
        border-bottom: 0;
    }

    .cc-contract-document-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 39px;
        height: 39px;
        flex-shrink: 0;
        color: #dc5252;
        background: #fff0f0;
        border-radius: 8px;
        font-size: 22px;
    }

    .cc-contract-document-info {
        display: flex;
        flex-direction: column;
        flex: 1;
        min-width: 0;
        gap: 5px;
    }

    .cc-contract-document-info strong {
        overflow: hidden;
        color: #34445a;
        font-size: 12px;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .cc-contract-document-info span {
        color: #929cab;
        font-size: 10px;
    }

    .cc-contract-document > button {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 31px;
        height: 31px;
        color: #315d8b;
        background: #edf4fb;
        border: 0;
        border-radius: 6px;
        font-size: 17px;
    }

    /* =========================================
       PAYMENTS TABLE
    ========================================= */

    .cc-contract-payments-card {
        margin-bottom: 20px;
    }

    .cc-contract-payments-card .cc-contract-info-heading {
        flex-wrap: wrap;
    }

    .cc-contract-table-wrapper {
        width: 100%;
        overflow-x: auto;
    }

    .cc-contract-table {
        width: 100%;
        min-width: 650px;
        border-collapse: collapse;
        text-align: right;
    }

    .cc-contract-table th {
        padding: 12px 13px;
        color: #788597;
        background: #f7f9fb;
        border-bottom: 1px solid #e9edf2;
        font-size: 11px;
        font-weight: 600;
        white-space: nowrap;
    }

    .cc-contract-table td {
        padding: 13px;
        color: #47566b;
        border-bottom: 1px solid #f0f2f5;
        font-size: 11px;
        white-space: nowrap;
    }

    .cc-contract-table tbody tr:last-child td {
        border-bottom: 0;
    }

    .cc-contract-table tbody tr:hover {
        background: #fafbfd;
    }

    .cc-contract-payment-status {
        display: inline-block;
        padding: 5px 8px;
        border-radius: 5px;
        font-size: 10px;
    }

    .cc-contract-payment-status.approved {
        color: #16824f;
        background: #eaf7ef;
    }

    .cc-contract-payment-status.pending {
        color: #c27a12;
        background: #fff5e5;
    }

    .cc-contract-table-action {
        padding: 5px 9px;
        color: #315d8b;
        background: #edf4fb;
        border: 0;
        border-radius: 5px;
        font-size: 10px;
    }

    /* =========================================
       RESPONSIVE
    ========================================= */

    @media (max-width: 1100px) {
        .cc-contract-stats {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .cc-contract-header-actions {
            position: static;
            margin-top: 17px;
        }

        .cc-contract-header-meta {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 768px) {
        .cc-contract-header {
            padding: 18px;
        }

        .cc-contract-info-grid {
            grid-template-columns: 1fr;
        }

        .cc-contract-tab-content {
            padding: 16px 12px;
        }

        .cc-contract-section-heading {
            align-items: flex-start;
            flex-direction: column;
        }

        .cc-contract-change-box {
            gap: 15px;
        }

        .cc-contract-addendum {
            padding: 13px;
        }
    }

    @media (max-width: 480px) {
        .cc-contract-header-main {
            align-items: flex-start;
        }

        .cc-contract-file-icon {
            width: 42px;
            height: 42px;
            font-size: 23px;
        }

        .cc-contract-title-row h4 {
            font-size: 14px;
        }

        .cc-contract-subtitle {
            flex-direction: column;
            align-items: flex-start;
            gap: 7px;
        }

        .cc-contract-header-meta {
            gap: 14px 10px;
        }

        .cc-contract-stats {
            grid-template-columns: 1fr 1fr;
            gap: 8px;
        }

        .cc-contract-stat {
            align-items: flex-start;
            flex-direction: column;
            gap: 8px;
            padding: 11px;
        }

        .cc-contract-stat-icon {
            width: 34px;
            height: 34px;
            font-size: 19px;
        }

        .cc-contract-stat-content strong {
            font-size: 12px;
        }

        .cc-contract-tabs {
            padding: 0 8px;
        }

        .cc-contract-tab {
            padding: 13px 10px;
            font-size: 11px;
        }

        .cc-contract-info-list {
            grid-template-columns: 1fr;
        }

        .cc-contract-info-list > div:nth-last-child(2) {
            border-bottom: 1px solid #f0f2f5;
        }

        .cc-contract-addendum-header {
            align-items: flex-start;
        }

        .cc-contract-addendum-footer {
            align-items: flex-start;
        }
    }

</style>
<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">{$singleName}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndBackBtn()}
                        </div>
                    </div>
                    <hr>
                    <div class="card-content">
                        <div class="card-body">

                            <div class="cc-contract-page" dir="rtl">

                                <!-- Contract Header -->
                                <div class="cc-contract-header">
                                    <div class="cc-contract-header-main">
                                        <div class="cc-contract-file-icon">
                                            <i class="bx bx-file-blank"></i>
                                        </div>

                                        <div class="cc-contract-heading">
                                            <div class="cc-contract-title-row">
                                                <h4>قرارداد شماره {$getData.proformaInvoice.invoice_number}</h4>
                                                {if !$getData.cancelContract}
                                                    <span class="cc-contract-status"><i class="bx bx-check-circle"></i>فعال</span>
                                                    {else}
                                                    <span class="cc-contract-status-cancel"><i class="bx bx-check-circle"></i>غیر فعال</span>
                                                {/if}
                                            </div>

                                            <div class="cc-contract-subtitle">
                                                <span><i class="bx bx-user"></i>{$getData.proformaInvoice.contact.first_name} {$getData.proformaInvoice.contact.last_name}</span>
                                                <span><i class="bx bx-buildings"></i>{$getData.proformaInvoice.company.company_name|default:' - '}</span>
                                                <span><i class="bx bx-calendar-alt"></i> پیش‌فاکتور اولیه: {jdate("Y/m/d",strtotime($getData.proformaInvoice.created_at))}</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="cc-contract-header-actions">
                                        {if !$getData.cancelContract}
                                        <a href="/ProformaInvoice/editIndex/{$getData.proforma_invoice_id}"
                                           class="cc-contract-btn cc-contract-btn-primary text-white">
                                            <i class="bx bx-file-plus"></i>
                                            ثبت الحاقیه جدید
                                        </a>
                                        {/if}

                                        <button type="button" class="cc-contract-btn cc-contract-btn-light">
                                            <i class="bx bx-dots-vertical-rounded"></i>
                                            عملیات
                                        </button>
                                    </div>

                                    <div class="cc-contract-header-meta">
                                        <div class="cc-contract-meta-item">
                                            <span>تاریخ قرارداد</span>
                                            <strong>{jdate("Y/m/d",$getData.convert_to_contract)}</strong>
                                        </div>
                                        {if $getData.cancelContract}
                                            <div class="cc-contract-meta-item">
                                                <span>تاریخ لغو قرارداد</span>
                                                <strong>{jdate("Y/m/d",$getData.cancelContract.cancel_date_time)}</strong>
                                            </div>
                                        {/if}

                                        <div class="cc-contract-meta-item">
                                            <span>تعداد الحاقیه‌ها</span>
                                            <strong>{$getData.addendum_count} مورد</strong>
                                        </div>
                                    </div>
                                </div>

                                <!-- Financial Statistics -->
                                <div class="cc-contract-stats">
                                    <div class="cc-contract-stat cc-stat-total">
                                        <div class="cc-contract-stat-icon">
                                            <i class="bx bx-wallet"></i>
                                        </div>
                                        <div class="cc-contract-stat-content">
                                            <span>مبلغ فعلی قرارداد</span>
                                            <strong>{$numberNormalizer->floatNumberFormat($getData.proformaInvoice.invoiceDetail.invoice_sum_total)}</strong>
                                            <small>ریال</small>
                                        </div>
                                    </div>

                                    <div class="cc-contract-stat cc-stat-paid">
                                        <div class="cc-contract-stat-icon">
                                            <i class="bx bx-badge-check"></i>
                                        </div>
                                        <div class="cc-contract-stat-content">
                                            <span>مجموع واریزی تأییدشده</span>
                                            <strong>{$numberNormalizer->floatNumberFormat($getData->proformaInvoice->paymentAllocation->where('status',1)->sum('payment_amount'))}</strong>
                                            <small>ریال</small>
                                        </div>
                                    </div>

                                    <div class="cc-contract-stat cc-stat-pending">
                                        <div class="cc-contract-stat-icon">
                                            <i class="bx bx-time-five"></i>
                                        </div>
                                        <div class="cc-contract-stat-content">
                                            <span>واریزی در انتظار تأیید</span>
                                            <strong>{$numberNormalizer->floatNumberFormat($getData->proformaInvoice->paymentAllocation->where('status',0)->sum('payment_amount'))}</strong>
                                            <small>ریال</small>
                                        </div>
                                    </div>

                                    <div class="cc-contract-stat cc-stat-balance">
                                        <div class="cc-contract-stat-icon">
                                            <i class="bx bx-chart"></i>
                                        </div>
                                        <div class="cc-contract-stat-content">
                                            <span>مانده قابل پرداخت</span>
                                            <strong>{$numberNormalizer->floatNumberFormat($getData.proformaInvoice.invoiceDetail.invoice_sum_total - $getData->proformaInvoice->paymentAllocation->where('status',1)->sum('payment_amount'))}</strong>
                                            <small>ریال</small>
                                        </div>
                                    </div>

                                </div>

                                <!-- Contract Tabs -->

                                <div class="cc-contract-tabs-card">

                                    <!-- Tab Navigation -->
                                    <div class="cc-contract-tabs" role="tablist">

                                        <button type="button" class="cc-contract-tab active"
                                                data-tab="overview" role="tab" aria-selected="true">
                                            <i class="bx bx-layout"></i>
                                            نمای کلی
                                        </button>

                                    </div>

                                    <!-- Tab Contents -->
                                    <div class="cc-contract-tab-content">

                                        <!-- 1. Overview -->
                                        <div class="cc-contract-tab-pane active" id="cc-tab-overview" role="tabpanel">

                                            <div class="cc-contract-section-heading">
                                                <div>
                                                    <h5><i class="bx bx-info-circle"></i> اطلاعات کلی قرارداد</h5>
                                                    <p>خلاصه اطلاعات و مشخصات قرارداد</p>
                                                </div>
                                            </div>

                                            <div class="cc-contract-info-grid">

                                                <div class="cc-contract-info-card">
                                                    <div class="cc-contract-info-heading">
                                                        <i class="bx bx-user"></i>
                                                        <h5>اطلاعات مشتری و قرارداد</h5>
                                                    </div>

                                                    <div class="cc-contract-info-list">
                                                        <div>
                                                            <span>نام مشتری</span><strong>{$getData.proformaInvoice.contact.first_name} {$getData.proformaInvoice.contact.last_name}</strong>
                                                        </div>
                                                        <div>
                                                            <span>شرکت مشتری</span><strong>{$getData.proformaInvoice.company.company_name|default:' - '}</strong>
                                                        </div>
                                                        <div>
                                                            <span>شماره قرارداد</span><strong>{$getData.proformaInvoice.invoice_number}</strong>
                                                        </div>
                                                        <div>
                                                            <span>شماره پیش‌فاکتور</span><strong>{$getData.proformaInvoice.invoice_number}</strong>
                                                        </div>
                                                        <div>
                                                            <span>تاریخ قرارداد</span><strong>{jdate("Y/m/d",$getData.convert_to_contract)}</strong>
                                                        </div>
                                                        <div>
                                                            <span>تیم فروش</span><strong>{$getData.proformaInvoice.saleTeam.team_title}</strong>
                                                        </div>
                                                        <div>
                                                            <span>بازاریاب</span><strong>{$getData.proformaInvoice.marketer.marketer_full_name|default:' - '}</strong>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="cc-contract-info-card">
                                                    <div class="cc-contract-info-heading">
                                                        <i class="bx bx-paperclip"></i>
                                                        <h5>اسناد و مستندات</h5>
                                                    </div>

                                                    <div class="cc-contract-document">
                                                        <div class="cc-contract-document-icon">
                                                            <i class="bx bxs-file-pdf"></i>
                                                        </div>
                                                        <div class="cc-contract-document-info">
                                                            <strong>قرارداد اصلی.pdf</strong>
                                                            <span>سند قرارداد اولیه</span>
                                                        </div>
                                                        <button type="button" title="دانلود">
                                                            <i class="bx bx-download"></i>
                                                        </button>
                                                    </div>

                                                    <div class="cc-contract-document">
                                                        <div class="cc-contract-document-icon">
                                                            <i class="bx bxs-file-pdf"></i>
                                                        </div>
                                                        <div class="cc-contract-document-info">
                                                            <strong>الحاقیه شماره ۳.pdf</strong>
                                                            <span>آخرین سند الحاقیه</span>
                                                        </div>
                                                        <button type="button" title="دانلود">
                                                            <i class="bx bx-download"></i>
                                                        </button>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>


                                        <!-- 2. Addendums -->
                                        <div class="cc-contract-tab-pane" id="cc-tab-addendums" role="tabpanel">

                                            <div class="cc-contract-section-heading">
                                                <div>
                                                    <h5><i class="bx bx-history"></i> تاریخچه الحاقیه‌های قرارداد</h5>
                                                    <p>تمام تغییرات و اصلاحات ثبت‌شده روی قرارداد</p>
                                                </div>
                                                {if !$getData.cancelContract}
                                                <a target="_blank"
                                                   href="/ProformaInvoice/editIndex/{$getData.proforma_invoice_id}"
                                                   class="cc-contract-btn cc-contract-btn-primary text-white">
                                                    <i class="bx bx-file-plus"></i>
                                                    ثبت الحاقیه جدید
                                                </a>
                                                {/if}
                                            </div>

                                            <div class="cc-contract-timeline">

                                                {foreach $getData.addendum as $key=>$item}
                                                    <div class="cc-contract-timeline-item">
                                                        <div class="cc-contract-timeline-marker">
                                                            <i class="bx bxs-file-plus"></i>
                                                        </div>
                                                        <div class="cc-contract-addendum">
                                                            <div class="cc-contract-addendum-header">
                                                                <div class="cc-contract-addendum-title">
                                                                    <strong>الحاقیه
                                                                        شماره {$getData.proformaInvoice.invoice_number}
                                                                        /{$item.id}</strong>
                                                                </div>
                                                                <span class="cc-contract-addendum-status approved">
                                                                <i class="bx bx-check-circle"></i> تأیید شده
                                                            </span>
                                                            </div>

                                                            <div class="cc-contract-addendum-meta">
                                                                <span><i class="bx bx-calendar"></i>{jdate("Y/m/d",$item.addendum_date)}</span>
                                                                <span><i class="bx bx-user"></i>{$item.expert.full_name}</span>
                                                            </div>

                                                            <div class="cc-contract-addendum-footer">
                                                                <span><i class="bx bx-user-check"></i> تأییدکننده: مدیر فروش</span>
                                                                <button type="button" class="cc-contract-detail-btn">
                                                                    مشاهده جزئیات <i class="bx bx-left-arrow-alt"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach}

                                                <div class="cc-contract-timeline-item original">
                                                    <div class="cc-contract-timeline-marker">
                                                        <i class="bx bx-file"></i>
                                                    </div>

                                                    <div class="cc-contract-addendum">
                                                        <div class="cc-contract-addendum-header">
                                                            <div class="cc-contract-addendum-title">
                                                                <strong>قرارداد اولیه</strong>
                                                            </div>
                                                            <span class="cc-contract-addendum-status original-status">نسخه اصلی</span>
                                                        </div>

                                                        <div class="cc-contract-addendum-meta">
                                                            <span><i class="bx bx-calendar"></i>{jdate("Y/m/d",$getData.convert_to_contract)}</span>
                                                            <span><i class="bx bx-user"></i> ثبت اولیه قرارداد توسط {$getData.expert.full_name}</span>
                                                        </div>

                                                        <p class="cc-contract-addendum-description">
                                                            تبدیل پیش‌فاکتور {$getData.proformaInvoice.invoice_number}به
                                                            قرارداد و ثبت اطلاعات اولیه.
                                                        </p>

                                                        <div class="cc-contract-addendum-footer">
                                                            <span><i class="bx bx-file-blank"></i> سند قرارداد اصلی</span>
                                                            <button type="button" class="cc-contract-detail-btn">
                                                                مشاهده قرارداد <i class="bx bx-left-arrow-alt"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="cc-contract-tab-pane mt-5" id="cc-tab-products" role="tabpanel">
                                            <div class="cc-contract-section-heading">
                                                <div>
                                                    <h5><i class="bx bx-package"></i> محصولات و خدمات قرارداد</h5>
                                                    <p>فهرست اقلام ثبت‌شده در آخرین نسخه قرارداد</p>
                                                </div>
                                            </div>
                                            <div class="cc-contract-table-wrapper">
                                                <table class="cc-contract-table text-center">
                                                    <thead>
                                                    <tr>
                                                        <th class="border">ردیف</th>
                                                        <th class="border">محصول</th>
                                                        <th class="border">مقدار</th>
                                                        <th class="border">واحد</th>
                                                        <th class="border">قیمت واحد (ریال)</th>
                                                        <th class="border">تخفیف</th>
                                                        <th class="border">مجموع</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                        {foreach $getData.proformaInvoice.invoiceProduct as  $key=>$item}
                                                            <tr>
                                                                <td class="border">{$key+1}</td>
                                                                <td class="border">{$item.product.label} - {$item.product.serial_number}</td>
                                                                <td class="border">{$numberNormalizer->floatNumberFormat($item.amount)}</td>
                                                                <td class="border">{$item.product.measurementUnit.label}</td>
                                                                <td class="border">{$numberNormalizer->floatNumberFormat($item.unit_price)}</td>
                                                                <td class="border">{$numberNormalizer->floatNumberFormat($item.discount_amount)}</td>
                                                                <td class="border">{$numberNormalizer->floatNumberFormat($item.sum_unit_price)}</td>
                                                            </tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Payments -->
{*                                <div class="cc-contract-info-card cc-contract-payments-card">*}
{*                                    <div class="cc-contract-info-heading">*}
{*                                        <i class="bx bx-wallet"></i>*}
{*                                        <h5>آخرین پرداخت‌های قرارداد</h5>*}
{*                                        <button type="button" class="cc-contract-detail-btn">*}
{*                                            مشاهده همه پرداخت‌ها*}
{*                                            <i class="bx bx-left-arrow-alt"></i>*}
{*                                        </button>*}
{*                                    </div>*}

{*                                    <div class="cc-contract-table-wrapper">*}
{*                                        <table class="cc-contract-table">*}
{*                                            <thead>*}
{*                                            <tr>*}
{*                                                <th>ردیف</th>*}
{*                                                <th>تاریخ پرداخت</th>*}
{*                                                <th>مبلغ</th>*}
{*                                                <th>شماره پیگیری</th>*}
{*                                                <th>وضعیت</th>*}
{*                                                <th>عملیات</th>*}
{*                                            </tr>*}
{*                                            </thead>*}
{*                                            <tbody>*}
{*                                            <tr>*}
{*                                                <td>۱</td>*}
{*                                                <td>۱۴۰۵/۰۹/۲۰</td>*}
{*                                                <td>۲,۰۰۰,۰۰۰,۰۰۰ ریال</td>*}
{*                                                <td>۱۲۵۸۹۶۳۲</td>*}
{*                                                <td><span class="cc-contract-payment-status approved">تأیید شده</span>*}
{*                                                </td>*}
{*                                                <td>*}
{*                                                    <button type="button" class="cc-contract-table-action">مشاهده*}
{*                                                    </button>*}
{*                                                </td>*}
{*                                            </tr>*}
{*                                            <tr>*}
{*                                                <td>۲</td>*}
{*                                                <td>۱۴۰۵/۰۹/۱۵</td>*}
{*                                                <td>۱,۰۰۰,۰۰۰,۰۰۰ ریال</td>*}
{*                                                <td>۱۲۵۸۹۶۴۵</td>*}
{*                                                <td>*}
{*                                                    <span class="cc-contract-payment-status pending">در انتظار تأیید</span>*}
{*                                                </td>*}
{*                                                <td>*}
{*                                                    <button type="button" class="cc-contract-table-action">مشاهده*}
{*                                                    </button>*}
{*                                                </td>*}
{*                                            </tr>*}
{*                                            <tr>*}
{*                                                <td>۳</td>*}
{*                                                <td>۱۴۰۵/۰۹/۰۱</td>*}
{*                                                <td>۳,۰۰۰,۰۰۰,۰۰۰ ریال</td>*}
{*                                                <td>۱۲۵۸۹۶۷۸</td>*}
{*                                                <td><span class="cc-contract-payment-status approved">تأیید شده</span>*}
{*                                                </td>*}
{*                                                <td>*}
{*                                                    <button type="button" class="cc-contract-table-action">مشاهده*}
{*                                                    </button>*}
{*                                                </td>*}
{*                                            </tr>*}
{*                                            </tbody>*}
{*                                        </table>*}
{*                                    </div>*}
{*                                </div>*}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}