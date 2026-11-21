$(function () {
    $(".viewFile").on('click', function () {
        let file = $("#fileInput")[0].files[0];

        if (!file) {
            swal.fire('خطا', 'لطفاً ابتدا فایل را انتخاب کنید', 'error');
            return;
        }

        let fileUrl = URL.createObjectURL(file);

        swal.fire({
            html: `<embed src="${fileUrl}" width="100%" height="600px" type="${file.type}">`,
            width: '80%',
            showCloseButton: true,
            showConfirmButton: true,
            confirmButtonText:"بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });
});