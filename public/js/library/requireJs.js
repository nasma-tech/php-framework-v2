$(function () {
    let getLocation = window.location.href;
    $("#refreshBtn").attr('href', getLocation);
    $("#backBtn").on('click', function (event) {
        event.preventDefault();
        history.back(1);
    });

    // return false
    $(".select2").select2({
        width: "100%"
    })

    $(document).validateFormBeforeSend({
        checkRequiredAttribute: true
    })

    //read data table
    if ($('.tableDataShow').length > 0) {
        dataTable('.tableDataShow')
    }

    //ajax for delete
    $(".deleteButtonMain").on('click', function () {
        let urlButton = $(this).attr('rel');
        Swal.fire({
            icon: 'question',
            title: 'حذف شود؟',
            text: 'آیا از حذف این مورد اطمینان دارید؟',
            confirmButtonText: 'حذف',
            confirmButtonColor: '#FF2829',
            showCancelButton: true,
            cancelButtonText: 'انصراف',
            preConfirm: () => {
                $.ajax({
                    url: urlButton,
                    type: 'POST',
                    success: result => {
                        if (result.status === "Successful") {
                            Swal.fire({
                                icon: 'success',
                                title: 'با موفقیت حذف شد',
                                timer: 3000,
                                allowOutsideClick: () => {
                                    location.reload();
                                },
                                didClose: () => {
                                    location.reload();
                                },
                                confirmButtonText: 'بستن',
                                preConfirm: () => {
                                    location.reload();
                                }
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'حذف با خطا مواجه شد',
                                text: 'جهت رفع مشکل با پشتیبانی تماس بگیرید',
                                confirmButtonText: 'بستن'
                            });
                        }
                    }
                });
            }
        });
    });

    $(".showImage").on('click', function () {
        let imageAddress = $(this).data('image')
        let modalTitle = $(this).data('modal-title')
        let description = $(this).data('modal-description')
        let extension = imageAddress.split('.')
        Swal.fire({
            title: ((checkIsSet(modalTitle)) ? modalTitle : 'تایید مشتری'),
            width: '80rem',
            html: `${(end(extension) === "pdf" ? `<embed src="${imageAddress}" style="width: 100%;height: 80vh">` : `<img src="${imageAddress}" alt="" style="width: 100%">`)}${((checkIsSet(description)) ? `<br><spab>توضیحات: ${description}</spab>` : ``)}`,
            confirmButtonText: 'بستن',
        })
    })

});