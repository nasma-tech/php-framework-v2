
$(function () {

    const warehouseInquiryElement = (data) => {

        let tbody = ``;
        let counter = 0;

        $.each(data.data, function (product_id, value) {

            tbody += `
                <tr>
                    <td class="border">${++counter}</td>

                    <td class="border">
                        ${value.productData.serial_number} - ${value.productData.label}
                    </td>

                    <td class="border">
                        <div class="input-group">
                            <input class="form-control"
                                   type="text"
                                   readonly
                                   value="${value.summary.total_reserved}">
                            <div class="input-group-append">
                                <span class="input-group-text">
                                    ${value.productData.measurement_unit.label}
                                </span>
                            </div>
                        </div>
                    </td>

                    <td class="border">
                        <div class="input-group">
                            <input class="form-control"
                                   type="text"
                                   id="warehouseInquiryItem_${product_id}"
                                   readonly
                                   value="${value.summary.total_remaining}">
                            <div class="input-group-append">
                                <span class="input-group-text">
                                    ${value.productData.measurement_unit.label}
                                </span>
                            </div>
                        </div>
                    </td>

                    <td class="border">
                        <div class="input-group">
                            <input class="form-control"
                                   type="text"
                                   id="warehouseInquiryRemaining_${product_id}"
                                   readonly
                                   value="${value.summary.total_remaining}">
                            <div class="input-group-append">
                                <span class="input-group-text">
                                    ${value.productData.measurement_unit.label}
                                </span>
                            </div>
                        </div>
                    </td>
                </tr>
            `;
        });

        return `
            <div class="divider">
                <div class="divider-text">موجودی انبار</div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-striped text-center">
                    <thead class="thead-dark">
                        <tr>
                            <th class="border">#</th>
                            <th class="border">نام محصول</th>
                            <th class="border">رزرو شده</th>
                            <th class="border">قابل تخصیص</th>
                            <th class="border">مانده</th>
                        </tr>
                    </thead>

                    <tbody>${tbody}</tbody>
                </table>
            </div>
        `;
    };

    // حذف جداکننده اعداد
    $.fn.removeSeparator = function () {
        return Number(String(this.val() || 0).replaceAll(',', '')) || 0;
    };

    // فرمت اعداد
    const numberFormat = (number) => {
        return Number(number).toLocaleString('en-US');
    };

    // رویداد تغییر مقدار تخصیص
    $(document).on('input', '.allocationEnteredAmountInput', function () {
        updateAllocation();
    });

    // دریافت موجودی انبار
    $("#allocationWarehouseId").on('change', async function () {

        let warehouseId = $(this).val();

        if (!warehouseId) {
            $("#allocationInquiryElement").hide().empty();

            $(".allocationEnteredAmountInput")
                .val("")
                .prop('disabled', true);

            return;
        }

        try {

            const result = await $.ajax({
                url: "/ProformaInvoice/inventoryInquiryByInvoiceForm",
                method: "POST",
                dataType: "json",
                data: {
                    csrfToken: csrfToken(),
                    warehouse_id: warehouseId,
                    invoice_id: $("#invoiceId").val()
                }
            });

            if (result) {

                $("#allocationInquiryElement")
                    .show()
                    .html(warehouseInquiryElement(result));

                $(".allocationEnteredAmountInput")
                    .val("")
                    .prop('disabled', false);

                updateAllocation();
            }

        } catch (error) {

            customAlert('error', 'خطا در دریافت موجودی انبار');

        }

    });

    // ماشین حساب تخصیص
    function updateAllocation() {

        let allocationData = {};
        let hasError = false;

        $.each($(".allocationEnteredAmountInput"), function () {

            let id = $(this).data('id');
            let productId = $(this).data('product_id');

            let enteredAmount = $(this).removeSeparator();

            let maxAmount = Number(
                String($(this).data('max') || 0).replaceAll(',', '')
            ) || 0;

            let reservedAmount = $(`#allocationReservedAmountInput_${id}`)
                .removeSeparator();

            // کنترل سقف تخصیص ردیف فاکتور
            if (enteredAmount > maxAmount) {
                $(this).addClass('is-invalid');
                hasError = true;
            } else {
                $(this).removeClass('is-invalid');
            }

            // تجمیع مقدار تخصیص بر اساس محصول
            if (!allocationData[productId]) {
                allocationData[productId] = {
                    total: 0,
                    inputs: []
                };
            }

            allocationData[productId].total += enteredAmount;

            allocationData[productId].inputs.push({
                id,
                element: $(this),
                amount: enteredAmount
            });

        });

        // محاسبه مانده موجودی هر محصول
        $.each(allocationData, function (productId, value) {

            let availableAmount = $(`#warehouseInquiryItem_${productId}`)
                .removeSeparator();

            let remainingAmount = availableAmount - value.total;

            // نمایش مانده
            $(`#warehouseInquiryRemaining_${productId}`)
                .val(numberFormat(remainingAmount));

            // کنترل موجودی انبار
            $.each(value.inputs, function (key, input) {

                if (remainingAmount < 0) {
                    input.element.addClass('is-invalid');
                    hasError = true;
                }

            });

        });

        return !hasError;
    }

    $("#submitProductPart").on('click', function (event) {

        let $warehouseId = $("#allocationWarehouseId");

        if (!$warehouseId.val()) {

            event.preventDefault();

            $warehouseId.focus();

            customAlert('warning', 'ابتدا انبار را مشخص کنید');

            return false;
        }

        if (!updateAllocation()) {

            event.preventDefault();

            customAlert(
                'warning',
                'مقدار تخصیص از سقف مجاز یا موجودی انبار بیشتر است'
            );

            return false;
        }

    });

});
