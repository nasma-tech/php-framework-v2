{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<main class="error-main" id="serverErrorMain">
    <section class="error-container" id="serverErrorContainer">

        <div class="error-content" id="serverErrorContent">
            <div class="error-status" id="serverErrorStatus">
                    <span class="error-status-indicator" id="serverErrorStatusIcon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="2" stroke-linecap="round"
                             stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="9"/>
                            <path d="M12 8v4M12 16h.01"/>
                        </svg>
                    </span>
                <span class="error-status-text">خطای داخلی سامانه</span>
            </div>

            <h1 class="error-title" id="serverErrorTitle">
                عدم دسترسی
            </h1>

            <p class="error-description" id="serverErrorDescription">
                {$errorText|default: 'نامشخص'}
            </p>

            <div class="error-actions" id="serverErrorActions">
                <button class="error-button error-button-primary"
                        id="serverErrorRetryButton" type="button">
                    <svg class="error-button-icon" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="1.8"
                         stroke-linecap="round" stroke-linejoin="round"
                         aria-hidden="true">
                        <path d="M20 7v5h-5"/>
                        <path d="M4.9 16A8 8 0 0 0 18.4 19L20 17"/>
                        <path d="M4 12a8 8 0 0 1 13.5-5L20 9"/>
                        <path d="M4 7v5h5"/>
                    </svg>
                    <span>تلاش مجدد</span>
                </button>

                <a class="error-button error-button-secondary"
                   id="serverErrorHomeButton" href="/">
                    <svg class="error-button-icon" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="1.8"
                         stroke-linecap="round" stroke-linejoin="round"
                         aria-hidden="true">
                        <path d="m3 10 9-7 9 7"/>
                        <path d="M5 9v11h14V9M9 20v-7h6v7"/>
                    </svg>
                    <span>بازگشت به صفحه اصلی</span>
                </a>
            </div>

            <div class="error-divider" id="serverErrorDivider"></div>

            <div class="error-help" id="serverErrorHelp">
                    <span class="error-help-icon" id="serverErrorHelpIcon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="1.8" stroke-linecap="round"
                             stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="9"/>
                            <path d="M9.5 9a2.5 2.5 0 1 1 4.2 1.8c-1.1 1-1.7 1.2-1.7 2.7M12 17h.01"/>
                        </svg>
                    </span>

                <p class="error-help-text">
                    اگر مشکل ادامه داشت، لطفاً با واحد پشتیبانی سامانه تماس بگیرید.
                </p>
            </div>
        </div>

        <div class="error-visual" id="serverErrorVisual"
             role="img" aria-label="تصویر نمادین اختلال در سرور">
            <div class="error-visual-grid" id="serverErrorVisualGrid"></div>

            <div class="error-visual-orbit error-visual-orbit-outer"
                 id="serverErrorOrbitOuter"></div>
            <div class="error-visual-orbit error-visual-orbit-inner"
                 id="serverErrorOrbitInner"></div>

            <div class="error-visual-card" id="serverErrorVisualCard">
                <div class="error-document-top" id="serverErrorDocumentTop">
                        <span class="error-document-icon" id="serverErrorDocumentIcon">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                 stroke-width="1.8" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="4" width="18" height="16" rx="2"/>
                                <path d="M7 8h10M7 12h4M7 16h6"/>
                            </svg>
                        </span>
                    <span class="error-document-label">SERVER STATUS</span>
                </div>

                <div class="error-document-lines" id="serverErrorDocumentLines">
                        <span class="error-document-line error-document-line-long">
                            وضعیت سرویس
                        </span>
                    <span class="error-document-line error-document-line-medium">
                            پردازش درخواست
                        </span>
                    <span class="error-document-line error-document-line-short">
                            خطای داخلی
                        </span>
                </div>

                <div class="error-document-footer" id="serverErrorDocumentFooter">
                    <span class="error-document-footer-dot"></span>
                    <span class="error-document-footer-text">نیازمند بررسی سامانه</span>
                </div>
            </div>

            <div class="error-search" id="serverErrorVisualIcon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="1.8" stroke-linecap="round"
                     stroke-linejoin="round" aria-hidden="true">
                    <path d="M12 8v4M12 16h.01"/>
                    <circle cx="12" cy="12" r="9"/>
                </svg>
            </div>

            <div class="error-floating-label" id="serverErrorFloatingLabel">
                <span class="error-floating-label-number">403</span>
                <span class="error-floating-label-text">عدم دسترسی</span>
            </div>

            <div class="error-visual-caption" id="serverErrorVisualCaption">
                    <span class="error-visual-caption-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="1.8" stroke-linecap="round"
                             stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="9"/>
                            <path d="M12 8v4M12 16h.01"/>
                        </svg>
                    </span>
                <span>پردازش درخواست با مشکل مواجه شده است</span>
            </div>
        </div>

    </section>
</main>


{include 'sections/footer.tpl'}