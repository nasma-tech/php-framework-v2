$(function () {
    //company
    $("#company_national_code").numberInput(10)
    $("#company_registration_date").datePicker("attr", "today")
    $("#company_registration_number").numberInput()
    $("#company_economic_code").numberInput()
    $("#owner_postal_code").numberInput(10)
    $("#company_postal_code").numberInput(10)

    $("#owner_date").datePicker("attr", "today")
    $("#national_id").numberInput(10)

    $("#owner_document").on('input', function () {
        validateDocument("#owner_document")
    })

    $("#showDocument").on('click', function () {
        if (!validateDocument("#owner_document")) return;
        const file = $("#owner_document")[0].files[0];
        if (!file) return;
        const fileUrl = URL.createObjectURL(file);
        Swal.fire({
            width: '90vw', padding: '10px', html: `
        ${file.type.startsWith("image/") ? `<img src="${fileUrl}" style="width:100%; height:80vh; object-fit:contain;">` : `<embed src="${fileUrl}" type="${file.type}" style="width:100%; height:80vh;">`}
    `, confirmButtonText: "بستن", didClose: () => URL.revokeObjectURL(fileUrl)
        });
    });

    $('#authorized_signatories').select2({
        width: '100%', tags: true, tokenSeparators: [',', ' '], placeholder: 'بنویسید...',
    });

    const $personTypeButtons = $(".changePersonTypeButton");

    $personTypeButtons.on("click", function () {
        const value = $(this).data("value");

        $("#person_type").val(value);

        $("#ownerDetailData")
            .find("input, textarea")
            .val("")
            .prop({
                required: false,
                disabled: true
            });

        $(`.ownerDetailDatum_${value}`)
            .find("input, textarea")
            .val("")
            .prop({
                required: true,
                disabled: false
            });
    });

    $personTypeButtons.first().trigger("click");
})