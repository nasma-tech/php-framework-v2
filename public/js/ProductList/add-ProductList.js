$(function () {
    let brandPercentage = 0;

    function numberFormat(number) {
        return Number(number).toLocaleString('en-US');
    }

    $('.addFormAjax').on('click', function () {
        let formId = 'mainForm';
        let url = 'add';
        let resultBack = 'addSuccess';
        let form = $("#" + formId);
        let formData = new FormData(form[0]);

        if ($('.row').find('.tiny') !== undefined) {
            $('.row').find('.tiny').each(function () {
                formData.append($(this).attr('name'), tinyEditorGetValue($(this).attr('id')));
            });
        }

        $("#" + formId).find(':input').each(function () {
            if ($(this).prop('required')) {
                let value = $(this).val();

                if ($(this).is('select')) {
                    if (!value || value === '') {
                        $(this).addClass('is-invalid');
                        $(this).parent('div').addClass('has-error');
                    } else {
                        $(this).removeClass('is-invalid');
                        $(this).addClass('is-valid');
                        $(this).parent('div').removeClass('has-error');
                    }
                } else {
                    if (!value || value.trim() === '') {
                        $(this).addClass('is-invalid');
                        $(this).parent('div').addClass('has-error');
                    } else {
                        $(this).removeClass('is-invalid');
                        $(this).addClass('is-valid');
                        $(this).parent('div').removeClass('has-error');
                    }
                }
            }
        });

        $(form).each(function () {
            if ($(this).find(':input').parent().hasClass('has-error') || $(this).find(':input').hasClass('is-invalid')) {
                swal.fire({
                    icon: 'warning',
                    title: 'توجه !',
                    text: 'لطفا موارد را با دقت پر کنید',
                    timer: 3000,
                    confirmButtonText: 'بستن'
                });
            } else {
                $('.addFormAjax').hide();

                $.ajax({
                    url: url,
                    type: 'POST',
                    processData: false,
                    contentType: false,
                    cache: false,
                    data: formData,
                    success: result => {
                        if (result === resultBack) {
                            successMessage();
                            buttonLoadingOff('.addFormAjax', 'ثبت اطلاعات');
                        } else if (result === 'duplicate-id') {
                            errorMessage('این کد محصول از قبل وجود دارد.');
                            $('.addFormAjax').show();
                        } else if (result === 'duplicate-type') {
                            errorMessage('محصولی با مشخصات مشابه از قبل وجود دارد.');
                            $('.addFormAjax').show();
                        } else {
                            errorMessage('مشکلی در افزودن محصول رخ داده است.');
                            $('.addFormAjax').show();
                        }
                    }
                });
            }
        });
    });

    let lastManualId = '';
    $('#group_id').on('change', function () {
        let id = $(this).val();
        const categories = $('#category_id');
        const previousCategoryId = categories.val();
        categories.empty();
        $.ajax({
            url: '/Products/getGroupCategories',
            type: 'POST',
            data: {id},
            dataType: 'json',
        }).then(function (result) {
            $.each(result, function (index, item) {
                categories.append(
                    '<option value="' + item.id + '">' + item.title + '</option>'
                );
            });
            if (categories.find('option[value="' + previousCategoryId + '"]').length) {
                categories.val(previousCategoryId).trigger('change');
            }
        });
    }).trigger('change');

    function getSelectedKey(name) {
        return $('#' + name + ' option:selected')?.text()?.trim()?.replace(/\s/g, '')?.replace(/[^a-zA-Z0-9]/g, '')?.toUpperCase()
    }

    async function generateProductKey() {
        const isManual = $('#manual_product_id').is(':checked');
        if (isManual) {
            return;
        }
        const brandName = $('#brand_id')?.find('option:selected')?.data('brand')?.trim();
        if (brandName) {
            const symbolName = $('#unit_id')?.find('option:selected')?.data('symbol')?.trim();
            const gradeName = getSelectedKey('grade_id');
            const qualityName = getSelectedKey('quality_id');
            const unitAmount = $('#unit_amount');
            let productKey = (brandName) ? brandName : '';
            productKey += (gradeName) ? '-' + gradeName : '';
            productKey += (qualityName) ? '-' + qualityName : '';
            productKey += (symbolName) ? '-' + symbolName : '';
            if (unitAmount.is(':visible') && unitAmount.val() !== '') {
                productKey += 'x' + unitAmount.val();
            }
            $('#product_id').val(productKey);
        }
    }

    $('#title').on('input', generateProductKey);
    $('#group_id, #category_id, #grade_id, #quality_id, #unit_id, #unit_amount').on('change', generateProductKey);

    function setProductIdMode() {
        const isManual = $('#manual_product_id').is(':checked');
        const $productId = $('#product_id');
        const $help = $('#product_id_help');
        if (isManual) {
            $productId.prop('readonly', false);
            if (!window.editProduct) {
                $productId.val('');
            }
            if (lastManualId !== '') {
                $productId.val(lastManualId);
            }
            $help.removeClass('text-muted')
                .addClass('text-warning')
                .text('کد محصول را به صورت دستی وارد کنید.');
            $productId.focus();
        } else {
            lastManualId = $productId.val();
            $productId.prop('readonly', true);
            $help.removeClass('text-warning')
                .addClass('text-muted')
                .text('کد محصول به صورت خودکار ایجاد میشود.');
            generateProductKey();
        }
    }

    $('#manual_product_id').on('change', function () {
        setProductIdMode();
    });

    function normalizePersianNumbers(value) {
        return value
            .replace(/[۰-۹]/g, function (digit) {
                return String('۰۱۲۳۴۵۶۷۸۹'.indexOf(digit));
            })
            .replace(/[٠-٩]/g, function (digit) {
                return String('٠١٢٣٤٥٦٧٨٩'.indexOf(digit));
            });
    }

    function formatPrice(value) {
        value = normalizePersianNumbers(value);
        value = value.replace(/\D/g, '');
        return value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    $('.price-input').on('input', function () {
        this.value = formatPrice(this.value);
    }).trigger('input');

    const imageInput = document.getElementById('product_images');
    const chooseImagesBtn = document.getElementById('chooseImagesBtn');
    const imageDropZone = document.getElementById('imageDropZone');
    const imagePreviewContainer = document.getElementById('imagePreviewContainer');

    chooseImagesBtn.addEventListener('click', function () {
        imageInput.click();
    });

    imageDropZone.addEventListener('click', function () {
        imageInput.click();
    });

    imageInput.addEventListener('change', function () {
        renderImages();
    });

    imageDropZone.addEventListener('dragover', function (e) {
        e.preventDefault();
        imageDropZone.classList.add('bg-light');
    });

    imageDropZone.addEventListener('dragleave', function (e) {
        e.preventDefault();
        imageDropZone.classList.remove('bg-light');
    });

    imageDropZone.addEventListener('drop', function (e) {
        e.preventDefault();
        imageDropZone.classList.remove('bg-light');
        const files = e.dataTransfer.files;
        if (!files.length) {
            return;
        }
        const dataTransfer = new DataTransfer();
        Array.from(imageInput.files).forEach(function (file) {
            dataTransfer.items.add(file);
        });
        Array.from(files).forEach(function (file) {
            if (!file.type.startsWith('image/')) {
                return;
            }
            const exists = Array.from(dataTransfer.files).some(function (existingFile) {
                return (
                    existingFile.name === file.name &&
                    existingFile.size === file.size &&
                    existingFile.lastModified === file.lastModified
                );
            });
            if (!exists) {
                dataTransfer.items.add(file);
            }
        });
        imageInput.files = dataTransfer.files;
        renderImages();
    });

    function renderImages() {
        imagePreviewContainer.innerHTML = '';
        const files = Array.from(imageInput.files);
        files.forEach(function (file, index) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const html = `
                <div class="image-item border rounded p-3 mb-3" data-index="${index}">
                    <div class="row">
                        <div class="col-md-3 col-lg-2">
                            <div class="border rounded overflow-hidden" style="height:180px;background:#f8f9fa">
                                <img src="${e.target.result}" style="width:100%;height:100%;object-fit:cover">
                            </div>
                        </div>
                        <div class="col-md-8 col-lg-9 mt-3 mt-md-0">
                            <div>
                                <label for="image-title-${index}">عنوان تصویر</label>
                                <input type="text" class="form-control image-title" name="image_titles[${index}]"
                                    id="image-title-${index}" placeholder="مثلاً تصویر بسته‌بندی محصول" required>
                            </div>
                            <div class="mt-3">
                                <label for="image-description-${index}">توضیحات تصویر</label>
                                <textarea class="form-control image-description" name="image_descriptions[${index}]" id="image-description-${index}"
                                    rows="4" placeholder="توضیحات مربوط به این تصویر..." required></textarea>
                            </div>
                        </div>
                        <div class="col-md-1 mt-3 mt-md-0 text-left">
                            <button type="button" class="btn btn-outline-danger remove-image" data-index="${index}" title="حذف تصویر">
                                <i class="bx bx-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
                imagePreviewContainer.insertAdjacentHTML('beforeend', html);
            };
            reader.readAsDataURL(file);
        });
    }

    $(document).on('click', '.remove-image', function () {
        const index = parseInt($(this).data('index'));
        const dataTransfer = new DataTransfer();
        Array.from(imageInput.files).forEach(function (file, fileIndex) {
            if (fileIndex !== index) {
                dataTransfer.items.add(file);
            }
        });
        imageInput.files = dataTransfer.files;
        renderImages();
    });

    $('#sale_price').on('input change', function () {
        const brand = $(this).data('brand') || 0;
        let percentage = brandPercentage;
        console.log($('#brand_id').val());
        if ($('#brand_id').val() == brand) {
            percentage = Number($(this).data('percentage')) || brandPercentage;
        }
        const price = Number($(this).val().replace(/,/g, '')) || 0;
        const customerPrice = Math.round(price + ((price * percentage) / 100));
        $('#customer_price').val(numberFormat(customerPrice));
        if (percentage > 0) {
            $('#percentage').html('<strong style="color:red">' + percentage + '</strong> درصد به صورت خودکار اضافه میشود')
        } else {
            $('#percentage').html('به صورت خودکار محاسبه میشود')
        }
    });

    $('#brand_id').on('change', function () {
        const brandId = $(this).val();
        $('#brand_latin_name').val($(this).find('option:selected').data('value'));
        $('#title').removeAttr('readonly');
        if (!window.editProduct) {
            $('#product_id').val('')
            generateProductKey();
        }
        brandPercentage = 0;
        $.ajax({
            url: '/Products/getBrandPercentage',
            type: 'POST',
            data: {brandId},
            success: result => {
                brandPercentage = parseInt(result);
                $('#sale_price').trigger('change');
            }
        });
    });

    $('#brand_latin_name').val($(this).find('option:selected').data('value'));

    $('#brand_id').select2({
        templateResult: function (brand) {
            if (!brand.id) {
                return brand.text;
            }
            const logo = $(brand.element).data('logo');
            return $(`
            <div class="brand-select-option">
                <div class="brand-select-logo">
                    ${
                logo
                    ? `<img src="${logo}" alt="">`
                    : '<i class="bx bx-image"></i>'
            }
                </div>
                <span>${brand.text}</span>
            </div>
        `);
        },
        templateSelection: function (brand) {
            if (!brand.id) {
                return brand.text;
            }
            const logo = $(brand.element).data('logo');
            return $(`
            <div class="brand-select-selection">
                <div class="brand-select-logo">
                    ${
                logo
                    ? `<img src="${logo}" alt="">`
                    : '<i class="bx bx-image"></i>'
            }
                </div>
                <span>${brand.text}</span>
            </div>
        `);
        },
        escapeMarkup: function (markup) {
            return markup;
        },
        width: '100%'
    });

    const $unitSelect = $('#unit_id');
    const $unitSelectWrapper = $('#unitSelectWrapper');
    const $unitAmountWrapper = $('#unitAmountWrapper');
    const $unitAmount = $('#unit_amount');
    const $subUnitName = $('#sub_unit_name');

    function updateUnitContent() {
        const $selected = $unitSelect.find('option:selected');
        const hasContent = String($selected.data('has-content')) === '1';
        const contentUnitName = $selected.text() || 'واحد';
        if (hasContent) {
            $unitSelectWrapper.removeClass('col-12').addClass('col-md-6');
            $unitAmountWrapper.removeClass('col-12').addClass('col-md-6').show();
            $subUnitName.text(contentUnitName);
            $unitAmount.prop('required', true);
        } else {
            $unitSelectWrapper.removeClass('col-md-6').addClass('col-12');
            $unitAmountWrapper.hide().removeClass('col-md-6').addClass('col-12');
            $unitAmount.prop('required', false).val('');
            $subUnitName.text('واحد');
        }
        generateProductKey();
    }

    $unitSelect.on('change', updateUnitContent);
    updateUnitContent();
    $('#sale_price').trigger('change');
});