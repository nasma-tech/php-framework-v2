$(function () {
    const $steps = $(".stepsCard");
    const $nextButton = $(".nextStepButton");
    const $previousButton = $(".previousStepButton");
    const $submitButton = $(".submitButton");

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
