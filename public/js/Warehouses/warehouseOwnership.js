$(function () {
    tinyEditor("#customer_company_address");
    $("#national_code").numberInput()
    $("#registration_number").numberInput()
    $("#national_code").numberInput()
    $("#economic_code").numberInput()
    $("#postal_code").numberInput()
    $("#birth_date").datePicker("attr", "today")
    $("#owner_date").datePicker("attr", "today")
    $("#registration_date").datePicker("attr", "today")


    $("#owner_document").on('input', function () {
        validateDocument("owner_document")
    })

    $("#showDucomnet").on('click', function () {
        if (!validateDocument("owner_document")) return;
        const file = $("#owner_document")[0].files[0];
        if (!file) return;
        const fileUrl = URL.createObjectURL(file);
        Swal.fire({
            width: '90vw', padding: '10px', html: `
        ${file.type.startsWith("image/") ? `<img src="${fileUrl}" style="width:100%; height:80vh; object-fit:contain;">` : `<embed src="${fileUrl}" type="${file.type}" style="width:100%; height:80vh;">`}
    `, confirmButtonText: "بستن", didClose: () => URL.revokeObjectURL(fileUrl)
        });
    });

    $('#personType').select2({
        width: '100%', tags: true, tokenSeparators: [',', ' ']
    });

    $(".nav-link").on('click', function () {

        const id = $(this).attr("href");

        $(".ownership").find("input, select").each(function () {
            $(this).removeAttr('required').val("");
            $(this).removeClass("is-invalid")
        });
        $(id).find("input, select, textarea").each(function () {
            $(this).prop('required', true);
        });

    });
})