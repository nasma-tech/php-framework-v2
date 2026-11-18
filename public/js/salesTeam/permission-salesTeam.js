(function ($) {
    "use strict";
    const config = {
        brandsUrl: '/salesTeam/getSalePermissionBrands',
        productsUrl: '/salesTeam/getSalePermissionProducts',
        existingUrl: '/salesTeam/getSalePermissionProductsForTeam',
        saveUrl: $('#mainForm').attr('action') || window.location.href,
        teamId: parseInt($('#salePermissions').data('team-id') || $('#mainForm').data('team-id') || 0, 10),
        productsPerPage: 30,
        searchDelay: 350
    };

    const state = {
        brands: {},
        activeBrandId: null,
        products: [],
        selected: {},
        productPage: 1,
        productHasMore: false,
        loadingProducts: false,
        loadingBrands: false,
        loadingExisting: false,
        productSearch: '',
        selectedSearch: '',
        brandSearch: '',
        searchTimer: null,
        saving: false
    };

    const $workspace = $('#permissionsWorkspace');
    const $brandsList = $('#brandsList');
    const $productsList = $('#productsList');
    const $selectedProducts = $('#selectedProducts');
    const $brandSearch = $('#brandSearch');
    const $brandSearchClear = $('#brandSearchClear');
    const $productSearch = $('#productSearch');
    const $productSearchClear = $('#productSearchClear');
    const $selectedSearch = $('#selectedProductSearch');
    const $selectedSearchClear = $('#selectedSearchClear');
    const $selectAllProducts = $('#selectAllProducts');
    const $deleteAllProducts = $('#deleteAllProducts');
    const $brandCount = $('#brandCount');
    const $visibleProductCount = $('#visibleProductCount');
    const $selectedCount = $('#selectedCount');
    const $summaryProducts = $('#summaryProducts');
    const $summaryBrands = $('#summaryBrands');
    const $summaryOverrides = $('#summaryOverrides');
    const $footerSelectedCount = $('#footerSelectedCount');
    const $productSelectionInfo = $('#productSelectionInfo');
    const $productsLoading = $('#productsLoading');
    const $activeBrandTitle = $('#activeBrandTitle');
    const $activeBrandCount = $('#activeBrandCount');
    const $salePermissionsInput = $('#salePermissionsInput');

    $(function () {
        ensureHiddenInput();
        bindEvents();
        initialize();
    });

    async function initialize() {
        await loadBrands();
        if (config.teamId > 0) {
            await loadExistingPermissions();
        }

        renderBrands();
        renderSelectedProducts();
        updateSummary();

        const selectedProducts = Object.values(state.selected);
        if (selectedProducts.length) {
            const firstBrandId = parseInt(selectedProducts[0].brandId, 10);
            if (firstBrandId && state.brands[firstBrandId]) {
                await selectBrand(firstBrandId);
            } else {
                activateFirstBrand();
            }
        } else {
            activateFirstBrand();
        }

        activateWorkspacePanel('products');
    }

    async function saveSalePermissions(products) {
        if (state.saving) {
            return;
        }

        state.saving = true;
        const $button = $('.addFormAjax');
        const originalHtml = $button.html();
        $button.prop('disabled', true).html(`
            <span
                class="spinner-border spinner-border-sm mr-1"
                role="status"
            ></span>
            در حال ذخیره...
        `);

        try {
            const response = await postAjax(config.saveUrl, {
                team_id: config.teamId,
                sale_permissions: JSON.stringify(products)
            });
            if (!response || response.success !== true) {
                Swal.fire({
                    icon: 'error',
                    title: 'ذخیره انجام نشد',
                    text: response?.message || 'خطایی هنگام ذخیره دسترسی‌های فروش رخ داد.',
                    confirmButtonText: 'باشه',
                    customClass: {
                        popup: 'rtl'
                    }
                });
                return;
            }
            await Swal.fire({
                icon: 'success',
                title: 'با موفقیت ذخیره شد',
                text: response.message || 'دسترسی‌های فروش تیم با موفقیت ثبت شد.',
                confirmButtonText: 'باشه',
                customClass: {
                    popup: 'rtl'
                }
            });
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        } catch (error) {
            console.error('saveSalePermissions:', error);
            Swal.fire({
                icon: 'error',
                title: 'خطا در ذخیره اطلاعات',
                text: 'ارتباط با سرور برقرار نشد. لطفاً دوباره تلاش کنید.',
                confirmButtonText: 'باشه',
                customClass: {
                    popup: 'rtl'
                }
            });
        } finally {
            state.saving = false;
            $button.prop('disabled', false).html(originalHtml);
        }
    }

    function isPriceBelowDefault(product) {
        const price = parseInt(product.price, 10);
        const defaultPrice = parseInt(product.defaultPrice, 10);

        return (!isNaN(price) && price > 0 && !isNaN(defaultPrice) && price < defaultPrice);
    }

    function showSaveConfirmation(products) {
        const selectedProducts = Object.values(state.selected);
        if (!selectedProducts.length) {
            return;
        }

        const grouped = {};
        selectedProducts.forEach(function (product) {
            const brandId = parseInt(product.brandId, 10) || 0;
            if (!grouped[brandId]) {
                grouped[brandId] = {
                    name: product.brandName || getBrandName(brandId) || 'برند نامشخص',
                    products: []
                };
            }

            grouped[brandId].products.push(product);
        });

        let tableRows = '';
        let rowNumber = 0;

        Object.keys(grouped).forEach(function (brandId) {
            const brand = grouped[brandId];
            brand.products.forEach(function (product) {
                rowNumber++;

                const hasCustomPrice = product.price !== null && product.price !== '' &&
                    typeof product.price !== 'undefined' && parseInt(product.price, 10) > 0;

                const priceBelowDefault = isPriceBelowDefault(product);
                const finalPrice = hasCustomPrice ? product.price : product.defaultPrice;
                tableRows += `
                <tr>
                    <td class="sale-confirm-number">
                        ${formatNumber(rowNumber)}
                    </td>
                    <td>
                        <div class="sale-confirm-product">
                            <strong>
                                ${escapeHtml(product.name || 'بدون عنوان')}
                            </strong>
                            ${product.code ? `<small>کد: ${escapeHtml(product.code)}</small>` : ''}
                        </div>
                    </td>
                    <td>
                        <span class="sale-confirm-brand">
                            ${escapeHtml(brand.name)}
                        </span>
                    </td>
                    <td>
                        ${product.categoryName ? escapeHtml(product.categoryName) : '—'}
                    </td>
                    <td>
                        ${product.groupName ? escapeHtml(product.groupName) : '—'}
                    </td>
                    <td>
                        ${product.gradeName ? escapeHtml(product.gradeName) : '—'}
                    </td>
                    <td>
                        ${product.qualityName ? escapeHtml(product.qualityName) : '—'}
                    </td>
                    <td>
                        ${product.unitSymbol || product.unitName ? escapeHtml(product.unitSymbol || product.unitName) : '—'}
                    </td>
                    <td>
                        ${formatPrice(product.defaultPrice)}
                    </td>
                    <td>
                        <div class="sale-confirm-price">
                            <div>
                                <strong>
                                    ${formatPrice(finalPrice)}
                                </strong>
                                <span>ریال</span>
                                ${hasCustomPrice ? `<small class="custom-price-label">قیمت اختصاصی</small>` : ''}
                            </div>
                            ${priceBelowDefault ? `
                                <div class="override-price-warning">
                                    <i class="bx bx-error-circle"></i>
                                    قیمت پایین‌تر از قیمت مصوب است
                                </div>
                            ` : ''}
                        </div>
                    </td>
                </tr>
            `;
            });
        });

        const brandCount = Object.keys(grouped).length;
        const customPriceCount = selectedProducts.filter(function (product) {
            return (
                product.price !== null &&
                product.price !== '' &&
                typeof product.price !== 'undefined' &&
                parseInt(product.price, 10) > 0
            );
        }).length;
        Swal.fire({
            title: 'تأیید دسترسی‌های فروش',
            html: `
            <div class="sale-confirmation">
                <div class="sale-confirmation-header">
                    <div class="sale-confirmation-description">
                        <i class="bx bx-info-circle"></i>
                        <span>
                            لطفاً محصولات و قیمت‌های فروش تیم را بررسی کنید
                            و در صورت تأیید، روی «ثبت دسترسی‌ها» کلیک کنید.
                        </span>
                    </div>
                    <div class="sale-confirmation-summary">
                        <div class="sale-confirm-summary-item" style="width:100%">
                            <strong>
                                ${formatNumber(selectedProducts.length)}
                            </strong>
                            <span>محصول</span>
                        </div>
                        <div class="sale-confirm-summary-item" style="width:100%">
                            <strong>
                                ${formatNumber(brandCount)}
                            </strong>
                            <span>برند</span>
                        </div>
                        <div class="sale-confirm-summary-item" style="width:100%">
                            <strong>
                                ${formatNumber(customPriceCount)}
                            </strong>
                            <span>قیمت اختصاصی</span>
                        </div>
                    </div>
                </div>
                <div class="sale-confirm-table-wrapper">
                    <table class="sale-confirm-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>محصول</th>
                                <th>برند</th>
                                <th>دسته‌بندی</th>
                                <th>گروه</th>
                                <th>گرید</th>
                                <th>سطح کیفی</th>
                                <th>واحد</th>
                                <th>قیمت مصوب</th>
                                <th>قیمت فروش</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${tableRows}
                        </tbody>
                    </table>
                </div>
                <div class="sale-confirmation-warning">
                    <i class="bx bx-info-circle"></i>
                    <span>
                        برای محصولاتی که قیمت اختصاصی تعیین نشده است،
                        قیمت اصلی محصول استفاده خواهد شد.
                    </span>
                </div>
            </div>
        `,
            width: '60%',
            maxWidth: '1400px',
            showCancelButton: true,
            confirmButtonText: `<i class="bx bx-check"></i>ثبت دسترسی‌ها`,
            cancelButtonText: `<i class="bx bx-x"></i> بازگشت و ویرایش`,
            reverseButtons: true,
            focusCancel: true,
            customClass: {
                popup: 'rtl sale-confirmation-popup',
                confirmButton: 'btn btn-primary',
                cancelButton: 'btn btn-light'
            },
            buttonsStyling: false
        }).then(function (result) {
            if (!result.isConfirmed) {
                return;
            }

            saveSalePermissions(products);
        });
    }

    function bindEvents() {
        $(document).on('click', '.sale-brand-item', function () {
            const brandId = parseInt($(this).attr('data-brand-id'), 10);
            if (!brandId) {
                return;
            }

            activateWorkspacePanel('products');
            selectBrand(brandId);
        });

        $brandSearch.on('input', function () {
            state.brandSearch = $(this).val().trim().toLowerCase();
            updateBrandSearchClear();
            renderBrands();
        });

        $brandSearchClear.on('click', function () {
            state.brandSearch = '';
            $brandSearch.val('');
            updateBrandSearchClear();
            renderBrands();
            $brandSearch.trigger('focus');
        });

        $(document).on('click', '.product-row', function (event) {
            if ($(event.target).closest('button, input, a').length) {
                return;
            }

            activateWorkspacePanel('products');

            const product = productFromRow($(this));
            if (!product) {
                return;
            }

            toggleProduct(product);
        });

        $(document).on('click', '.product-select-checkbox', function (event) {
            event.preventDefault();
            event.stopPropagation();
            activateWorkspacePanel('products');

            const $row = $(this).closest('.product-row');
            const product = productFromRow($row);
            if (!product) {
                return;
            }

            toggleProduct(product);
        });

        $(document).on('mousedown', '#selectedPanel', function () {
            activateWorkspacePanel('selected');
        });

        $(document).on('focusin', '#selectedPanel input, #selectedPanel button', function () {
            activateWorkspacePanel('selected');
        });

        $(document).on('mousedown', '#productsPanel', function () {
            activateWorkspacePanel('products');
        });

        $(document).on('focusin', '#productsPanel input, #productsPanel button', function () {
            activateWorkspacePanel("products");
        });

        $(document).on('click', '.remove-product', function (event) {
            event.preventDefault();
            event.stopPropagation();
            const productId = parseInt($(this).attr("data-product-id"), 10);
            if (!productId) {
                return;
            }

            removeProduct(productId);
        });

        $(document).on('input', '.override-price', function () {
            const $input = $(this);
            const productId = parseInt($input.attr('data-product-id'), 10);
            if (!productId || !state.selected[productId]) {
                return;
            }

            let value = toEnglishDigits($input.val());
            value = value.replace(/,/g, '').replace(/\D/g, '');
            $input.val(value ? formatPrice(value) : '');

            const numericValue = value ? parseInt(value, 10) : null;
            const product = state.selected[productId];
            product.price = numericValue;

            const $selectedProduct = $input.closest('.selected-product');
            const $warning = $selectedProduct.find('.override-price-warning');
            if (isPriceBelowDefault(product)) {
                $warning.show();
                $selectedProduct.addClass('price-below-default');
            } else {
                $warning.hide();
                $selectedProduct.removeClass('price-below-default');
            }

            if (numericValue !== null && numericValue > 0) {
                $selectedProduct.addClass('has-custom-price');
            } else {
                $selectedProduct.removeClass('has-custom-price');
            }

            updateHiddenInput();
            updateSummary();
        });

        $productSearch.on('input', function () {
            state.productSearch = $(this).val().trim();
            updateProductSearchClear();
            clearTimeout(state.searchTimer);
            state.searchTimer = setTimeout(function () {
                loadProducts(true);
            }, config.searchDelay);
        });

        $productSearchClear.on('click', function () {
            state.productSearch = '';
            $productSearch.val('');
            updateProductSearchClear();
            loadProducts(true);
            $productSearch.trigger('focus');
        });

        $selectedSearch.on('input', function () {
            state.selectedSearch = $(this).val().trim().toLowerCase();
            updateSelectedSearchClear();
            renderSelectedProducts();
        });

        $selectedSearchClear.on('click', function () {
            state.selectedSearch = '';
            $selectedSearch.val('');
            updateSelectedSearchClear();
            renderSelectedProducts();
            $selectedSearch.trigger('focus');
        });

        $selectAllProducts.on('click', function () {
            activateWorkspacePanel('products');
            toggleSelectAllCurrentProducts();
        });

        $deleteAllProducts.on("click", function () {
            activateWorkspacePanel("selected");
            deleteAllSelectedProducts();
        });

        $productsList.on('scroll', function () {
            if (state.loadingProducts || !state.productHasMore) {
                return;
            }

            const el = this;
            const nearBottom = el.scrollTop + el.clientHeight >= el.scrollHeight - 150;
            if (nearBottom) {
                loadProducts(false);
            }
        });

        $('#mainForm').on('submit', function (e) {
            e.preventDefault();
            if (state.saving) {
                return;
            }

            updateHiddenInput();
            const permissions = $('#salePermissionsInput').val();
            let products = [];

            try {
                products = JSON.parse(permissions || '[]');
            } catch (error) {
                showError('اطلاعات محصولات انتخاب شده نامعتبر است.');
                return;
            }

            if (!products.length) {
                Swal.fire({
                    icon: 'warning',
                    title: 'محصولی انتخاب نشده است',
                    text: 'لطفاً حداقل یک محصول برای فروش تیم انتخاب کنید.',
                    confirmButtonText: 'باشه',
                    customClass: {
                        popup: 'rtl'
                    }
                });

                return;
            }

            showSaveConfirmation(products);
        });

        $(document).on('click', '.addFormAjax', function () {
            updateHiddenInput();
        });
    }

    function activateWorkspacePanel(panel) {
        if (!$workspace.length) {
            return;
        }

        $workspace.removeClass('workspace-focus-products workspace-focus-selected');
        if (panel === "selected") {
            $workspace.addClass('workspace-focus-selected');
        } else {
            $workspace.addClass('workspace-focus-products');
        }
    }

    async function loadBrands() {
        if (state.loadingBrands) {
            return;
        }

        state.loadingBrands = true;

        try {
            const response = await postAjax(config.brandsUrl, {});
            if (!response || response.success !== true) {
                showError(response?.message || 'دریافت برندها انجام نشد.');
                return;
            }

            const brands = Array.isArray(response.brands) ? response.brands : (Array.isArray(response.data) ? response.data : []);
            state.brands = {};

            brands.forEach(function (brand) {
                const id = parseInt(brand.id, 10);
                if (!id) {
                    return;
                }

                const name = brand.name || brand.brand_persian_name || brand.brand_latin_name || '';
                state.brands[id] = {
                    id: id,
                    name: name,
                    latinName: brand.brand_latin_name || '',
                    logo: brand.brand_logo || brand.logo || ''
                };
            });

            renderBrands();
            updateSummary();
        } catch (error) {
            console.error('loadBrands:', error);
            showError('خطا در دریافت برندها');
        } finally {
            state.loadingBrands = false;
        }
    }

    function getFilteredBrands() {
        const brands = Object.values(state.brands);
        if (!state.brandSearch) {
            return brands;
        }

        const search = state.brandSearch;
        return brands.filter(function (brand) {
            const text = [
                brand.name,
                brand.latinName
            ].filter(Boolean).join(' ').toLowerCase();

            return text.includes(search);
        });
    }

    function renderBrands() {
        if (!$brandsList.length) {
            return;
        }

        const brands = getFilteredBrands();
        if (!brands.length) {
            $brandsList.html(`
                <div class="permission-empty">
                    <div class="permission-empty-icon">
                        <i class="bx bx-search-alt"></i>
                    </div>
                    <strong>برندی یافت نشد</strong>
                    <span>
                        ${state.brandSearch ? "عبارت جستجو را تغییر دهید." : "هنوز برندی برای نمایش وجود ندارد."}
                    </span>
                </div>
            `);

            return;
        }

        let html = "";
        brands.forEach(function (brand) {
            const selectedCount = getSelectedCountByBrand(brand.id);
            const active = state.activeBrandId === brand.id;
            const logo = brand.logo ? `
                <img src="/Storage/Brands/${brand.id}/${escapeAttribute(brand.logo)}" alt="${escapeAttribute(brand.name)}" 
                    onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">

                <span class="brand-logo-placeholder" style="display:none">
                    <i class="bx bx-purchase-tag"></i>
                </span>
            ` : `
                <span class="brand-logo-placeholder">
                    <i class="bx bx-purchase-tag"></i>
                </span>
            `;

            html += `
                <button type="button" class="sale-brand-item ${active ? "active" : ""}" data-brand-id="${brand.id}">
                    <span class="sale-brand-logo">
                        ${logo}
                    </span>
                    <span class="sale-brand-info">
                        <span class="sale-brand-name">
                            ${escapeHtml(brand.name)}
                        </span>
                        ${brand.latinName ? `<span class="sale-brand-latin">${escapeHtml(brand.latinName)}</span>` : ''}
                    </span>
                    ${selectedCount > 0 ? `<span class="sale-brand-badge">${formatNumber(selectedCount)}</span>` : ''}
                    <i class="bx bx-chevron-left sale-brand-arrow"></i>
                </button>
            `;
        });

        $brandsList.html(html);
        updateBrandSearchClear();
    }

    async function selectBrand(brandId) {
        brandId = parseInt(brandId, 10);
        if (!brandId || !state.brands[brandId]) {
            return;
        }

        state.activeBrandId = brandId;
        state.productSearch = "";

        if ($productSearch.length) {
            $productSearch.val("");
            updateProductSearchClear();
        }

        renderBrands();
        updateActiveBrandHeader();
        updateProductSelectionInfo();
        await loadProducts(true);
    }

    function activateFirstBrand() {
        const brands = Object.values(state.brands);
        if (!brands.length) {
            return;
        }

        selectBrand(brands[0].id);
    }

    async function loadProducts(reset) {
        if (state.loadingProducts) {
            return;
        }

        if (!state.activeBrandId) {
            return;
        }

        if (!reset && !state.productHasMore) {
            return;
        }

        state.loadingProducts = true;

        if (reset) {
            state.productPage = 1;
            state.productHasMore = false;
            state.products = [];
            renderProducts();
        }

        showProductsLoading(true);

        try {
            const response = await postAjax(config.productsUrl, {
                brand_id: state.activeBrandId,
                page: state.productPage,
                limit: config.productsPerPage,
                search: state.productSearch
            });

            if (!response || response.success !== true) {
                showError(response?.message || 'دریافت محصولات انجام نشد.');
                return;
            }

            const products = Array.isArray(response.products) ? response.products : (Array.isArray(response.data) ? response.data : []);
            const normalized = products.map(normalizeProduct);

            if (reset) {
                state.products = normalized;
            } else {
                state.products = state.products.concat(normalized);
            }

            const pagination = response.pagination || {};

            if (typeof pagination.has_more !== 'undefined') {
                state.productHasMore = pagination.has_more === true;
            } else if (typeof pagination.current_page !== 'undefined' && typeof pagination.last_page !== 'undefined') {
                state.productHasMore = parseInt(pagination.current_page, 10) < parseInt(pagination.last_page, 10);
            } else {
                state.productHasMore = normalized.length >= config.productsPerPage;
            }

            state.productPage++;
            renderProducts();
            updateSummary();
            updateActiveBrandHeader();
            updateProductSelectionInfo();
        } catch (error) {
            console.error('loadProducts:', error);
            showError('خطا در دریافت محصولات');
        } finally {
            state.loadingProducts = false;
            showProductsLoading(false);
        }
    }

    function normalizeProduct(product) {
        return {
            id: parseInt(product.id, 10),
            brandId: parseInt(product.brand_id || state.activeBrandId || 0, 10),
            name: product.name || product.title || '',
            code: product.product_code || product.code || '',
            defaultPrice: parseInt(product.default_price ?? product.sale_price ?? 0, 10),
            categoryName: product.category_name || '',
            groupName: product.group_name || '',
            gradeName: product.grade_name || '',
            qualityName: product.quality_name || '',
            unitName: product.unit_name || '',
            unitSymbol: product.unit_symbol || ''
        };
    }

    function renderProducts() {
        if (!$productsList.length) {
            return;
        }

        updateVisibleProductCount();
        if (!state.products.length) {
            $productsList.html(`
                <div class="permission-empty">
                    <div class="permission-empty-icon">
                        <i class="bx bx-package"></i>
                    </div>
                    <strong>محصولی یافت نشد</strong>
                    <span>${state.productSearch ? "عبارت جستجو را تغییر دهید." : "محصولی برای این برند وجود ندارد."}</span>
                </div>
            `);
            updateSelectAllButton();
            return;
        }

        const rows = state.products.map(createProductRowHtml).join("");
        $productsList.html(`
            <table class="product-table">
                <thead>
                    <tr>
                        <th></th>
                        <th>
                            محصول
                        </th>
                        <th class="product-col-code">
                            کد کالا
                        </th>
                        <th class="product-col-category">
                            دسته‌بندی
                        </th>
                        <th class="product-col-group">
                            گروه
                        </th>
                        <th class="product-col-grade">
                            گرید
                        </th>
                        <th class="product-col-quality">
                            سطح کیفی
                        </th>
                        <th class="product-col-unit">
                            واحد
                        </th>
                        <th class="product-col-price">
                            قیمت فروش
                        </th>
                    </tr>
                </thead>
                <tbody>
                    ${rows}
                </tbody>
            </table>
        `);

        updateSelectAllButton();
    }

    function createProductRowHtml(product) {
        const selected = !!state.selected[product.id];
        return `
        <tr class="product-row ${selected ? "selected" : ""}" 
            data-product-id="${product.id}"
            data-brand-id="${product.brandId}"
            data-product-name="${escapeAttribute(product.name)}"
            data-product-code="${escapeAttribute(product.code)}"
            data-default-price="${product.defaultPrice}"
            data-category-name="${escapeAttribute(product.categoryName)}"
            data-group-name="${escapeAttribute(product.groupName)}"
            data-grade-name="${escapeAttribute(product.gradeName)}"
            data-quality-name="${escapeAttribute(product.qualityName)}"
            data-unit-name="${escapeAttribute(product.unitName)}"
            data-unit-symbol="${escapeAttribute(product.unitSymbol)}">
            <td class="product-check-cell">
                <span class="product-check">
                    <i class="bx bx-check"></i>
                </span>
            </td>
            <td class="product-name-cell">
                <span class="product-name-main">${escapeHtml(product.name)}</span>
            </td>
            <td class="product-meta-cell product-code-cell">
                ${product.code ? escapeHtml(product.code) : `<span class="empty">—</span>`}
            </td>
            <td class="product-meta-cell">
                ${product.categoryName ? escapeHtml(product.categoryName) : `<span class="empty">—</span>`}
            </td>
            <td class="product-meta-cell">
                ${product.groupName ? escapeHtml(product.groupName) : `<span class="empty">—</span>`}
            </td>
            <td class="product-meta-cell">
                ${product.gradeName ? escapeHtml(product.gradeName) : `<span class="empty">—</span>`}
            </td>
            <td class="product-meta-cell">
                ${product.qualityName ? escapeHtml(product.qualityName) : `<span class="empty">—</span>`}
            </td>
            <td class="product-meta-cell">
                ${product.unitSymbol || product.unitName ? 
                    `<span class="product-unit">${escapeHtml(product.unitSymbol || product.unitName)} </span>`
                    : `<span class="empty">—</span>`
                }
            </td>
            <td class="product-price-cell">
                <span class="product-price-number">${formatPrice(product.defaultPrice)}</span>
                <span class="product-price-currency">ریال</span>
            </td>
        </tr>
    `;
    }

    function productFromRow($row) {
        if (!$row.length) {
            return null;
        }

        const id = parseInt($row.attr('data-product-id'), 10);
        if (!id) {
            return null;
        }

        return {
            id: id,
            brandId: parseInt($row.attr('data-brand-id'), 10),
            name: $row.attr('data-product-name') || '',
            code: $row.attr('data-product-code') || '',
            defaultPrice: parseInt($row.attr('data-default-price') || 0, 10),
            categoryName: $row.attr('data-category-name') || '',
            groupName: $row.attr('data-group-name') || '',
            gradeName: $row.attr('data-grade-name') || '',
            qualityName: $row.attr('data-quality-name') || '',
            unitName: $row.attr('data-unit-name') || '',
            unitSymbol: $row.attr('data-unit-symbol') || ''
        };
    }

    function createSelectedProduct(product) {
        return {
            productId: parseInt(product.id, 10),
            brandId: parseInt(product.brandId, 10),
            brandName: getBrandName(product.brandId),
            name: product.name,
            code: product.code,
            defaultPrice: product.defaultPrice,
            categoryName: product.categoryName,
            groupName: product.groupName,
            gradeName: product.gradeName,
            qualityName: product.qualityName,
            unitName: product.unitName,
            unitSymbol: product.unitSymbol,
            price: null
        };
    }

    function toggleProduct(product) {
        const productId = parseInt(product.id, 10);
        if (!productId) {
            return;
        }

        if (state.selected[productId]) {
            delete state.selected[productId];
        } else {
            state.selected[productId] = createSelectedProduct(product);
        }

        renderProducts();
        renderSelectedProducts();
        renderBrands();
        updateSummary();
        updateHiddenInput();
    }

    function toggleSelectAllCurrentProducts() {
        if (!state.products.length) {
            return;
        }

        const allSelected = state.products.every(function (product) {
            return !!state.selected[product.id];
        });

        if (allSelected) {
            state.products.forEach(function (product) {
                delete state.selected[product.id];
            });
        } else {
            state.products.forEach(function (product) {
                if (state.selected[product.id]) {
                    return;
                }

                state.selected[product.id] = createSelectedProduct(product);
            });
        }

        renderProducts();
        renderSelectedProducts();
        renderBrands();
        updateSummary();
        updateHiddenInput();
    }

    async function loadExistingPermissions() {
        if (state.loadingExisting || !config.teamId) {
            return;
        }

        state.loadingExisting = true;
        try {
            const response = await postAjax(config.existingUrl, {team_id: config.teamId});
            if (!response || response.success !== true) {
                showError(response?.message || 'دریافت محصولات مجاز تیم انجام نشد.');
                return;
            }

            const permissions = Array.isArray(response.permissions)
                ? response.permissions : (Array.isArray(response.data) ? response.data : []);

            permissions.forEach(function (item) {
                    const productId = parseInt(item.product_id, 10);
                    if (!productId) {
                        return;
                    }

                    const brandId = parseInt(item.brand_id || 0, 10);
                    let price = null;
                    if (item.price !== null && item.price !== "" && typeof item.price !== 'undefined') {
                        const numericPrice = parseInt(toEnglishDigits(String(item.price))
                            .replace(/,/g, "")
                            .replace(/[^\d]/g, ""), 10
                        );

                        if (!isNaN(numericPrice) && numericPrice > 0) {
                            price = numericPrice;
                        }
                    }

                    state.selected[productId] = {
                        productId: productId,
                        brandId: brandId,
                        brandName: item.brand_name || getBrandName(brandId),
                        name: item.name || item.title || '',
                        code: item.code || item.product_code || '',
                        defaultPrice: parseInt(item.default_price || item.sale_price || 0, 10),
                        categoryName: item.category_name || '',
                        groupName: item.group_name || '',
                        gradeName: item.grade_name || '',
                        qualityName: item.quality_name || '',
                        unitName: item.unit_name || '',
                        unitSymbol: item.unit_symbol || '',
                        price: price
                    };
                }
            );

            updateHiddenInput();
            updateSummary();
        } catch (error) {
            console.error('loadExistingPermissions:', error);
            showError('خطا در دریافت دسترسی‌های قبلی');
        } finally {
            state.loadingExisting = false;
        }
    }

    function getFilteredSelectedProducts() {
        const products = Object.values(state.selected);
        if (!state.selectedSearch) {
            return products;
        }

        const search = state.selectedSearch;
        return products.filter(function (product) {
            const text = [
                product.name,
                product.code,
                product.brandName,
                product.categoryName,
                product.groupName,
                product.gradeName,
                product.qualityName,
                product.unitName,
                product.unitSymbol
            ].filter(Boolean).join(' ').toLowerCase();

            return text.includes(
                search
            );
        });
    }

    function renderSelectedProducts() {
        if (!$selectedProducts.length) {
            return;
        }

        const products = getFilteredSelectedProducts();
        const totalSelected = Object.keys(state.selected).length;
        if (!totalSelected) {
            $selectedProducts.html(`
                <div class="permission-empty">
                    <div class="permission-empty-icon">
                        <i class="bx bx-check-shield"></i>
                    </div>
                    <strong>هنوز محصولی انتخاب نشده</strong>
                    <span>محصولات مورد نظر را از لیست محصولات انتخاب کنید.</span>
                </div>
            `);

            return;
        }

        if (!products.length) {
            $selectedProducts.html(`
                <div class="permission-empty">
                    <div class="permission-empty-icon">
                        <i class="bx bx-search-alt"></i>
                    </div>
                    <strong>محصولی پیدا نشد</strong>
                    <span>عبارت جستجو را تغییر دهید.</span>
                </div>
            `);

            return;
        }

        const grouped = {};
        products.forEach(
            function (product) {
                const brandId = product.brandId || 0;
                if (!grouped[brandId]) {
                    grouped[brandId] = [];
                }

                grouped[brandId].push(product);
            }
        );


        let html = "";
        Object.keys(grouped).forEach(function (brandId) {
            const items = grouped[brandId];
            const brandName = productBrandName(brandId, items[0]);
            html += `
            <div class="selected-brand-group">
                <div class="selected-brand-header">
                    <span class="selected-brand-header-icon">
                        <i class="bx bx-purchase-tag"></i>
                    </span>
                    <div class="selected-brand-title">
                        <div>
                            <strong>${escapeHtml(brandName)}</strong>
                            <small>
                                ${formatNumber(items.length)}
                                محصول
                            </small>
                        </div>
                    </div>
                </div>
                <table class="selected-product-table">
                    <thead>
                        <tr>
                            <th></th>
                            <th>محصول</th>
                            <th>قیمت فروش تیم</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${items.map(createSelectedProductHtml).join("")}
                    </tbody>
                </table>
            </div>
        `;
        });

        $selectedProducts.html(html);
    }

    function createSelectedProductHtml(product) {
        const customPrice = product.price !== null && product.price !== "" && typeof product.price !== "undefined";
        const priceBelowDefault = isPriceBelowDefault(product);

        return `
        <tr class="selected-product ${customPrice ? "has-custom-price" : ""} ${priceBelowDefault ? "price-below-default" : ""}"
            data-product-id="${product.productId}">
            <td>
                <button type="button" class="remove-product selected-remove-btn" data-product-id="${product.productId}" title="حذف محصول">
                    <i class="bx bx-trash"></i>
                </button>
            </td>
            <td>
                <div>
                    <span class="selected-product-name">
                        ${escapeHtml(product.name)}
                    </span>
                    ${product.code ? `<span class="selected-product-code">${escapeHtml(product.code)}</span>` : ''}
                </div>
            </td>
            <td>
                <div class="selected-override-wrapper">
                    <input type="text" class="form-control override-price" data-product-id="${product.productId}" 
                        value="${customPrice ? formatPrice(product.price) : ""}" placeholder="${formatPrice(product.defaultPrice)}"
                        inputmode="numeric" autocomplete="off">
                    <span class="selected-override-currency">ریال</span>
                    <span class="selected-product-default-price">
                        قیمت اصلی:
                        ${formatPrice(product.defaultPrice)}
                        <small>ریال</small>
                    </span>
                    <span class="override-price-warning" style="${priceBelowDefault ? '' : 'display:none;'}">
                        <i class="bx bx-error-circle"></i>
                        قیمت پایین تر از قیمت مصوب است
                    </span>
                </div>
            </td>
        </tr>
    `;
    }

    function removeProduct(productId) {
        delete state.selected[productId];
        renderProducts();
        renderSelectedProducts();
        renderBrands();
        updateSummary();
        updateHiddenInput();
    }

    function deleteAllSelectedProducts() {
        const count = Object.keys(state.selected).length;
        if (!count) {
            return;
        }

        Swal.fire({
            title: 'حذف همه محصولات؟',
            html: `
                <div style="line-height:2">
                    <div>
                        <strong>${formatNumber(count)}</strong>محصول انتخاب شده است.
                    </div>
                    <div>همه محصولات از دسترسی فروش این تیم حذف خواهند شد.</div>
                </div>
            `,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'بله، حذف همه',
            cancelButtonText: 'انصراف',
            reverseButtons: true,
            focusCancel: true
        }).then(function (result) {
            if (!result.isConfirmed) {
                return;
            }

            state.selected = {};
            renderProducts();
            renderSelectedProducts();
            renderBrands();
            updateSummary();
            updateHiddenInput();
        });
    }

    function updateSummary() {
        const products = Object.values(state.selected);
        const productCount = products.length;
        const brandIds = new Set();
        let customPriceCount = 0;

        products.forEach(function (product) {
            if (product.brandId) {
                brandIds.add(parseInt(product.brandId, 10));
            }

            if (product.price !== null && product.price !== "" && typeof product.price !== 'undefined' && parseInt(product.price, 10) > 0) {
                customPriceCount++;
            }
        });

        setText($selectedCount, formatNumber(productCount));
        setText($summaryProducts, formatNumber(productCount));
        setText($summaryBrands, formatNumber(brandIds.size));
        setText($summaryOverrides, formatNumber(customPriceCount));
        setText($footerSelectedCount, formatNumber(productCount));
        updateActiveBrandHeader();
    }

    function updateActiveBrandHeader() {
        if (!state.activeBrandId) {
            return;
        }

        const brand = state.brands[state.activeBrandId];
        if (!brand) {
            return;
        }

        const count = getSelectedCountByBrand(state.activeBrandId);
        if ($activeBrandTitle.length) {
            setText($activeBrandTitle, brand.name);
        }

        if ($activeBrandCount.length) {
            setText($activeBrandCount, `${formatNumber(count)} محصول انتخاب شده`);
        }
    }

    function updateProductSelectionInfo() {
        if (!$productSelectionInfo.length) {
            return;
        }

        if (!state.activeBrandId) {
            setText($productSelectionInfo, "یک برند را انتخاب کنید");
            return;
        }

        const brand = state.brands[state.activeBrandId];
        if (!brand) {
            return;
        }

        const count = getSelectedCountByBrand(state.activeBrandId);
        const total = state.products.length;
        setText($productSelectionInfo, `${brand.name} — ${formatNumber(count)} محصول انتخاب شده`);
        if ($visibleProductCount.length) {
            setText($visibleProductCount, formatNumber(total));
        }
    }

    function updateSelectAllButton() {
        if (!$selectAllProducts.length) {
            return;
        }

        if (!state.products.length) {
            $selectAllProducts.prop('disabled', true)
                .removeClass('is-unselect')
                .html(`<i class="bx bx-check-double"></i>انتخاب همه`);

            return;
        }

        $selectAllProducts.prop('disabled', false);
        const allSelected = state.products.every(function (product) {
            return !!state.selected[
                product.id
            ];
        });

        if (allSelected) {
            $selectAllProducts.addClass('is-unselect').html(`<i class="bx bx-x"></i>لغو انتخاب همه`);
        } else {
            $selectAllProducts.removeClass('is-unselect').html(`<i class="bx bx-check-double"></i>انتخاب همه`);
        }
    }

    function updateVisibleProductCount() {
        setText($visibleProductCount, formatNumber(state.products.length));
    }

    function getSelectedCountByBrand(brandId) {
        return Object.values(state.selected).filter(function (product) {
            return (parseInt(product.brandId, 10) === parseInt(brandId, 10));
        }).length;
    }

    function getBrandName(brandId) {
        const brand = state.brands[brandId];
        return brand ? brand.name : "";
    }

    function productBrandName(brandId, product) {
        const brand = state.brands[brandId];
        if (brand) {
            return brand.name;
        }

        return product?.brandName || 'برند نامشخص';
    }

    function ensureHiddenInput() {
        if ($("#salePermissionsInput").length) {
            return;
        }

        $("#mainForm").append(`<input type="hidden" id="salePermissionsInput" name="sale_permissions" value="[]">`);
    }

    function updateHiddenInput() {
        ensureHiddenInput();
        const data = Object.values(state.selected).map(function (product) {
            let price = null;
            if (product.price !== null && product.price !== "" && typeof product.price !== 'undefined') {
                const numericPrice = parseInt(product.price, 10);
                if (!isNaN(numericPrice) && numericPrice > 0) {
                    price = numericPrice;
                }
            }

            return {
                product_id: parseInt(product.productId, 10),
                price: price
            };
        });

        $("#salePermissionsInput").val(JSON.stringify(data));
    }

    function postAjax(url, data) {
        return $.ajax({
            url: url,
            type: "POST",
            data: data,
            dataType: "json"
        });
    }

    function showProductsLoading(show) {
        if (!$productsLoading.length) {
            return;
        }

        if (show) {
            $productsLoading.show();
        } else {
            $productsLoading.hide();
        }
    }

    function updateBrandSearchClear() {

        if (!$brandSearchClear.length) {
            return;
        }

        if (state.brandSearch) {
            $brandSearchClear.show();
        } else {
            $brandSearchClear.hide();
        }
    }

    function updateProductSearchClear() {
        if (!$productSearchClear.length) {
            return;
        }

        if (state.productSearch) {
            $productSearchClear.show();
        } else {
            $productSearchClear.hide();
        }
    }

    function updateSelectedSearchClear() {
        if (!$selectedSearchClear.length) {
            return;
        }

        if (state.selectedSearch) {
            $selectedSearchClear.show();
        } else {
            $selectedSearchClear.hide();
        }
    }

    function setText($element, value) {
        if ($element && $element.length) {
            $element.text(value);
        }
    }

    function formatPrice(value) {
        if (value === null || typeof value === "undefined" || value === "") {
            return "";
        }

        let number = toEnglishDigits(String(value))
            .replace(/,/g, "")
            .replace(/\D/g, "");


        if (!number) {
            return "";
        }

        return number.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function formatNumber(value) {
        const number = parseInt(value || 0, 10);
        if (isNaN(number)) {
            return "۰";
        }

        return number.toLocaleString("fa-IR");
    }

    function toEnglishDigits(value) {
        return String(value).replace(/[۰-۹]/g, function (digit) {
            return String("۰۱۲۳۴۵۶۷۸۹".indexOf(digit));
        }).replace(/[٠-٩]/g, function (digit) {
            return String("٠١٢٣٤٥٦٧٨٩".indexOf(digit));
        });
    }

    function escapeHtml(value) {
        if (value === null || typeof value === "undefined") {
            return "";
        }

        return String(value).replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function escapeAttribute(value) {
        return escapeHtml(value);
    }

    function showError(message) {
        Swal.fire({
            icon: "error",
            title: "خطا",
            text: message,
            confirmButtonText: "باشه",
            customClass: {
                popup: "rtl"
            }
        });
    }

    window.salePermissionState = state;
    window.salePermissionConfig = config;
})(jQuery);