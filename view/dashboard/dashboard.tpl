
{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<style>
    /* Dashboard */
    .cc-dashboard {
        direction: rtl;
    }

    .cc-dashboard .card {
        border: 1px solid #e9edf3;
        border-radius: 12px;
        overflow: hidden;
    }

    /* Profile */
    .cc-dashboard-profile {
        position: relative;
        text-align: center;
    }

    .cc-dashboard-profile-header {
        height: 115px;
        background: linear-gradient(120deg, #172b4d, #263f68);
        position: relative;
    }

    .cc-dashboard-profile-header:after {
        content: '';
        position: absolute;
        width: 100%;
        height: 4px;
        bottom: 0;
        right: 0;
        background: linear-gradient(90deg, #e53935, #ff7676);
    }

    .cc-dashboard-avatar {
        width: 104px;
        height: 104px;
        padding: 5px;
        background: #fff;
        border-radius: 50%;
        margin: -52px auto 12px;
        position: relative;
        box-shadow: 0 4px 15px rgba(0, 0, 0, .12);
    }

    .cc-dashboard-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }

    .cc-dashboard-profile-body {
        padding: 0 18px 20px;
    }

    .cc-dashboard-profile-name {
        font-size: 17px;
        font-weight: 700;
        color: #253858;
        margin-bottom: 6px;
    }

    .cc-dashboard-profile-role {
        display: inline-block;
        color: #64748b;
        background: #f1f5f9;
        border-radius: 20px;
        padding: 5px 13px;
        font-size: 11px;
        margin-bottom: 20px;
    }

    .cc-dashboard-profile-stats {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        border-top: 1px solid #edf0f4;
        padding-top: 17px;
    }

    .cc-dashboard-profile-stat {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
        color: #64748b;
        font-size: 11px;
    }

    .cc-dashboard-profile-stat:not(:last-child) {
        border-left: 1px solid #edf0f4;
    }

    .cc-dashboard-profile-stat i {
        font-size: 21px;
        color: #38577f;
    }

    .cc-dashboard-profile-stat strong {
        font-size: 15px;
        color: #253858;
    }

    /* Cartable */
    .cc-dashboard-cartable {
        min-height: 430px;
    }

    .cc-dashboard-cartable-header {
        padding: 19px 20px 0;
        border-bottom: 1px solid #edf0f4;
    }

    .cc-dashboard-section-title {
        display: flex;
        align-items: center;
        gap: 9px;
        color: #253858;
        font-size: 15px;
        font-weight: 700;
        margin-bottom: 17px;
    }

    .cc-dashboard-section-title i {
        font-size: 21px;
        color: #38577f;
    }

    .cc-dashboard-tabs {
        display: flex;
        flex-wrap: wrap;
        gap: 5px;
        border-bottom: 0;
    }

    .cc-dashboard-tabs .nav-item {
        margin-bottom: 0;
    }

    .cc-dashboard-tabs .nav-link {
        display: flex;
        align-items: center;
        gap: 7px;
        padding: 12px 14px;
        border: 0;
        border-radius: 8px 8px 0 0;
        color: #64748b;
        font-size: 12px;
        font-weight: 600;
        transition: all .2s ease;
        position: relative;
    }

    .cc-dashboard-tabs .nav-link i {
        font-size: 17px;
    }

    .cc-dashboard-tabs .nav-link:hover {
        color: #253858;
        background: #f5f7fa;
    }

    .cc-dashboard-tabs .nav-link.active {
        color: #24466f;
        background: #f0f5fb;
    }

    .cc-dashboard-tabs .nav-link.active:after {
        content: '';
        position: absolute;
        bottom: 0;
        right: 0;
        width: 100%;
        height: 3px;
        background: #315b8b;
        border-radius: 3px 3px 0 0;
    }

    .cc-dashboard-tab-count {
        min-width: 19px;
        height: 19px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 20px;
        padding: 0 5px;
        background: #e9eef5;
        color: #52657e;
        font-size: 10px;
        font-weight: 700;
    }

    .cc-dashboard-tabs .nav-link.active .cc-dashboard-tab-count {
        background: #315b8b;
        color: #fff;
    }

    .cc-dashboard-table-wrapper {
        padding: 18px 20px 20px;
    }

    .cc-dashboard-table {
        margin-bottom: 0;
        border-collapse: separate;
        border-spacing: 0;
        font-size: 12px;
    }

    .cc-dashboard-table thead th {
        background: #f4f6f9;
        color: #52657e;
        font-weight: 700;
        font-size: 11px;
        padding: 13px 10px;
        border-top: 1px solid #e9edf3;
        border-bottom: 1px solid #e9edf3;
        white-space: nowrap;
    }

    .cc-dashboard-table thead th:first-child {
        border-radius: 0 8px 0 0;
    }

    .cc-dashboard-table thead th:last-child {
        border-radius: 8px 0 0 0;
    }

    .cc-dashboard-table tbody td {
        padding: 12px 10px;
        vertical-align: middle;
        color: #475569;
        border-bottom: 1px solid #edf0f4;
        border-top: 0;
        white-space: nowrap;
    }

    .cc-dashboard-table tbody tr {
        transition: background .2s ease;
    }

    .cc-dashboard-table tbody tr:hover {
        background: #f8fafc;
    }

    .cc-dashboard-view-btn {
        width: 32px;
        height: 32px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px !important;
        padding: 0;
        box-shadow: none !important;
    }

    .cc-dashboard-view-btn i {
        font-size: 17px;
    }

    .cc-dashboard-empty {
        padding: 45px 15px !important;
        text-align: center;
        color: #94a3b8 !important;
        white-space: normal !important;
    }

    .cc-dashboard-empty i {
        display: block;
        font-size: 35px;
        margin-bottom: 10px;
        color: #cbd5e1;
    }

    .cc-dashboard-empty span {
        font-size: 12px;
    }

    @media (max-width: 767px) {
        .cc-dashboard-profile {
            margin-bottom: 15px;
        }

        .cc-dashboard-cartable-header {
            padding: 15px 12px 0;
        }

        .cc-dashboard-tabs {
            flex-wrap: nowrap;
            overflow-x: auto;
            white-space: nowrap;
        }

        .cc-dashboard-tabs .nav-link {
            padding: 11px 10px;
        }

        .cc-dashboard-table-wrapper {
            padding: 12px;
        }

        .cc-dashboard-table {
            min-width: 750px;
        }
    }





    /* ==========================================
       Dashboard - Sales Statistics
    ========================================== */

    .cc-dashboard-sales {
        margin-top: 22px;
    }

    /* Section Heading */
    .cc-dashboard-stats-heading {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 12px 0 17px;
        position: relative;
    }

    .cc-dashboard-stats-heading-icon {
        width: 44px;
        height: 44px;
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 13px;
        font-size: 23px;
        position: relative;
    }

    .cc-dashboard-stats-heading-icon.today {
        color: #2563eb;
        background: linear-gradient(135deg, #eaf2ff, #dbeafe);
        box-shadow: 0 4px 12px rgba(37, 99, 235, .09);
    }

    .cc-dashboard-stats-heading-icon.month {
        color: #7c3aed;
        background: linear-gradient(135deg, #f3eaff, #e9ddff);
        box-shadow: 0 4px 12px rgba(124, 58, 237, .09);
    }

    .cc-dashboard-stats-heading h5 {
        margin: 0 0 5px;
        font-size: 15px;
        font-weight: 800;
        color: #263b59;
    }

    .cc-dashboard-stats-heading p {
        margin: 0;
        color: #8b9bb0;
        font-size: 11px;
    }

    /* Statistics Grid */
    .cc-dashboard-stats-grid {
        display: grid;
        grid-template-columns: repeat(5, minmax(0, 1fr));
        gap: 14px;
    }

    /* Statistic Card */
    .cc-dashboard-stat-card {
        --stat-color: #3b82f6;
        --stat-bg: #eff6ff;
        --stat-border: #dbeafe;
        --stat-text: #2563eb;

        position: relative;
        min-width: 0;
        padding: 17px 16px 14px;
        background: #fff;
        border: 1px solid #edf0f5;
        border-radius: 14px;
        box-shadow: 0 3px 13px rgba(37, 54, 79, .045);
        overflow: hidden;
        transition: transform .25s ease,
        box-shadow .25s ease,
        border-color .25s ease;
    }

    /* Top accent */
    .cc-dashboard-stat-card:before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(
                90deg,
                transparent 0%,
                var(--stat-color) 100%
        );
        opacity: .85;
    }

    /* Decorative background */
    .cc-dashboard-stat-card:after {
        content: '';
        position: absolute;
        left: -28px;
        bottom: -43px;
        width: 105px;
        height: 105px;
        border-radius: 50%;
        background: var(--stat-bg);
        opacity: .55;
        pointer-events: none;
        transition: transform .3s ease;
    }

    .cc-dashboard-stat-card:hover {
        transform: translateY(-5px);
        border-color: var(--stat-border);
        box-shadow: 0 10px 25px rgba(37, 54, 79, .09);
    }

    .cc-dashboard-stat-card:hover:after {
        transform: scale(1.3);
    }

    /* Colors */
    .cc-dashboard-stat-card.blue {
        --stat-color: #3b82f6;
        --stat-bg: #eff6ff;
        --stat-border: #bfdbfe;
        --stat-text: #2563eb;
    }

    .cc-dashboard-stat-card.purple {
        --stat-color: #8b5cf6;
        --stat-bg: #f5f0ff;
        --stat-border: #ddd0ff;
        --stat-text: #7c3aed;
    }

    .cc-dashboard-stat-card.green {
        --stat-color: #16a34a;
        --stat-bg: #ecfdf3;
        --stat-border: #bbf7d0;
        --stat-text: #15803d;
    }

    .cc-dashboard-stat-card.orange {
        --stat-color: #f59e0b;
        --stat-bg: #fff7e8;
        --stat-border: #fde2a7;
        --stat-text: #d97706;
    }

    .cc-dashboard-stat-card.teal {
        --stat-color: #0d9488;
        --stat-bg: #e9fbf8;
        --stat-border: #a7f3e8;
        --stat-text: #0f766e;
    }

    /* Card Top */
    .cc-dashboard-stat-top {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 8px;
        position: relative;
        z-index: 1;
    }

    .cc-dashboard-stat-top > span {
        color: #64748b;
        font-size: 11px;
        font-weight: 700;
    }

    /* Icon */
    .cc-dashboard-stat-icon {
        width: 39px;
        height: 39px;
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
        background: var(--stat-bg);
        color: var(--stat-text);
        font-size: 21px;
        border: 1px solid rgba(0, 0, 0, .025);
        transition: transform .25s ease;
    }

    .cc-dashboard-stat-card:hover .cc-dashboard-stat-icon {
        transform: rotate(-7deg) scale(1.08);
    }

    /* Number */
    .cc-dashboard-stat-value {
        position: relative;
        z-index: 1;
        margin-top: 17px;
        color: #263b59;
        font-size: 27px;
        font-weight: 800;
        line-height: 1.3;
        direction: ltr;
        text-align: right;
        font-variant-numeric: tabular-nums;
        overflow-wrap: anywhere;
    }

    .cc-dashboard-stat-value.amount {
        font-size: 19px;
        letter-spacing: -.4px;
    }

    /* Footer */
    .cc-dashboard-stat-footer {
        position: relative;
        z-index: 1;
        display: flex;
        align-items: center;
        gap: 6px;
        margin-top: 13px;
        padding-top: 11px;
        border-top: 1px dashed #e9edf3;
        color: #94a3b8;
        font-size: 10px;
    }

    .cc-dashboard-stat-footer:before {
        content: '';
        width: 6px;
        height: 6px;
        flex-shrink: 0;
        border-radius: 50%;
        background: var(--stat-color);
    }

    /* Responsive */
    @media (max-width: 1199px) {
        .cc-dashboard-stats-grid {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }
    }

    @media (max-width: 767px) {
        .cc-dashboard-sales {
            margin-top: 15px;
        }

        .cc-dashboard-stats-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 10px;
        }

        .cc-dashboard-stat-card {
            padding: 14px 12px 12px;
        }

        .cc-dashboard-stat-top > span {
            font-size: 10px;
        }

        .cc-dashboard-stat-icon {
            width: 34px;
            height: 34px;
            font-size: 19px;
        }

        .cc-dashboard-stat-value {
            font-size: 23px;
            margin-top: 13px;
        }

        .cc-dashboard-stat-value.amount {
            font-size: 16px;
        }

        .cc-dashboard-stat-footer {
            font-size: 9px;
        }
    }

    @media (max-width: 380px) {
        .cc-dashboard-stats-grid {
            grid-template-columns: 1fr;
        }
    }

</style>

<div class="app-content content cc-dashboard">
    <div class="content-overlay"></div>

    <div class="content-wrapper">
        <div class="container-fluid">
            <div class="row">

                <!-- Profile -->
                <div class="col-lg-4 col-md-5 mb-2">
                    <div class="card shadow-sm h-100 cc-dashboard-profile">

                        <div class="cc-dashboard-profile-header"></div>

                        <div class="cc-dashboard-profile-body">
                            <div class="cc-dashboard-avatar">
                                <img src="{$userHelper->getUserImage()}"
                                     alt="تصویر کاربر">
                            </div>

                            <h4 class="cc-dashboard-profile-name">
                                {$user->full_name}
                            </h4>

                            <div class="cc-dashboard-profile-role">
                                <i class="bx bx-shield-quarter align-middle"></i>
                                {((isset($smarty.session.roleTitle)) ? $smarty.session.roleTitle : 'کاربر سیستم')}
                            </div>

                            <div class="cc-dashboard-profile-stats">

                                <div class="cc-dashboard-profile-stat">
                                    <i class="bx bx-camera"></i>
                                    <strong>0</strong>
                                    <span>تصاویر</span>
                                </div>

                                <div class="cc-dashboard-profile-stat">
                                    <i class="bx bx-heart"></i>
                                    <strong>0</strong>
                                    <span>علاقه‌مندی‌ها</span>
                                </div>

                                <div class="cc-dashboard-profile-stat">
                                    <i class="bx bx-user"></i>
                                    <strong>0</strong>
                                    <span>ارتباطات</span>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>

                <!-- Cartable -->
                <div class="col-lg-8 col-md-7 mb-2">
                    <div class="card shadow-sm h-100 cc-dashboard-cartable">

                        <div class="cc-dashboard-cartable-header">

                            <div class="cc-dashboard-section-title">
                                <i class="bx bx-layer"></i>
                                <span>کارتابل و درخواست‌های من</span>
                            </div>

                            <ul class="nav nav-tabs cc-dashboard-tabs" role="tablist">
                                {foreach $tabData as $tabItem}
                                    <li class="nav-item">
                                        <a class="nav-link {(($tabItem['isActive']) ? 'active' : '')}"
                                           id="{$tabItem['englishTitle']}-tab"
                                           data-toggle="tab"
                                           href="#{$tabItem['englishTitle']}"
                                           aria-controls="{$tabItem['englishTitle']}"
                                           role="tab"
                                           aria-selected="{(($tabItem['isActive']) ? 'true' : 'false')}">

                                            <i class="bx {$tabItem['tabIcon']}"></i>

                                            <span>{$tabItem['persianTitle']}</span>

                                            <span class="cc-dashboard-tab-count">
                                                {count($tabItem['data'])}
                                            </span>
                                        </a>
                                    </li>
                                {/foreach}
                            </ul>

                        </div>

                        <div class="card-body p-0">
                            <div class="tab-content">

                                {foreach $tabData as $tabItem}
                                    <div class="tab-pane fade {(($tabItem['isActive']) ? 'show active' : '')}"
                                         id="{$tabItem['englishTitle']}"
                                         aria-labelledby="{$tabItem['englishTitle']}-tab"
                                         role="tabpanel">

                                        <div class="cc-dashboard-table-wrapper">
                                            <div class="table-responsive">
                                                <table class="table cc-dashboard-table">

                                                    <thead>
                                                    <tr>
                                                        {foreach $tabItem['tabHeaders'] as $tabHeader}
                                                            <th class="text-center">
                                                                {$tabHeader}
                                                            </th>
                                                        {/foreach}
                                                    </tr>
                                                    </thead>

                                                    <tbody>
                                                    {foreach $tabItem['data'] as $cartableItem}
                                                        <tr class="text-center {$labelColorData[$cartableItem['statusData']['code']]}">

                                                            <td>
                                                                {$cartableItem['cartableData']['persianTitle']}
                                                            </td>

                                                            <td>
                                                                {$cartableItem['statusData']['title']}
                                                            </td>

                                                            <td>
                                                                {$cartableItem['requesterData']['userFullName']}
                                                            </td>

                                                            <td>
                                                                {$cartableItem['senderData']['userFullName']}
                                                            </td>

                                                            <td>
                                                                {$cartableItem['dateSend']}
                                                            </td>

                                                            <td>
                                                                {$cartableItem['timeSend']}
                                                            </td>

                                                            <td>
                                                                <a class="btn btn-primary cc-dashboard-view-btn"
                                                                   href="{$cartableItem['viewAddress']}"
                                                                   title="مشاهده درخواست">
                                                                    <i class="bx bx-show"></i>
                                                                </a>
                                                            </td>

                                                        </tr>
                                                        {foreachelse}
                                                        <tr>
                                                            <td colspan="{count($tabItem['tabHeaders'])}"
                                                                class="cc-dashboard-empty">
                                                                <i class="bx bx-inbox"></i>
                                                                <span>درخواستی برای نمایش وجود ندارد.</span>
                                                            </td>
                                                        </tr>
                                                    {/foreach}
                                                    </tbody>

                                                </table>
                                            </div>
                                        </div>

                                    </div>
                                {/foreach}

                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>

        <!-- Sales Statistics -->
        <div class="row cc-dashboard-sales">

            <!-- Today -->
            <div class="col-12">
                <div class="cc-dashboard-stats-heading">
                    <div class="cc-dashboard-stats-heading-icon today">
                        <i class="bx bx-calendar-check"></i>
                    </div>
                    <div>
                        <h5>عملکرد امروز</h5>
                        <p>خلاصه فعالیت‌های فروش در امروز</p>
                    </div>
                </div>
            </div>

            <div class="col-12">
                <div class="cc-dashboard-stats-grid">

                    <div class="cc-dashboard-stat-card blue">
                        <div class="cc-dashboard-stat-top">
                            <span>پیشنهاد قیمت</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-file"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value">
                            {$dashboardStats['today']['proposalCount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>تعداد ثبت‌شده امروز</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card purple">
                        <div class="cc-dashboard-stat-top">
                            <span>پیش‌فاکتور</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-receipt"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value">
                            {$dashboardStats['today']['proformaCount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>تعداد ثبت‌شده امروز</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card green">
                        <div class="cc-dashboard-stat-top">
                            <span>قرارداد</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-file-blank"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value">
                            {$dashboardStats['today']['contractCount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>تعداد ثبت‌شده امروز</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card orange">
                        <div class="cc-dashboard-stat-top">
                            <span>مبلغ پیش‌فاکتورها</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-wallet"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value amount">
                            {$dashboardStats['today']['proformaAmount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>مجموع مبلغ امروز</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card teal">
                        <div class="cc-dashboard-stat-top">
                            <span>مبلغ قراردادها</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-money"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value amount">
                            {$dashboardStats['today']['contractAmount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>مجموع مبلغ امروز</span>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Monthly -->
            <div class="col-12 mt-3">
                <div class="cc-dashboard-stats-heading">
                    <div class="cc-dashboard-stats-heading-icon month">
                        <i class="bx bx-calendar"></i>
                    </div>
                    <div>
                        <h5>عملکرد ماه جاری</h5>
                        <p>خلاصه فعالیت‌های فروش در ماه جاری</p>
                    </div>
                </div>
            </div>

            <div class="col-12">
                <div class="cc-dashboard-stats-grid">

                    <div class="cc-dashboard-stat-card blue">
                        <div class="cc-dashboard-stat-top">
                            <span>پیشنهاد قیمت</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-file"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value">
                            {$dashboardStats['month']['proposalCount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>تعداد ثبت‌شده ماه جاری</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card purple">
                        <div class="cc-dashboard-stat-top">
                            <span>پیش‌فاکتور</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-receipt"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value">
                            {$dashboardStats['month']['proformaCount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>تعداد ثبت‌شده ماه جاری</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card green">
                        <div class="cc-dashboard-stat-top">
                            <span>قرارداد</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-file-blank"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value">
                            {$dashboardStats['month']['contractCount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>تعداد ثبت‌شده ماه جاری</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card orange">
                        <div class="cc-dashboard-stat-top">
                            <span>مبلغ پیش‌فاکتورها</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-wallet"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value amount">
                            {$dashboardStats['month']['proformaAmount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>مجموع مبلغ ماه جاری</span>
                        </div>
                    </div>

                    <div class="cc-dashboard-stat-card teal">
                        <div class="cc-dashboard-stat-top">
                            <span>مبلغ قراردادها</span>
                            <div class="cc-dashboard-stat-icon">
                                <i class="bx bx-money"></i>
                            </div>
                        </div>
                        <div class="cc-dashboard-stat-value amount">
                            {$dashboardStats['month']['contractAmount']}
                        </div>
                        <div class="cc-dashboard-stat-footer">
                            <span>مجموع مبلغ ماه جاری</span>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </div>
</div>

{include 'sections/footer.tpl'}
