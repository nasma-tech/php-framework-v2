$(function () {
    const sumAll = (partId) => {
        let result = {
            sum: 0,
            totalSum: 0,
        };
        $(`.outBandAmount_${partId}`).each(function () {
            let $row = $(this).closest('tr');
            let outBandValue = parseFloat(($(this).val() || '0').toString().replaceAll(',', '')) || 0;
            let unitPrice = parseFloat(($row.find('.finalUnitPrice').val() || '0').toString().replaceAll(',', '')) || 0;
            result.sum += outBandValue * unitPrice;
        });
        let finalSum = result.sum;
        $(`#sumPart_${partId}`).text(parseInt(result.sum).toLocaleString('en-US'));
        let $firstRow = $(`.outBandAmount_${partId}`).first().closest('tr');
        let percentageAmount = 0;
        $firstRow.find('.chargesDeductionInputs').each(function () {
            let coefficient = parseFloat($(this).data('coefficient')) || 1;
            let merge = Number($(this).data('merge'));
            let identifier = $(this).data('identifier');
            let makeResultId = `sumResult_${identifier}_${partId}`;
            let calculateBase = merge ? result.sum : finalSum;
            percentageAmount = calculateBase * (coefficient - 1);
            finalSum += percentageAmount;
            $(`#${makeResultId}`).text(
                parseInt(percentageAmount).toLocaleString('en-US')
            );
        });
        result.totalSum = finalSum;
        $(`#exitSumPart_${partId}`).text(
            parseInt(result.totalSum).toLocaleString('en-US')
        );
        return result;
    };
    $(".outBandAmount").on('input', function () {
        let $row = $(this).closest('tr').find('td');
        let partId = $row.eq(0).find('.finalUnitPrice').data('part');
        sumAll(partId)
    }).priceInput()
    $(".outBandAmount").each(function () {
        let $row = $(this).closest('tr').find('td');
        let partId = $row.eq(0).find('.finalUnitPrice').data('part');
        sumAll(partId)
    })

})