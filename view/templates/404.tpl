{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<main class="error-main" id="errorMain">
    <section class="error-container" id="errorContainer">
        <div class="error-content" id="errorContent">
            <div class="error-status" id="errorStatus">
                    <span class="error-status-indicator" id="errorStatusIndicator">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="2" stroke-linecap="round"
                             stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="9"/>
                            <path d="M12 8v4M12 16h.01"/>
                        </svg>
                    </span>
                <span class="error-status-text">خطا در دسترسی به صفحه</span>
            </div>
            <h1 class="error-title" id="errorTitle">
                {($errorText)?$errorText:'صفحه موردنظر پیدا نشد'}
            </h1>

            <p class="error-description" id="errorDescription">
                متأسفانه صفحه‌ای که به دنبال آن هستید در دسترس نیست.
                ممکن است آدرس صفحه تغییر کرده باشد، لینک واردشده
                اشتباه باشد یا این صفحه دیگر وجود نداشته باشد.
            </p>

            <div class="error-actions" id="errorActions">
                <a class="error-button error-button-primary"
                   id="errorHomeButton" href="/">
                    <svg class="error-button-icon" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="1.8"
                         stroke-linecap="round" stroke-linejoin="round"
                         aria-hidden="true">
                        <path d="m3 10 9-7 9 7"/>
                        <path d="M5 9v11h14V9M9 20v-7h6v7"/>
                    </svg>
                    <span>بازگشت به صفحه اصلی</span>
                </a>

                <button class="error-button error-button-secondary"
                        id="errorBackButton" type="button">
                    <svg class="error-button-icon" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="1.8"
                         stroke-linecap="round" stroke-linejoin="round"
                         aria-hidden="true">
                        <path d="M19 12H5M12 19l-7-7 7-7"/>
                    </svg>
                    <span>بازگشت به صفحه قبل</span>
                </button>
            </div>

            <div class="error-divider" id="errorDivider"></div>

            <div class="error-help" id="errorHelp">
                    <span class="error-help-icon" id="errorHelpIcon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="1.8" stroke-linecap="round"
                             stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="9"/>
                            <path d="M9.5 9a2.5 2.5 0 1 1 4.2 1.8c-1.1 1-1.7 1.2-1.7 2.7M12 17h.01"/>
                        </svg>
                    </span>

                <p class="error-help-text">
                    اگر فکر می‌کنید این خطا اشتباهی رخ داده است،
                    با واحد پشتیبانی سامانه تماس بگیرید.
                </p>
            </div>
        </div>

        <div class="error-visual" id="errorVisual"
             role="img" aria-label="تصویر نمادین صفحه پیدا نشده">
            <div class="error-visual-grid" id="errorVisualGrid"></div>

            <div class="error-visual-orbit error-visual-orbit-outer"
                 id="errorVisualOrbitOuter"></div>
            <div class="error-visual-orbit error-visual-orbit-inner"
                 id="errorVisualOrbitInner"></div>

            <div class="error-visual-card" id="errorVisualCard">
                <div class="error-document-top" id="errorDocumentTop">
                        <span class="error-document-icon" id="errorDocumentIcon">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                 stroke-width="1.8" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <path d="M13 3H6a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10z"/>
                                <path d="M13 3v7h7M8 14h8M8 17h5"/>
                            </svg>
                        </span>
                    <span class="error-document-label">PAGE NOT FOUND</span>
                </div>

                <div class="error-document-lines" id="errorDocumentLines">
                        <span class="error-document-line error-document-line-long">
                            محتوای صفحه
                        </span>
                    <span class="error-document-line error-document-line-medium">
                            اطلاعات سامانه
                        </span>
                    <span class="error-document-line error-document-line-short">
                            مسیر نامعتبر
                        </span>
                </div>

                <div class="error-document-footer" id="errorDocumentFooter">
                    <span class="error-document-footer-dot"></span>
                    <span class="error-document-footer-text">صفحه در دسترس نیست</span>
                </div>
            </div>

            <div class="error-search" id="errorSearch">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="1.8" stroke-linecap="round"
                     stroke-linejoin="round" aria-hidden="true">
                    <circle cx="10.8" cy="10.8" r="6.8"/>
                    <path d="m16 16 4.5 4.5"/>
                    <path d="m8.5 8.5 4.6 4.6m0-4.6-4.6 4.6"/>
                </svg>
            </div>
            <div class="error-floating-label" id="errorFloatingLabel">
                <span class="error-floating-label-number">404</span>
                <span class="error-floating-label-text">مسیر یافت نشد</span>
            </div>
            <div class="error-visual-caption" id="errorVisualCaption">
                    <span class="error-visual-caption-icon">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="1.8" stroke-linecap="round"
                             stroke-linejoin="round" aria-hidden="true">
                            <path d="M12 8v4M12 16h.01"/>
                            <circle cx="12" cy="12" r="9"/>
                        </svg>
                    </span>
                <span>این مسیر در سامانه تعریف نشده است</span>
            </div>
        </div>
    </section>
</main>


{include 'sections/footer.tpl'}