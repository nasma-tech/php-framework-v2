$(function () {
    $("#has_card_number").change(function () {
        if ($(this).prop('checked')){
            $(this).closest('div').find('label').text('دارای شماره کارت')
            $("#bank_list_id").attr('disabled',true).val(0).change()
            $("#bank_card_number").attr('disabled',false).val('')
            $(this).val(1)
        }else {
            $(this).closest('div').find('label').text('فاقد شماره کارت')
            $("#bank_list_id").attr('disabled',false)
            $("#bank_card_number").attr('disabled',true).val('')
            $(this).val(0)
        }
    });

    $("#bank_account_number").numberInput();
    $("#bank_card_number").numberInput(16);
    $("#bank_sheba_number").numberInput(24);
    $("#bank_last_value").priceInput()
    $("#bank_last_value").withSeparator()

    $("#bank_status").checkBoxEvent({
        checkedValue: 1,
        uncheckedValue: 0,
    })

})