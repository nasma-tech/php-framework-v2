$(function () {

    $(".allocationEnteredAmountInput").on('click', function () {
        let id = $(this).data('id')

        let reserverAmount = $(`#allocationReservedAmountInput_${id}`).removeSeparator()

        console.log(reserverAmount)
    })

    $("#submitProductPart").on('click', function () {

    })
});
