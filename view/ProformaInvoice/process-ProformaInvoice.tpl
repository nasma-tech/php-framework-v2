{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

{*<style>*}

{*    /* =========================================*}
{*       CANCELLED CONTRACT NOTICE*}
{*    ========================================= */*}

{*    .cc-contract-cancelled {*}
{*        position: relative;*}
{*        display: flex;*}
{*        align-items: center;*}
{*        gap: 16px;*}
{*        width: 100%;*}
{*        padding: 17px 20px;*}
{*        margin-bottom: 18px;*}
{*        overflow: hidden;*}
{*        background: linear-gradient(110deg, #fffafa 0%, #fff3f2 100%);*}
{*        border: 1px solid #f3d6d4;*}
{*        border-right: 4px solid #d9534f;*}
{*        border-radius: 10px;*}
{*        box-shadow: 0 3px 12px rgba(180, 55, 55, .045);*}
{*        direction: rtl;*}
{*        box-sizing: border-box;*}
{*    }*}

{*    .cc-contract-cancelled-icon {*}
{*        position: relative;*}
{*        display: flex;*}
{*        align-items: center;*}
{*        justify-content: center;*}
{*        width: 48px;*}
{*        height: 48px;*}
{*        flex-shrink: 0;*}
{*        color: #c64b47;*}
{*        background: #ffe8e6;*}
{*        border: 1px solid #f7d1ce;*}
{*        border-radius: 11px;*}
{*        font-size: 27px;*}
{*    }*}

{*    .cc-contract-cancelled-mark {*}
{*        position: absolute;*}
{*        left: -5px;*}
{*        top: -5px;*}
{*        display: flex;*}
{*        align-items: center;*}
{*        justify-content: center;*}
{*        width: 21px;*}
{*        height: 21px;*}
{*        color: #fff;*}
{*        background: #d9534f;*}
{*        border: 2px solid #fff;*}
{*        border-radius: 50%;*}
{*        font-size: 13px;*}
{*    }*}

{*    .cc-contract-cancelled-content {*}
{*        flex: 1;*}
{*        min-width: 0;*}
{*    }*}

{*    .cc-contract-cancelled-title {*}
{*        display: flex;*}
{*        align-items: center;*}
{*        flex-wrap: wrap;*}
{*        gap: 10px;*}
{*    }*}

{*    .cc-contract-cancelled-title strong {*}
{*        color: #923b38;*}
{*        font-size: 14px;*}
{*        font-weight: 700;*}
{*    }*}

{*    .cc-contract-cancelled-badge {*}
{*        display: inline-flex;*}
{*        align-items: center;*}
{*        gap: 5px;*}
{*        padding: 4px 9px;*}
{*        color: #c04440;*}
{*        background: #ffe7e5;*}
{*        border: 1px solid #f7d1ce;*}
{*        border-radius: 20px;*}
{*        font-size: 10px;*}
{*        font-weight: 600;*}
{*    }*}

{*    .cc-contract-cancelled-content p {*}
{*        margin: 8px 0 0;*}
{*        color: #8b6664;*}
{*        font-size: 12px;*}
{*        line-height: 1.9;*}
{*    }*}

{*    .cc-contract-cancelled-content p strong {*}
{*        color: #a9433f;*}
{*        font-weight: 700;*}
{*    }*}

{*    .cc-contract-cancelled-lock {*}
{*        display: flex;*}
{*        align-items: center;*}
{*        gap: 7px;*}
{*        flex-shrink: 0;*}
{*        padding: 9px 12px;*}
{*        color: #a64b47;*}
{*        background: rgba(217, 83, 79, .07);*}
{*        border: 1px solid rgba(217, 83, 79, .13);*}
{*        border-radius: 7px;*}
{*        font-size: 11px;*}
{*        font-weight: 600;*}
{*    }*}

{*    .cc-contract-cancelled-lock i {*}
{*        font-size: 17px;*}
{*    }*}

{*    /* Responsive */*}

{*    @media (max-width: 600px) {*}
{*        .cc-contract-cancelled {*}
{*            align-items: flex-start;*}
{*            flex-wrap: wrap;*}
{*            padding: 14px;*}
{*            gap: 12px;*}
{*        }*}

{*        .cc-contract-cancelled-icon {*}
{*            width: 42px;*}
{*            height: 42px;*}
{*            font-size: 23px;*}
{*        }*}

{*        .cc-contract-cancelled-content {*}
{*            flex-basis: calc(100% - 58px);*}
{*        }*}

{*        .cc-contract-cancelled-lock {*}
{*            margin-right: 54px;*}
{*        }*}
{*    }*}
{*</style>*}

<style>

    /* =========================================
       PREMIUM INFORMATION CARDS
    ========================================= */

    /* کارت اصلی */
    .proforma-detail .pd-info-card,
    .proforma-detail .pd-brand-card {
        position: relative;
        height: calc(100% - 12px);
        min-height: 178px;
        margin-top: 4px;
        margin-bottom: 12px;
        border: 1px solid #e8edf5;
        border-radius: 15px;
        background: #fff;
        overflow: hidden;
        box-shadow: 0 4px 16px rgba(35, 50, 80, .055) !important;
        transition: all .3s ease;
    }

    /* Hover */
    .proforma-detail .pd-info-card:hover,
    .proforma-detail .pd-brand-card:hover {
        transform: translateY(-4px);
        border-color: #d9e2f2;
        box-shadow: 0 12px 28px rgba(35, 50, 80, .10) !important;
    }

    /* نوار رنگی بالای کارت */
    .proforma-detail .pd-info-card::before,
    .proforma-detail .pd-brand-card::before {
        content: "";
        position: absolute;
        top: 0;
        right: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, #edf1fb, #637fe0);
    }

    /* بدنه کارت */
    .proforma-detail .pd-info-card .card-body {
        padding: 20px 15px 17px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        height: 100%;
        position: relative;
    }

    /* آیکون */
    .proforma-detail .pd-info-icon {
        width: 52px;
        height: 52px;
        min-width: 52px;
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 25px;
        margin-bottom: 13px;
        transition: all .3s ease;
    }

    .proforma-detail .pd-info-card:hover .pd-info-icon {
        transform: translateY(-4px) rotate(-5deg);
    }

    /* عنوان */
    .proforma-detail .pd-info-title {
        font-size: 12px;
        font-weight: 800;
        color: #344563;
        margin-bottom: 12px;
        letter-spacing: -.2px;
    }

    /* اطلاعات */
    .proforma-detail .pd-info-content {
        width: 100%;
        font-size: 11px;
        font-weight: 500;
        line-height: 2.3;
        color: #7b879c;
        overflow-wrap: anywhere;
    }

    .proforma-detail .pd-info-content strong {
        color: #344563;
        font-weight: 800;
    }

    .proforma-detail .pd-info-content a {
        display: inline-block;
        color: #526fd0;
        font-weight: 800;
        text-decoration: none;
        transition: color .2s ease;
    }

    .proforma-detail .pd-info-content a:hover {
        color: #304cae;
    }

    /* خط جداکننده اطلاعات */
    .proforma-detail .pd-info-content > div {
        padding-top: 5px;
        margin-top: 4px;
        border-top: 1px dashed #edf0f5;
    }

    /* =========================================
       EXPERT CARD
    ========================================= */

    .proforma-detail .pd-info-card:nth-child(1) .pd-info-icon {
        background: #edf2ff;
        color: #5472d5;
    }

    .proforma-detail .pd-info-card:nth-child(1)::before {
        background: linear-gradient(90deg, #e9efff, #5472d5);
    }

    /* =========================================
       CUSTOMER CARD
    ========================================= */

    .proforma-detail .pd-info-card:nth-child(1) .pd-info-icon {
        background: #eaf8f4;
        color: #20a17a;
    }

    /* =========================================
       BRAND CARD
    ========================================= */

    .proforma-detail .pd-brand-card {
        background: linear-gradient(145deg, #fff 50%, #f5f7fc);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .proforma-detail .pd-brand-card::before {
        background: linear-gradient(90deg, #e7ebf5, #8798bd);
    }

    .proforma-detail .pd-brand-card::after {
        content: "";
        position: absolute;
        width: 125px;
        height: 125px;
        border-radius: 50%;
        background: rgba(99, 127, 224, .035);
        left: -35px;
        bottom: -55px;
        pointer-events: none;
    }

    .proforma-detail .pd-brand-card img {
        position: relative;
        z-index: 1;
        max-width: 100%;
        max-height: 115px;
        width: auto;
        height: auto;
        object-fit: contain;
    }

    /* =========================================
       RESPONSIVE
    ========================================= */

    @media (max-width: 991px) {
        .proforma-detail .pd-info-card,
        .proforma-detail .pd-brand-card {
            min-height: 165px;
        }
    }

    @media (max-width: 767px) {
        .proforma-detail .pd-info-card,
        .proforma-detail .pd-brand-card {
            min-height: 155px;
            margin-bottom: 10px;
        }

        .proforma-detail .pd-info-card .card-body {
            padding: 16px 12px;
        }

        .proforma-detail .pd-info-icon {
            width: 45px;
            height: 45px;
            min-width: 45px;
            font-size: 22px;
            margin-bottom: 10px;
        }

        .proforma-detail .pd-info-title {
            font-size: 11px;
            margin-bottom: 8px;
        }

        .proforma-detail .pd-info-content {
            font-size: 10px;
        }
    }

    @media (max-width: 380px) {
        .proforma-detail .pd-info-card,
        .proforma-detail .pd-brand-card {
            min-height: 145px;
        }
    }


    /* =====================================
   Proforma Detail Header
===================================== */

    .pd-page-header {
        position: relative;
        direction: rtl;
        border: 1px solid #e8edf5;
        border-radius: 13px;
        background: #fff;
        box-shadow: 0 3px 15px rgba(30, 50, 80, 0.045);
        margin-bottom: 22px;
        overflow: visible;
    }

    .pd-header-content {
        min-height: 90px;
        padding: 17px 22px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 20px;
    }

    /* عنوان */

    .pd-header-title {
        display: flex;
        align-items: center;
        gap: 14px;
        min-width: 0;
    }

    .pd-header-icon {
        width: 52px;
        height: 52px;
        flex: 0 0 52px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 13px;
        background: linear-gradient(145deg, #263e68, #172c4d);
        color: #fff;
        box-shadow: 0 5px 12px rgba(31, 56, 94, 0.18);
    }

    .pd-header-icon i {
        font-size: 26px;
    }

    .pd-header-text {
        display: flex;
        flex-direction: column;
        gap: 6px;
        min-width: 0;
    }

    .pd-header-text h4 {
        margin: 0;
        color: #26364f;
        font-size: 16px;
        font-weight: 800;
        line-height: 1.6;
    }

    .pd-invoice-number {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        width: fit-content;
        direction: rtl;
        color: #78869b;
        font-size: 12px;
        font-weight: 600;
    }

    .pd-invoice-number i {
        font-size: 14px;
        color: #d04b50;
    }

    /* دکمه‌های سمت چپ */

    .pd-header-actions {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        gap: 9px;
        flex-wrap: wrap;
    }

    .pd-header-navigation {
        display: flex;
        align-items: center;
        gap: 7px;
    }

    /* دکمه گزینه‌های فرایند */

    .pd-process-dropdown {
        position: relative;
    }

    .pd-process-btn {
        min-height: 38px;
        padding: 8px 13px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        border: 1px solid #263e68;
        border-radius: 7px;
        background: #263e68;
        color: #fff;
        font-size: 12px;
        font-weight: 700;
        transition: all 0.2s ease;
    }

    .pd-process-btn:hover,
    .pd-process-btn:focus {
        background: #1c3154;
        border-color: #1c3154;
        color: #fff;
        box-shadow: 0 4px 10px rgba(38, 62, 104, 0.18);
    }

    .pd-process-btn > i:first-child {
        font-size: 17px;
    }

    .pd-dropdown-arrow {
        font-size: 15px;
        margin-right: 2px;
    }

    /* منوی کشویی */

    .pd-process-menu {
        min-width: 225px;
        padding: 7px;
        margin-top: 9px;
        border: 1px solid #e9edf4;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(25, 42, 70, 0.13);
        direction: rtl;
        text-align: right;
        z-index: 1050;
    }

    .pd-menu-header {
        padding: 9px 11px 11px;
        margin-bottom: 5px;
        border-bottom: 1px solid #edf0f5;
        color: #8a96a8;
        font-size: 11px;
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 7px;
    }

    .pd-menu-header i {
        font-size: 16px;
        color: #d04b50;
    }

    .pd-process-menu .dropdown-item {
        display: flex;
        align-items: center;
        gap: 10px;
        width: 100%;
        padding: 10px 11px;
        margin-bottom: 2px;
        border: 0;
        border-radius: 7px;
        background: transparent;
        color: #45546b;
        font-family: inherit;
        font-size: 12px;
        font-weight: 600;
        text-align: right;
        white-space: normal;
        transition: all 0.18s ease;
    }

    .pd-process-menu .dropdown-item i {
        width: 19px;
        flex: 0 0 19px;
        font-size: 17px;
        color: #8492a6;
        text-align: center;
    }

    .pd-process-menu .dropdown-item:hover {
        background: #f1f4f9;
        color: #263e68;
    }

    .pd-process-menu .dropdown-item:hover i {
        color: #d04b50;
    }

    /* =====================================
       Responsive
    ===================================== */

    @media (max-width: 768px) {

        .pd-header-content {
            align-items: flex-start;
            flex-direction: column;
            padding: 16px;
            gap: 16px;
        }

        .pd-header-title {
            width: 100%;
        }

        .pd-header-actions {
            width: 100%;
            justify-content: flex-start;
        }

        .pd-header-navigation {
            flex-wrap: wrap;
        }

        .pd-process-menu {
            right: 0;
            left: auto;
        }
    }

    @media (max-width: 480px) {

        .pd-header-icon {
            width: 44px;
            height: 44px;
            flex-basis: 44px;
        }

        .pd-header-icon i {
            font-size: 23px;
        }

        .pd-header-text h4 {
            font-size: 14px;
        }

        .pd-header-actions {
            align-items: stretch;
        }

        .pd-header-navigation {
            flex: 1;
        }

        .pd-process-btn {
            width: 100%;
        }

        .pd-process-dropdown {
            flex: 1;
        }

    }


    /* =====================================
   Proforma Navigation
===================================== */

    .pd-navigation {
        direction: rtl;
        position: relative;
        width: 100%;
        margin-bottom: 22px;
        padding: 7px;
        background: #fff;
        border: 1px solid #e8edf5;
        border-radius: 12px;
        box-shadow: 0 3px 15px rgba(30, 50, 80, 0.045);
    }

    .pd-nav-list {
        display: flex;
        align-items: stretch;
        justify-content: flex-start;
        gap: 5px;
        flex-wrap: wrap;
        margin: 0;
        padding: 0;
        list-style: none;
    }

    .pd-nav-list > .nav-item {
        flex: 1 1 auto;
        min-width: 100px;
    }

    /* تب‌ها */

    .pd-nav-link {
        position: relative;
        min-height: 45px;
        padding: 11px 13px !important;
        display: flex !important;
        align-items: center;
        justify-content: center;
        gap: 8px;
        border-radius: 8px !important;
        color: #718096 !important;
        background: transparent;
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
        transition: all 0.2s ease;
    }

    .pd-nav-link i {
        font-size: 18px;
        color: #94a1b4;
        transition: all 0.2s ease;
    }

    .pd-nav-link span {
        line-height: 1.5;
    }

    /* Hover */

    .pd-nav-link:hover {
        background: #f3f5f9 !important;
        color: #263e68 !important;
    }

    .pd-nav-link:hover i {
        color: #263e68;
    }

    /* تب فعال */

    .pd-nav-link.active {
        position: relative;
        background: #263e68 !important;
        color: #fff !important;
        box-shadow: 0 4px 10px rgba(38, 62, 104, 0.16);
    }

    .pd-nav-link.active i {
        color: #fff;
    }

    /* خط قرمز تب فعال */

    .pd-nav-link.active::after {
        content: "";
        position: absolute;
        right: 13px;
        left: 13px;
        bottom: 3px;
        height: 2px;
        border-radius: 5px;
        background: #e45b61;
    }

    /* =====================================
       More Dropdown
    ===================================== */

    .pd-nav-more {
        position: relative;
        flex: 0 0 auto !important;
        min-width: 105px !important;
    }

    .pd-nav-more-link {
        color: #52627a !important;
        background: #f5f7fa;
    }

    .pd-nav-more-link > i {
        font-size: 20px;
        color: #52627a;
    }

    .pd-nav-more-link::after {
        display: none !important;
    }

    .pd-nav-more-link:hover {
        background: #edf1f7 !important;
    }

    /* منوی بیشتر */

    .pd-nav-dropdown {
        min-width: 225px;
        max-height: 350px;
        overflow-y: auto;
        padding: 7px;
        margin-top: 8px;
        border: 1px solid #e8edf5;
        border-radius: 10px;
        background: #fff;
        box-shadow: 0 10px 30px rgba(25, 42, 70, 0.13);
        text-align: right;
        direction: rtl;
        z-index: 1050;
    }

    .pd-nav-dropdown-header {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 10px 11px;
        margin-bottom: 5px;
        border-bottom: 1px solid #edf0f5;
        color: #8a96a8;
        font-size: 11px;
        font-weight: 700;
    }

    .pd-nav-dropdown-header i {
        color: #d04b50;
        font-size: 17px;
    }

    .pd-nav-dropdown-item {
        display: flex !important;
        align-items: center;
        gap: 10px;
        padding: 10px 11px !important;
        margin-bottom: 2px;
        border-radius: 7px;
        color: #52627a !important;
        font-size: 12px;
        font-weight: 600;
        transition: all 0.2s ease;
    }

    .pd-nav-dropdown-item i {
        width: 19px;
        font-size: 17px;
        text-align: center;
        color: #8996a9;
    }

    .pd-nav-dropdown-item:hover {
        background: #f1f4f9 !important;
        color: #263e68 !important;
    }

    .pd-nav-dropdown-item:hover i {
        color: #d04b50;
    }

    .pd-nav-dropdown .dropdown-divider {
        margin: 5px 8px;
        border-color: #edf0f5;
    }

    /* =====================================
       Responsive
    ===================================== */

    @media (max-width: 992px) {

        .pd-nav-list {
            justify-content: flex-start;
        }

        .pd-nav-list > .nav-item {
            flex: 0 0 auto;
        }

        .pd-nav-link {
            padding: 10px 12px !important;
        }
    }

    @media (max-width: 576px) {

        .pd-navigation {
            padding: 6px;
        }

        .pd-nav-list {
            gap: 5px;
        }

        .pd-nav-list > .nav-item {
            flex: 1 1 calc(50% - 5px);
            min-width: 0;
        }

        .pd-nav-more {
            flex: 1 1 calc(50% - 5px) !important;
        }

        .pd-nav-link {
            min-height: 42px;
            padding: 9px 7px !important;
            font-size: 11px;
            gap: 6px;
        }

        .pd-nav-link i {
            font-size: 16px;
        }

        .pd-nav-dropdown {
            min-width: 200px;
        }
    }



</style>

<div class="app-content content proforma-detail">
    <div class="content-wrapper">

        {$flashMessageHelper->formCallBack()}

        <!-- PAGE HEADER -->
        <div class="card pd-page-header">
            <div class="pd-header-content">

                <!-- عنوان و شماره پیش‌فاکتور -->
                <div class="pd-header-title">

                    <div class="pd-header-icon">
                        <i class="bx bx-file"></i>
                    </div>

                    <div class="pd-header-text">
                        <h4>{$singleName}</h4>

                        <span class="pd-invoice-number">
                    <i class="bx bx-hash"></i>
                    {$getData->invoice_number}
                </span>
                    </div>

                </div>

                <!-- دکمه‌های عملیات -->
                <div class="pd-header-actions">
                    <div class="dropdown pd-process-dropdown">
                        <button class="btn btn-sm btn-primary dropdown-toggle"
                                type="button"
                                id="dropdownMenuButtonIcon"
                                data-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false">

                            <i class="bx bx-slider-alt"></i>
                            <span>گزینه‌های فرایند</span>
                            <i class="bx bx-chevron-down pd-dropdown-arrow"></i>

                        </button>

                        <div class="dropdown-menu dropdown-menu-right pd-process-menu"
                             aria-labelledby="dropdownMenuButtonIcon">

                            <div class="pd-menu-header">
                                <i class="bx bx-cog"></i>
                                عملیات قابل انجام
                            </div>

                            {foreach $optionsConfig as $optionConfig}
                                {if $optionConfig['show']|default:null}
                                    {if !isset($optionConfig['type']) || $optionConfig['type'] == 'a'}
                                        <a href="{$optionConfig['href']|default:'#'}"
                                           target="{$optionConfig['target']|default:"_self"}"
                                           data-toggle="tooltip"
                                           id="option_{$optionConfig['name']}"
                                           data-original-title="{$optionConfig['description']}"
                                           class="dropdown-item">
                                            <i class="bx {$optionConfig['icon']|default:"bx-dots-vertical-rounded"}"></i>
                                            <span>{$optionConfig['title']}</span>
                                        </a>
                                    {elseif $optionConfig['type'] == 'button'}
                                        <button type="button"
                                                id="option_{$optionConfig['name']}"
                                                data-toggle="tooltip"
                                                data-original-title="{$optionConfig['description']}"
                                                class="dropdown-item">
                                            <i class="bx {$optionConfig['icon']|default:"bx-dots-vertical-rounded"}"></i>
                                            <span>{$optionConfig['title']}</span>
                                        </button>
                                    {/if}
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                    <div class="pd-header-navigation">
                        {$buttonHelper->refreshAndBackButton(2)}
                    </div>
                </div>
            </div>
        </div>
        {if $getData.contract.cancelContract|default:''}
            <!-- CANCELLED CONTRACT -->
            <div class="card pd-card">
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

                                <span class="cc-contract-cancelled-badge">
                                    <i class="bx bx-x-circle"></i>
                                    لغو شده
                                </span>
                            </div>

                            <p>
                                این قرارداد به دلیل لغو شدن، از اعتبار خارج شده است و
                                <strong>
                                    امکان انجام هیچ‌گونه عملیات یا ویرایشی روی آن وجود ندارد.
                                </strong>
                            </p>

                        </div>

                        <div class="cc-contract-cancelled-lock">
                            <i class="bx bx-lock-alt"></i>
                            <span>دسترسی غیرفعال</span>
                        </div>

                    </div>

                </div>
            </div>

        {else}

            <div style="display:none">
                <input type="hidden" id="invoiceId" value="{$getData.id}">
            </div>

            <!-- INFORMATION CARDS -->
            <div class="row">

                <!-- BRAND -->
                <div class="col-12 col-md-3">
                    <div class="card pd-card pd-brand-card">

                        <img class="p-1"
                             src="{(($brand) ? "/Storage/brands/{$brand->logo_address}" : "/public/images/logo/logo-side-menu.png")}"
                             alt="logo">

                    </div>
                </div>

                <!-- EXPERT -->
                <div class="col-12 col-md-3 pl-md-0">

                    <div class="card pd-card pd-info-card">
                        <div class="card-body">

                            <div class="pd-info-icon">
                                <i class="bx bx-support"></i>
                            </div>

                            <h6 class="pd-info-title">
                                مشخصات کارشناس
                            </h6>

                            <div class="pd-info-content">

                                <strong>{$expert->full_name}</strong>

                                |

                                {$saleTeam->team_title|default:'<span class="danger">بدون تیم</span>'}

                                <div>
                                    بازاریاب: -
                                </div>

                            </div>

                        </div>
                    </div>

                </div>

                <!-- CUSTOMER -->
                <div class="col-12 col-md-3 pl-md-0">

                    <div class="card pd-card pd-info-card">
                        <div class="card-body">

                            <div class="pd-info-icon">
                                <i class="bx bx-user-voice"></i>
                            </div>

                            <h6 class="pd-info-title">
                                اطلاعات مشتری
                            </h6>

                            <div class="pd-info-content">

                                <a target="_blank"
                                   href="/CustomerContactInformation/contactDetail/{$contact->id}">

                                    {$contact->contact_code}
                                    |
                                    {$contact->contactFullName()}

                                </a>

                                <div>
                                    {$company->company_name|default:''}
                                </div>

                            </div>

                        </div>
                    </div>

                </div>

                <!-- INVOICE -->
                <div class="col-12 col-md-3 pl-md-0">

                    <div class="card pd-card pd-info-card">
                        <div class="card-body">

                            <div class="pd-info-icon">
                                <i class="bx bx-file"></i>
                            </div>

                            <h6 class="pd-info-title">
                                اطلاعات پیش‌فاکتور
                            </h6>

                            <div class="pd-info-content">

                                <div>
                                    تاریخ و ساعت صدور:
                                    <span dir="ltr">
                                        {jdate("Y/m/d H:i" , strtotime($getData->created_at))}
                                    </span>
                                </div>

                                <div>
                                    زمان تحویل:
                                    <strong>{$getData->delivery_date}</strong>
                                    روز کاری
                                </div>

                                <div>
                                    استان و شهر:
                                    {$state->title} - {$city->title}
                                </div>

                            </div>

                        </div>
                    </div>

                </div>

            </div>


            {* {if $getData->checkInvoiceValidity()} *}
            {if true}

                {$csrf->csrfTokenInput()}

                <!-- SECTION NAVIGATION -->
                <div class="pd-navigation">

                    <ul class="nav nav-pills nav-justified pd-nav-list">

                        {foreach $sectionsConfig['mainSections']|default:[] as $mainSection}

                            <li class="nav-item">

                                <a class="nav-link pd-nav-link {((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'active' : '')}"
                                   id="{$mainSection['name']}-tab-justified"
                                   data-toggle="pill"
                                   href="#{$mainSection['name']}-justified"
                                   aria-expanded="{((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'true' : 'false')}">

                                    <i class="bx {$mainSection['icon']}"></i>

                                    <span>{$mainSection['title']}</span>

                                </a>

                            </li>

                        {/foreach}

                        <!-- MORE MENU -->
                        <li class="nav-item dropdown pd-nav-more">

                            <a class="nav-link pd-nav-link pd-nav-more-link dropdown-toggle"
                               data-toggle="dropdown"
                               href="#"
                               role="button"
                               aria-haspopup="true"
                               aria-expanded="false">

                                <i class="bx bx-dots-horizontal-rounded"></i>
                                <span>بیشتر</span>

                            </a>

                            <div class="dropdown-menu pd-nav-dropdown">

                                <div class="pd-nav-dropdown-header">
                                    <i class="bx bx-grid-alt"></i>
                                    سایر بخش‌ها
                                </div>

                                {foreach $sectionsConfig['moreSections']|default:[] as $moreSection}

                                    <a class="dropdown-item pd-nav-dropdown-item"
                                       id="{$moreSection['name']}-tab-justified"
                                       href="#{$moreSection['name']}-justified"
                                       data-toggle="pill"
                                       role="tab">

                                        <i class="bx {$moreSection['icon']}"></i>

                                        <span>{$moreSection['title']}</span>

                                    </a>

                                    {if isset($moreSection['appendAfterDivider']) && $moreSection['appendAfterDivider']}
                                        <div class="dropdown-divider"></div>
                                    {/if}

                                {/foreach}

                            </div>

                        </li>

                    </ul>

                </div>


                <!-- TAB CONTENT -->
                <div class="tab-content pd-tab-content">

                    {foreach $sectionsConfig|default:[] as $mainSectionData}

                        {foreach $mainSectionData as $mainSectionDatum}

                            <div class="tab-pane {((isset($mainSectionDatum['activeStep']) && $mainSectionDatum['activeStep']) ? 'active' : '')}"
                                 id="{$mainSectionDatum['name']}-justified"
                                 role="tabpanel"
                                 aria-labelledby="{$mainSectionDatum['name']}-tab-justified"
                                 aria-expanded="{((isset($mainSectionDatum['activeStep']) && $mainSectionDatum['activeStep']) ? 'true' : 'false')}">

                                {include $mainSectionDatum['sectionFile']}

                            </div>

                        {/foreach}

                    {/foreach}

                </div>

            {else}

                <div class="card pd-card mt-1 text-center">
                    <div class="card-body">

                        <div class="bg-rgba-danger rounded p-2">
                            <h6 class="my-1">
                                اعتبار پیش فاکتور به پایان رسیده است
                            </h6>
                        </div>

                    </div>
                </div>

            {/if}

        {/if}

    </div>
</div>


{*<div class="app-content content">*}
{*    <div class="content-wrapper">*}
{*        {$flashMessageHelper->formCallBack()}*}
{*        <div class="card shadow">*}
{*            <div class="card-header">*}
{*                <h4 class="card-title" style="float: right">*}
{*                    {$singleName}*}
{*                    <span class="bg-secondary bg-light rounded"*}
{*                          style="font-family: monospace; padding: 5px 10px;">{$getData->invoice_number}</span>*}
{*                </h4>*}
{*                {$buttonHelper->refreshAndBackButton(2)}*}
{*                <div dir="rtl" class="btn-group mb-1 float-right">*}
{*                    <div class="dropdown">*}
{*                        <button class="btn btn-sm btn-primary dropdown-toggle" type="button" id="dropdownMenuButtonIcon"*}
{*                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">*}
{*                            <i class="bx bx-dots-vertical-rounded"></i> گزینه های فرایند*}
{*                        </button>*}
{*                        <div class="dropdown-menu dropdown-menu-right text-center"*}
{*                             aria-labelledby="dropdownMenuButtonIcon"*}
{*                             x-placement="bottom-end"*}
{*                             style="position: absolute; will-change: transform; top: 0; left: 0; transform: translate3d(178px, 38px, 0px);">*}

{*                            {foreach $optionsConfig as $optionConfig}*}
{*                                {if $optionConfig['show']|default:null}*}
{*                                    {if !isset($optionConfig['type']) || $optionConfig['type'] == 'a'}*}
{*                                        <a href="{$optionConfig['href']|default:'#'}"*}
{*                                           target="{$optionConfig['target']|default:"_self"}"*}
{*                                           data-toggle="tooltip"*}
{*                                           id="option_{$optionConfig['name']}"*}
{*                                           data-original-title="{$optionConfig['description']}"*}
{*                                           class="dropdown-item {$optionConfig['class']|default:""}">*}
{*                                            <i class="bx mr-50 {$optionConfig['icon']|default:"bx-dots-vertical-rounded"}"></i>{$optionConfig['title']}*}
{*                                        </a>*}
{*                                    {elseif $optionConfig['type'] == 'button'}*}
{*                                        <button type="button"*}
{*                                                id="option_{$optionConfig['name']}"*}
{*                                                data-toggle="tooltip"*}
{*                                                data-original-title="{$optionConfig['description']}"*}
{*                                                class="btn btn-sm dropdown-item {$optionConfig['class']|default:""}">*}
{*                                            <i class="bx mr-50 {$optionConfig['icon']|default:"bx-dots-vertical-rounded"}"></i>{$optionConfig['title']}*}
{*                                        </button>*}
{*                                    {/if}*}
{*                                {/if}*}
{*                            {/foreach}*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*        </div>*}
{*        {if $getData.contract.cancelContract|default:''}*}
{*            <div class="card shadow" style="margin-top: 3px">*}
{*                <div class="card-content">*}
{*                    <div class="card-body">*}
{*                        <div class="cc-contract-cancelled">*}
{*                            <div class="cc-contract-cancelled-icon">*}
{*                                <i class="bx bx-file-blank"></i>*}
{*                                <span class="cc-contract-cancelled-mark">*}
{*                                    <i class="bx bx-x"></i>*}
{*                                </span>*}
{*                            </div>*}

{*                            <div class="cc-contract-cancelled-content">*}
{*                                <div class="cc-contract-cancelled-title">*}
{*                                    <strong>این قرارداد لغو شده است</strong>*}
{*                                    <span class="cc-contract-cancelled-badge"><i class="bx bx-x-circle"></i>لغو شده</span>*}
{*                                </div>*}
{*                                <p>*}
{*                                    این قرارداد به دلیل لغو شدن، از اعتبار خارج شده است و*}
{*                                    <strong>امکان انجام هیچ‌گونه عملیات یا ویرایشی روی آن وجود ندارد.</strong>*}
{*                                </p>*}
{*                            </div>*}

{*                            <div class="cc-contract-cancelled-lock">*}
{*                                <i class="bx bx-lock-alt"></i>*}
{*                                <span>دسترسی غیرفعال</span>*}
{*                            </div>*}

{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
{*            {else}*}
{*            <div style="display: none">*}
{*                <input type="hidden" id="invoiceId" value="{$getData.id}">*}
{*            </div>*}
{*            <div class="row">*}
{*                <div class="col-12 col-md-3">*}
{*                    <div class="card shadow h-100" style="margin: 3px 0;">*}
{*                        <div class="card-body">*}
{*                            <div class="row">*}
{*                                <div class="col-md-12 text-center">*}
{*                                    <img class="p-1 w-100" width="256"*}
{*                                         src="{(($brand) ? "/Storage/brands/{$brand->logo_address}" : "/public/images/logo/logo-side-menu.png")}"*}
{*                                         alt="logo">*}
{*                                </div>*}
{*                            </div>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*                <div class="col-12 col-md-3 pl-md-0">*}
{*                    <div class="card shadow h-100" style="margin-top: 3px">*}
{*                        <div class="card-body">*}
{*                            <div class="row">*}
{*                                <div class="col-md-12 text-center">*}
{*                                    <h6 class="mb-1"><i class="bx align-middle bx-support text-primary"></i>مشخصات کارشناس*}
{*                                    </h6>*}
{*                                    <div>*}
{*                                        {$expert->full_name}*}
{*                                        |*}
{*                                        {$saleTeam->team_title|default:'<span class="danger">بدون تیم</span>'}*}
{*                                    </div>*}
{*                                    <div>*}
{*                                        بازاریاب: -*}
{*                                    </div>*}
{*                                </div>*}
{*                            </div>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*                <div class="col-12 col-md-3 pl-md-0">*}
{*                    <div class="card shadow h-100" style="margin-top: 3px">*}
{*                        <div class="card-body">*}
{*                            <div class="row">*}
{*                                <div class="col-md-12 text-center">*}
{*                                    <h6 class="mb-1"><i class="bx align-middle bx-user-voice text-primary"></i>اطلاعات مشتری*}
{*                                    </h6>*}
{*                                    <div>*}
{*                                        <a target="_blank"*}
{*                                           href="/CustomerContactInformation/contactDetail/{$contact->id}">{$contact->contact_code}*}
{*                                            | {$contact->contactFullName()}</a>*}
{*                                    </div>*}
{*                                    <div>*}
{*                                        {$company->company_name|default:''}*}
{*                                    </div>*}
{*                                </div>*}
{*                            </div>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*                <div class="col-12 col-md-3 pl-md-0">*}
{*                    <div class="card shadow h-100" style="margin-top: 3px">*}
{*                        <div class="card-body">*}
{*                            <div class="row">*}
{*                                <div class="col-md-12 text-center">*}
{*                                    <h6 class="mb-1"><i class="bx align-middle bx-file text-primary"></i>اطلاعات پیش فاکتور*}
{*                                    </h6>*}
{*                                    <div>*}
{*                                        تاریخ و ساعت صدور: <span*}
{*                                                dir="ltr">{jdate("Y/m/d H:i" , strtotime($getData->created_at))}</span>*}
{*                                    </div>*}
{*                                    <div>*}
{*                                        زمان تحویل: <u>{$getData->delivery_date}</u> روز کاری*}
{*                                    </div>*}
{*                                    <div>*}
{*                                        استان و شهر: {$state->title} - {$city->title}*}
{*                                    </div>*}
{*                                </div>*}
{*                            </div>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}

{*            </div>*}

{*            *}{*        {if $getData->checkInvoiceValidity()}*}
{*            {if true}*}
{*                {$csrf->csrfTokenInput()}*}
{*                <div class="card shadow" style="margin-top: 10px">*}
{*                    <div class="card-content">*}
{*                        <div class="card-body">*}
{*                            <ul class="nav nav-pills nav-justified">*}
{*                                {foreach $sectionsConfig['mainSections']|default:[] as $mainSection}*}
{*                                    <li class="nav-item">*}
{*                                        <a class="nav-link {((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'active' : '')}"*}
{*                                           id="{$mainSection['name']}-tab-justified"*}
{*                                           data-toggle="pill"*}
{*                                           href="#{$mainSection['name']}-justified"*}
{*                                           aria-expanded="{((isset($mainSection['activeStep']) && $mainSection['activeStep']) ? 'true' : 'false')}"><i*}
{*                                                    class="bx {$mainSection['icon']} align-middle"></i>{$mainSection['title']}*}
{*                                        </a>*}
{*                                    </li>*}
{*                                {/foreach}*}

{*                                <li class="nav-item dropdown">*}
{*                                    <a class="nav-link dropdown-toggle h-100" data-toggle="dropdown" href="#" role="button"*}
{*                                       aria-haspopup="true" aria-expanded="false">*}
{*                                        <i class="bx bx-dots-vertical-rounded mr-50 align-middle"></i>بیشتر*}
{*                                    </a>*}
{*                                    <div class="dropdown-menu">*}
{*                                        {foreach $sectionsConfig['moreSections']|default:[] as $moreSection}*}
{*                                            <a class="dropdown-item" id="{$moreSection['name']}-tab-justified"*}
{*                                               href="#{$moreSection['name']}-justified"*}
{*                                               data-toggle="pill" role="tab"><i*}
{*                                                        class="bx {$moreSection['icon']} mr-50"></i> {$moreSection['title']}*}
{*                                            </a>*}
{*                                            {if isset($moreSection['appendAfterDivider']) && $moreSection['appendAfterDivider']}*}
{*                                                <div class="dropdown-divider"></div>*}
{*                                            {/if}*}
{*                                        {/foreach}*}
{*                                    </div>*}
{*                                </li>*}
{*                            </ul>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*                <div class="tab-content">*}
{*                    {foreach $sectionsConfig|default:[] as $mainSectionData}*}
{*                        {foreach $mainSectionData as $mainSectionDatum}*}
{*                            <div class="tab-pane {((isset($mainSectionDatum['activeStep']) && $mainSectionDatum['activeStep']) ? 'active' : '')}"*}
{*                                 id="{$mainSectionDatum['name']}-justified" role="tabpanel"*}
{*                                 aria-labelledby="{$mainSectionDatum['name']}-tab-justified"*}
{*                                 aria-expanded="{((isset($mainSectionDatum['activeStep']) && $mainSectionDatum['activeStep']) ? 'true' : 'false')}">*}
{*                                {include $mainSectionDatum['sectionFile']}*}
{*                            </div>*}
{*                        {/foreach}*}
{*                    {/foreach}*}
{*                </div>*}
{*            {else}*}
{*                <div class="card shadow mt-1 text-center">*}
{*                    <div class="card-content">*}
{*                        <div class="card-body">*}
{*                            <div class="row">*}
{*                                <div class="col-md-12 bg-rgba-danger rounded">*}
{*                                    <h6 class="my-1">اعتبار پیش فاکتور به پایان رسیده است</h6>*}
{*                                </div>*}
{*                            </div>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            {/if}*}

{*        {/if}*}



{*    </div>*}
{*</div>*}

<script src="/public/vendors/js/extensions/jquery.steps.min.js"></script>
<script src="/public/vendors/js/forms/validation/jquery.validate.min.js"></script>
<script src="/public/js/scripts/forms/wizard-steps.js"></script>

{include 'sections/footer.tpl'}