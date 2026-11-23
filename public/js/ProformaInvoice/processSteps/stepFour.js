$(function () {
    $(".outBandAmount").on('input', function () {
        let $row = $(this).closest('tr').find('td');
        let outBandValue = parseFloat($(this).val().replaceAll(',', ''));
        let partId = $row.eq(0).find('.finalUnitPrice').data('part');
        let unitPrice = $row.eq(0).find('.finalUnitPrice').val();
        if (isNaN(outBandValue)) {
            outBandValue = 0;
        }
        let calculateRow = outBandValue * unitPrice;
        $(`#sumPart_${partId}`).text(calculateRow.toLocaleString())
        let finalSum = calculateRow;
        $row.eq(0).find('.chargesDeductionInputs').each(function () {
            let coefficient = $(this).data('coefficient');
            let merge = $(this).data('merge');
            let identifier = $(this).data('identifier');
            let makeResultId = `sumResult_${identifier}_${partId}`
            let percentageAmount;
            if (merge) {
                percentageAmount = calculateRow * (coefficient - 1);
            } else {
                percentageAmount = finalSum * (coefficient - 1);
            }
            $(`#${makeResultId}`).text(parseInt(percentageAmount).toLocaleString())
            $(`#${identifier}_tr`).text(Math.round(percentageAmount).toLocaleString());
            finalSum += parseInt(percentageAmount);
        })
        $(`#exitSumPart_${partId}`).text(finalSum.toLocaleString())
    }).priceInput()
})