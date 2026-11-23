$(function () {
    const $steps = $(".stepsCard");
    const $nextButton = $(".nextStepButton");
    const $previousButton = $(".previousStepButton");
    const $submitButton = $(".submitButton");
    const summaryDataRead = () => {
        let data = {
            teamSummary: $("#sale_team_id option:selected").text(),
            customerSummary: $("#contact_name").val(),
            customerCompanySummary: $("#customer_company_title").val(),
            validitySummary: $("#day_validity").val() + ' روز',
            brandSummary: $("#brand_id option:selected").text(),
            productsSummary: [],
            marketerSummary: $("#marketer_id option:selected").text(),
            countrySummary: $("#country_id option:selected").text(),
            stateSummary: $("#state_id option:selected").text(),
            citySummary: $("#city_id option:selected").text(),
            deliverySummary: $("#delivery_date").val() + ' روز',
            paymentTermsSummary: $("#payment_terms").val(),
            bottomInvoiceTextSummary: $("#bottom_invoice_text").val(),
        }
        $("#mainProduct tr").each(function () {
            let $row = $(this).find('td');
            data.productsSummary.push({
                product: $row.eq(1).find('select').find(':selected').text(),
                amount: $row.eq(2).find('.product_amount').val(),
                unit: $row.eq(1).find('select').find(':selected').data('unit'),
                unitPrice: $row.eq(4).find('.product_unit_price').val(),
                discountAmount: $row.eq(5).find('.discountAmount').val(),
                productSumRowWithOutDiscount: $row.eq(5).find('.productSumRowWithOutDiscount').val(),
                sumRowUnitPrice: $row.eq(5).find('.productSumRow').val(),
            })
        })
        $.each(data, function (key, item) {
            if (key != 'productsSummary' && key != 'paymentTermsSummary' && key != 'bottomInvoiceTextSummary') {
                $(`#${key}`).text(item)
            }
        })
        $("#productsSummary").empty()
        $.each(data.productsSummary, function (productKey, productData) {
            $("#productsSummary").append(`
                <tr>
                    <td class="border">${productKey + 1}</td>
                    <td class="border">${productData.product}</td>
                    <td class="border">${productData.amount}</td>
                    <td class="border">${productData.unit}</td>
                    <td class="border">${productData.unitPrice}</td>
                    <td class="border">${parseFloat(productData.productSumRowWithOutDiscount).toLocaleString()}</td>
                    <td class="border">${productData.discountAmount}</td>
                    <td class="border">${productData.sumRowUnitPrice}</td>
                </tr>
            `)
        })
        $('#paymentTermsSummary').joditEditor({
            value: data.paymentTermsSummary
        });
        $('#bottomInvoiceTextSummary').joditEditor({
            value: data.bottomInvoiceTextSummary
        });
    }

    // دریافت شماره مراحل
    const steps = $steps.map(function () {
        return Number($(this).data("step"));
    }).get().sort((a, b) => a - b);

    // شماره مرحله فعال
    const getActiveStep = () => {
        return Number($steps.filter(".active").data("step")) || steps[0];
    };

    // نمایش مرحله موردنظر
    const showStep = (step) => {
        $steps.removeClass("active").hide();

        const $currentStep = $steps.filter(function () {
            return Number($(this).data("step")) === step;
        });

        $currentStep.addClass("active").show();

        // وضعیت دکمه‌ها
        $previousButton.toggle(step !== steps[0]);
        $nextButton.toggle(step !== steps[steps.length - 1]);
        $submitButton.toggle(step === steps[steps.length - 1]);
    };

    // پاک کردن خطای فیلد هنگام تغییر مقدار
    $steps.on("input change", ":input", function () {
        if ($(this).prop("required") && $(this).val() !== "") {
            $(this).removeClass("is-invalid").addClass("is-valid");
        }
    });

    // مقداردهی اولیه
    $steps.hide();

    if (steps.length) {
        showStep(steps[0]);
    }

    // مرحله بعد
    $nextButton.on("click", function () {
        const currentStep = getActiveStep();
        let $step = $(`#step_${currentStep}`)
        if (!$step.formValidate()){
            return;
        }
        const nextStep = steps[steps.indexOf(currentStep) + 1];
        if (nextStep !== undefined) {
            showStep(nextStep);
            summaryDataRead()
        }
    });

    // مرحله قبل
    $previousButton.on("click", function () {
        const currentStep = getActiveStep();
        const previousStep = steps[steps.indexOf(currentStep) - 1];
        if (previousStep !== undefined) {
            showStep(previousStep);
        }
    });

    // ثبت نهایی
    $submitButton.on("click", function (e) {
        const currentStep = getActiveStep();
        let $step = $(`#step_${currentStep}`)
        if (!$step.formValidate()){
            return;
        }
    });

});
