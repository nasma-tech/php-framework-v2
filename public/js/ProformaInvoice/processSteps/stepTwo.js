$(function () {
    $("#convertToContractButton").on('click',function () {
        let invoiceId = $("#invoiceId").val();
        Swal.fire({
            icon: 'question',
            title: 'تبدیل پیش‌فاکتور به قرارداد',
            html: '<p style="font-size: 15px">آیا از تبدیل این پیش‌فاکتور به قرارداد اطمینان دارید؟<br>این عملیات را پس از بررسی اطلاعات انجام دهید.</p>',
            showCancelButton: true,
            confirmButtonText: 'بله، تبدیل شود',
            cancelButtonText: 'انصراف',
            reverseButtons: true,
            focusCancel: true,
            preConfirm:()=>{
                $.ajax({
                    url:'/SaleContracts/convertToContract',
                    type:'POST',
                    data:{
                        invoiceId
                    }
                })
            }
        }).then((result) => {
            if (result.isConfirmed) {
            }
        });
    })
});