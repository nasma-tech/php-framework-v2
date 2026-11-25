<style>

    /* ============================================
       PROFORMA HISTORY - PREMIUM ERP UI
    ============================================ */

    .proforma-history-dashboard {
        direction: rtl;
    }

    /* Main Cards */
    .proforma-history-dashboard .card {
        background: #fff;
        border: 1px solid #e9edf4;
        border-radius: 13px;
        box-shadow: 0 3px 14px rgba(30, 45, 75, .045) !important;
        overflow: hidden;
        transition: all .25s ease;
    }

    .proforma-history-dashboard .card:hover {
        border-color: #dce4f1;
        box-shadow: 0 8px 24px rgba(30, 45, 75, .08) !important;
    }

    /* ============================================
       STATISTIC CARDS
    ============================================ */

    .proforma-history-dashboard .stat-card {
        position: relative;
        min-height: 148px;
        margin-top: 5px;
        border-radius: 13px;
    }

    .proforma-history-dashboard .stat-card .card-body {
        padding: 17px 12px;
        position: relative;
    }

    .proforma-history-dashboard .stat-icon {
        width: 45px;
        height: 45px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 12px;
        transition: all .25s ease;
    }

    .proforma-history-dashboard .stat-icon i {
        font-size: 23px;
    }

    .proforma-history-dashboard .stat-card:hover .stat-icon {
        transform: translateY(-3px) scale(1.05);
    }

    .proforma-history-dashboard .stat-title {
        font-size: 11.5px;
        font-weight: 600;
        color: #8994a7;
        margin-bottom: 9px;
    }

    .proforma-history-dashboard .stat-value {
        font-size: 18px;
        font-weight: 800;
        color: #293b59;
        margin: 0;
        line-height: 1.5;
        letter-spacing: -.4px;
    }

    .proforma-history-dashboard .stat-value span {
        font-size: 10px;
        font-weight: 600;
        color: #929db0;
        margin-right: 3px;
    }

    /* Success */
    .proforma-history-dashboard .stat-success {
        background: linear-gradient(145deg, #ffffff 65%, #f2fbf7 100%);
    }

    .proforma-history-dashboard .stat-success .stat-icon {
        background: #e5f7ef;
        color: #1fa477;
    }

    /* Primary */
    .proforma-history-dashboard .stat-primary {
        background: linear-gradient(145deg, #ffffff 65%, #f3f6ff 100%);
    }

    .proforma-history-dashboard .stat-primary .stat-icon {
        background: #e9efff;
        color: #5575dc;
    }

    /* Danger */
    .proforma-history-dashboard .stat-danger {
        background: linear-gradient(145deg, #ffffff 65%, #fff5f5 100%);
    }

    .proforma-history-dashboard .stat-danger .stat-icon {
        background: #ffeded;
        color: #e45e6b;
    }

    /* Warning */
    .proforma-history-dashboard .stat-warning {
        background: linear-gradient(145deg, #ffffff 65%, #fffaf0 100%);
    }

    .proforma-history-dashboard .stat-warning .stat-icon {
        background: #fff3db;
        color: #e4a238;
    }

    /* ============================================
       SECTION HEADERS
    ============================================ */

    .proforma-history-dashboard .section-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding-bottom: 15px;
        margin-bottom: 15px;
        border-bottom: 1px solid #f0f2f6;
    }

    .proforma-history-dashboard .section-title {
        display: flex;
        align-items: center;
        gap: 9px;
        font-size: 13px;
        font-weight: 800;
        color: #344563;
        margin: 0;
    }

    .proforma-history-dashboard .section-title i {
        width: 31px;
        height: 31px;
        border-radius: 9px;
        background: #eef2ff;
        color: #627be1;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
    }

    .proforma-history-dashboard .section-count {
        font-size: 10px;
        font-weight: 700;
        color: #637ce0;
        background: #f0f3ff;
        padding: 6px 12px;
        border-radius: 20px;
    }

    /* ============================================
       CHART
    ============================================ */

    .proforma-history-dashboard .chart-card {
        margin-top: 5px;
    }

    .proforma-history-dashboard .chart-card .card-body {
        padding: 19px;
        min-height: 300px;
    }

    .proforma-history-dashboard #proformaRevisionChart {
        min-height: 245px;
    }

    /* ============================================
       TIMELINE
    ============================================ */

    .proforma-history-dashboard .timeline-card {
        margin-top: 5px;
    }

    .proforma-history-dashboard .timeline-card .card-body {
        padding: 20px;
    }

    .proforma-history-dashboard .history-timeline {
        height: 665px;
        overflow-y: auto;
        padding: 5px 0 5px 8px;
        margin: 0;
        scrollbar-width: thin;
        scrollbar-color: #dce3ef transparent;
    }

    .proforma-history-dashboard .history-timeline::-webkit-scrollbar {
        width: 4px;
    }

    .proforma-history-dashboard .history-timeline::-webkit-scrollbar-thumb {
        background: #dce3ef;
        border-radius: 10px;
    }

    .proforma-history-dashboard .history-timeline li {
        position: relative;
        padding: 4px 0 23px;
        margin-bottom: 5px;
        border-bottom: 1px solid #f1f3f7;
    }

    .proforma-history-dashboard .history-timeline li:last-child {
        border-bottom: 0;
    }

    /* Timeline Date */
    .proforma-history-dashboard .history-timeline .timeline-time {
        display: inline-block;
        background: #f5f7fb;
        color: #8995a8;
        border-radius: 6px;
        padding: 5px 9px;
        font-size: 10px;
        font-weight: 600;
        margin-bottom: 11px;
    }

    /* Timeline Title */
    .proforma-history-dashboard .history-timeline .timeline-title {
        font-size: 12px;
        font-weight: 700;
        color: #344563;
        margin-bottom: 8px;
    }

    .proforma-history-dashboard .history-timeline .timeline-title code {
        display: inline-block;
        font-family: inherit;
        font-size: 11px;
        font-weight: 700;
        color: #5474d5;
        background: #edf2ff;
        border-radius: 6px;
        padding: 5px 9px;
        margin-right: 3px;
    }

    /* Relative Time */
    .proforma-history-dashboard .history-timeline .timeline-text {
        font-size: 10px;
        color: #9ba5b5;
        margin-bottom: 11px;
    }

    /* User Image */
    .proforma-history-dashboard .history-timeline .timeline-content {
        display: flex;
        align-items: center;
    }

    .proforma-history-dashboard .history-timeline .timeline-content img {
        width: 36px;
        height: 36px;
        object-fit: cover;
        border-radius: 11px;
        border: 2px solid #fff;
        box-shadow: 0 2px 8px rgba(40, 55, 90, .13);
    }

    /* Empty State */
    .proforma-history-dashboard .history-empty {
        text-align: center;
        padding: 70px 15px;
        color: #9aa5b5;
    }

    .proforma-history-dashboard .history-empty i {
        font-size: 45px;
        display: block;
        margin-bottom: 12px;
        color: #d2d9e5;
    }

    .proforma-history-dashboard .history-empty p {
        font-size: 12px;
    }

    /* ============================================
       RESPONSIVE
    ============================================ */

    @media (max-width: 767px) {

        .proforma-history-dashboard .stat-card {
            min-height: 140px;
        }

        .proforma-history-dashboard .stat-value {
            font-size: 16px;
        }

        .proforma-history-dashboard .timeline-card {
            margin-top: 15px;
        }

        .proforma-history-dashboard .history-timeline {
            height: 430px;
        }

        .proforma-history-dashboard .chart-card .card-body {
            padding: 13px;
        }

        .proforma-history-dashboard .section-title {
            font-size: 12px;
        }
    }

</style>
<div class="row proforma-history-dashboard">

    <!-- LEFT COLUMN -->
    <div class="col-md-6">

        <div class="row">

            <!-- FINAL AMOUNT -->
            <div class="col-md-6">
                <div class="card stat-card stat-success text-center">
                    <div class="card-content">
                        <div class="card-body">

                            <div class="stat-icon">
                                <i class="bx bx-wallet"></i>
                            </div>

                            <div class="stat-title">
                                مبلغ نهایی پیش‌فاکتور
                            </div>

                            <h3 class="stat-value primary-font">
                                {$numberNormalizer->floatNumberFormat($getData.invoiceDetail.invoice_sum_total)}
                                <span>ریال</span>
                            </h3>

                        </div>
                    </div>
                </div>
            </div>

            <!-- PRODUCT COUNT -->
            <div class="col-md-6 pl-md-0">
                <div class="card stat-card stat-primary text-center">
                    <div class="card-content">
                        <div class="card-body">

                            <div class="stat-icon">
                                <i class="bx bx-basket"></i>
                            </div>

                            <div class="stat-title">
                                تعداد ردیف محصولات
                            </div>

                            <h3 class="stat-value primary-font">
                                {$getData.invoice_product_count|default:0}
                            </h3>

                        </div>
                    </div>
                </div>
            </div>

            <!-- REMAINING DAYS -->
            <div class="col-md-6">
                {assign var="remainingDays" value=ceil(($getData.day_validity_timestamp - time()) / 86400)}

                <div class="card stat-card stat-danger text-center">
                    <div class="card-content">
                        <div class="card-body">

                            <div class="stat-icon">
                                <i class="bx bx-timer"></i>
                            </div>

                            <div class="stat-title">
                                مانده تا پایان اعتبار
                            </div>

                            <h3 class="stat-value primary-font">
                                {if $remainingDays > 0}
                                    {$remainingDays}
                                    <span>روز</span>
                                {elseif $remainingDays == 0}
                                    امروز
                                {else}
                                    منقضی شده
                                {/if}
                            </h3>

                        </div>
                    </div>
                </div>
            </div>

            <!-- EDIT COUNT -->
            <div class="col-md-6 pl-md-0">
                <div class="card stat-card stat-warning text-center">
                    <div class="card-content">
                        <div class="card-body">

                            <div class="stat-icon">
                                <i class="bx bx-edit-alt"></i>
                            </div>

                            <div class="stat-title">
                                تعداد ویرایش
                            </div>

                            <h3 class="stat-value primary-font">
                                {$getData.invoice_log_count|default:0}
                            </h3>

                        </div>
                    </div>
                </div>
            </div>

            <!-- REVISION CHART -->
            <div class="col-md-12">

                <div class="card chart-card">

                    <div class="card-content">

                        <div class="card-body">

                            <div class="section-header">
                                <h5 class="section-title">
                                    <i class="bx bx-line-chart"></i>
                                    روند تغییرات مبلغ پیش‌فاکتور
                                </h5>
                            </div>

                            {foreach $invoiceLog|default:[] as $item}
                                {assign var="decodeProformaInvoiceDetails" value=json_decode($item.ProformaInvoiceDetails,true)}

                                <input readonly
                                       type="hidden"
                                       class="editTotalPriceChart"
                                       data-date="{jdate("Y/m/d",strtotime($item['created_at']))}"
                                       value="{$decodeProformaInvoiceDetails[0]['invoice_sum_total']|default:0}">
                            {/foreach}

                            <div id="proformaRevisionChart"></div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <!-- RIGHT COLUMN -->
    <div class="col-md-6 pl-md-0">

        <div class="card timeline-card">

            <div class="card-content">

                <div class="card-body">

                    <div class="section-header">

                        <h5 class="section-title">
                            <i class="bx bx-history"></i>
                            تاریخچه ویرایش پیش‌فاکتور
                        </h5>

                        <span class="section-count">
                            {$getData.invoice_log_count|default:0} ویرایش
                        </span>

                    </div>

                    <ul class="widget-timeline history-timeline mb-0">

                        {if $invoiceLog|@count > 0}

                            {foreach $invoiceLog as $item}

                                {assign var="diffTime" value=$smarty.now - strtotime($item.created_at)}
                                {assign var="diffMinutes" value=floor($diffTime / 60)}
                                {assign var="diffHours" value=floor($diffTime / 3600)}
                                {assign var="diffDays" value=floor($diffTime / 86400)}

                                <li class="timeline-items timeline-icon-primary active">

                                    <div class="timeline-time">
                                        {jdate("H:i Y/m/d", strtotime($item.created_at))}
                                    </div>

                                    <h6 class="timeline-title">
                                        ویرایش توسط
                                        <code>
                                            {$userHelper->getUserFullName($item.user_id)}
                                        </code>
                                    </h6>

                                    <p class="timeline-text">

                                        {if $diffMinutes < 1}
                                            همین الان

                                        {elseif $diffMinutes < 60}
                                            {$diffMinutes} دقیقه پیش

                                        {elseif $diffHours < 24}
                                            {$diffHours} ساعت پیش

                                        {else}
                                            {$diffDays} روز پیش

                                        {/if}

                                    </p>

                                    <div class="timeline-content">

                                        <img src="{$userHelper->getUserImage($item.user_id)}"
                                             alt="user"
                                             width="34"
                                             height="34">

                                    </div>

                                </li>

                            {/foreach}

                        {else}

                            <div class="history-empty">
                                <i class="bx bx-history"></i>
                                <p>هنوز هیچ ویرایشی برای این پیش‌فاکتور ثبت نشده است.</p>
                            </div>

                        {/if}

                    </ul>

                </div>

            </div>

        </div>

    </div>

</div>

