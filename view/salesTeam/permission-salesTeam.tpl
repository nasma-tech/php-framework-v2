{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <form method="post" id="mainForm" action="/salesTeam/saveSalePermissions" data-team-id="{$getData->id}">
            {$csrf->csrfTokenInput()}
            <input type="hidden" name="sale_permissions" id="salePermissionsInput" value="[]">
            <div id="salePermissions" data-team-id="{$getData->id}">
                <div class="permissions-card permissions-main-card">
                    <div class="permissions-header">
                        <div class="permissions-header-content">
                            <div class="permissions-title-wrapper">
                                <div class="permissions-title-icon">
                                    <i class="bx bx-shield"></i>
                                </div>
                                <div>
                                    <h4 class="permissions-title">
                                        دسترسی فروش تیم
                                        <span class="team-name">
                                            {$getData->team_title}
                                        </span>
                                    </h4>
                                    <p class="permissions-subtitle">
                                        محصولات مجاز فروش و قیمت اختصاصی این تیم را مدیریت کنید
                                    </p>
                                </div>
                            </div>
                            <div class="permissions-header-actions">
                                {$buttonHelper->refreshAndBackBtn()}
                                <button class="btn btn-sm btn-primary text-white" style="float: left;margin-right: 5px;margin-left: 5px;cursor: pointer"> ثبت دسترسی های فروش
                                    <i class="bx bx-save"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="permissions-workspace" id="permissionsWorkspace">
                        <section class="permission-panel brands-panel">
                            <div class="permission-panel-header">
                                <div class="permission-panel-header-row">
                                    <h6 class="permission-panel-title">
                                        <i class="bx bx-purchase-tag"></i>
                                        برندها
                                    </h6>
                                    <span class="permission-count" id="brandCount">
                                        ۰
                                    </span>
                                </div>
                            </div>
                            <div class="brand-search-wrapper">
                                <div class="brand-search">
                                    <i class="bx bx-search"></i>
                                    <input type="text" id="brandSearch" class="form-control" placeholder="جستجوی برند..." autocomplete="off">
                                    <button type="button" class="brand-search-clear" id="brandSearchClear" style="display:none" title="پاک کردن جستجو">
                                        <i class="bx bx-x"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="brand-list" id="brandsList">
                                <div class="permission-empty">
                                    <div class="permission-empty-icon">
                                        <i class="bx bx-loader-alt bx-spin"></i>
                                    </div>
                                    <strong>
                                        در حال دریافت برندها...
                                    </strong>
                                </div>
                            </div>
                        </section>
                        <section class="permission-panel products-panel" id="productsPanel">
                            <div class="permission-panel-header">
                                <div class="permission-panel-header-row">
                                    <h6 class="permission-panel-title">
                                        <i class="bx bx-package"></i>
                                        محصولات
                                    </h6>
                                    <span class="permission-count" id="visibleProductCount">۰</span>
                                </div>
                            </div>
                            <div class="product-toolbar">
                                <div class="product-search">
                                    <i class="bx bx-search"></i>
                                    <input type="text" id="productSearch" class="form-control" placeholder="جستجوی محصول در این برند..." autocomplete="off">
                                    <button type="button" class="product-search-clear" id="productSearchClear" style="display:none" title="پاک کردن جستجو">
                                        <i class="bx bx-x"></i>
                                    </button>
                                </div>
                                <div class="product-actions">
                                    <span class="product-actions-text" id="productSelectionInfo">
                                        یک برند را انتخاب کنید
                                    </span>
                                    <button type="button" class="btn btn-sm product-select-all" id="selectAllProducts" disabled>
                                        <i class="bx bx-check-double"></i>
                                        انتخاب همه
                                    </button>
                                </div>
                            </div>
                            <div class="products-list" id="productsList">
                                <div class="permission-empty">
                                    <div class="permission-empty-icon">
                                        <i class="bx bx-package"></i>
                                    </div>
                                    <strong>انتخاب یک برند</strong>
                                    <span>برای مشاهده محصولات، ابتدا یک برند را انتخاب کنید.</span>
                                </div>
                            </div>
                            <div id="productsLoading" class="sale-products-loading" style="display:none">
                                <span class="spinner-border spinner-border-sm"></span>
                                <span>در حال دریافت محصولات...</span>
                            </div>
                        </section>
                        <section class="permission-panelselected-panel" id="selectedPanel">
                            <div class="permission-panel-header">
                                <div class="permission-panel-header-row">
                                    <h6 class="permission-panel-title">
                                        <i class="bx bx-check-shield"></i>
                                        محصولات مجاز فروش
                                    </h6>
                                    <div class="selected-panel-actions">
                                        <span class="permission-count" id="selectedCount">۰</span>
                                        <button type="button" class="btn btn-sm selected-delete-all" id="deleteAllProducts" title="حذف همه محصولات">
                                            <i class="bx bx-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="selected-summary">
                                <div class="summary-item">
                                    <span class="summary-number" id="summaryProducts">۰</span>
                                    <span class="summary-label">محصول</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-number" id="summaryBrands">۰</span>
                                    <span class="summary-label">برند</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-number" id="summaryOverrides">۰</span>
                                    <span class="summary-label">قیمت اختصاصی</span>
                                </div>
                            </div>
                            <div class="selected-products-toolbar">
                                <div class="sale-search">
                                    <i class="bx bx-search"></i>
                                    <input type="text" id="selectedProductSearch" class="form-control" placeholder="جستجو در محصولات مجاز..." autocomplete="off">
                                    <button type="button" class="selected-search-clear" id="selectedSearchClear" style="display:none" title="پاک کردن جستجو">
                                        <i class="bx bx-x"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="selected-products" id="selectedProducts">
                                <div class="permission-empty">
                                    <div class="permission-empty-icon">
                                        <i class="bx bx-check-shield"></i>
                                    </div>
                                    <strong>هنوز محصولی انتخاب نشده</strong>
                                    <span>محصولات مورد نظر را از لیست محصولات انتخاب کنید.</span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="permissions-footer">
                        <div class="permission-footer-info">
                            <span class="footer-info-icon">
                                <i class="bx bx-info-circle"></i>
                            </span>
                            <span>اگر قیمت اختصاصی وارد نشود، قیمت پیش‌فرض محصول استفاده خواهد شد.</span>
                        </div>
                        <div class="footer-selected-info">
                            <span>تعداد محصولات مجاز برای فروش در این تیم:</span>
                            <strong id="footerSelectedCount">۰</strong>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
{include 'sections/footer.tpl'}