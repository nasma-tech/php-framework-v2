$(function () {
    $("#convertToContractButton").on('click', function () {
        let invoiceId = $("#invoiceId").val();
        $(this).attr('disabled', true)
        Swal.fire({
            icon: 'question',
            title: 'تبدیل پیش‌فاکتور به قرارداد',
            html: '<p style="font-size: 15px">آیا از تبدیل این پیش‌فاکتور به قرارداد اطمینان دارید؟<br>این عملیات را پس از بررسی اطلاعات انجام دهید.</p>',
            showCancelButton: true,
            confirmButtonText: 'تبدیل به قرارداد',
            cancelButtonText: 'انصراف',
            reverseButtons: true,
            focusCancel: true,
            preConfirm: () => {
                $.ajax({
                    url: '/SaleContracts/convertToContract',
                    type: 'POST',
                    data: {
                        invoiceId
                    }, success: result => {
                        if (result == 'convertSuccess') {
                            customAlert('success', 'با موفقیت تبدیل به قرارداد شد', 1500)
                            setTimeout(function () {
                                window.location.reload()
                            }, 1500)
                        } else {
                            $(this).attr('disabled', false)
                        }
                    }
                })
            }
        });
    })
});