$(function () {
    $("[data-min], [data-max]").each(function () {
        const $input = $(this);

        $input.setInputMinMax(
            $input.data("min") ?? null,
            $input.data("max") ?? null,
        );
    });
})