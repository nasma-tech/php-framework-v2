$(function () {
    $("[data-min], [data-max]").each(function () {
        const $input = $(this);

        $input.setInputMinMax(
            $input.data("min") ?? null,
            $input.data("max") ?? null,
        );
    });

    $("#option_cancel_contract").on('click', function () {
        let invoiceId = $("#invoiceId").val()
        swal.fire({
            icon: 'warning',
            title: '<h6>از لغو قرارداد اطمبنان دارید؟</h6>',
            confirmButtonText: 'تایید',
            showDenyButton: true,
            denyButtonText: 'انصراف',
            preConfirm: () => {
                $.ajax({
                    url: '/CancelledSaleContracts/cancelContract',
                    type: 'POST',
                    data: {
                        invoiceId
                    },
                    success: result => {
                        let messageList = {
                            cancelSuccess: {
                                message: 'قرارداد با موفقیت لغو شد',
                                icon: 'success',
                            },
                            cancelFailed: {
                                message: 'لغو قرارداد با خطا مواجه شد',
                                icon: 'error',
                            },
                            contractNotFound: {
                                message: 'قرارداد یافت نشد',
                                icon: 'error',
                            },
                            proformaInvoiceNotFound: {
                                message: 'پیشفاکتور یافت نشد',
                                icon: 'error',
                            },
                        }
                        $.each(messageList,function (key,item) {
                            if (key == result){
                                customAlert(item.icon,item.message,1500)
                                setTimeout(function () {
                                    window.location.reload()
                                },1500)
                            }
                        })
                    }
                })
            }
        })
    })
})