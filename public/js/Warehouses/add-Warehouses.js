$(function () {
    tinyEditor("#wareHouceFullAdress");
    tinyEditor("#customer_company_address");
    $("#post_code").numberInput()
    $("#warehousePhoneNumber").numberInput()
    $("#national_code").numberInput()
    $("#registration_number").numberInput()
    $("#national_code").numberInput()
    $("#economic_code").numberInput()
    $("#postal_code").numberInput()
    $("#birth_date").datePicker("attr", "today")
    $("#owner_date").datePicker("attr", "today")
    $("#registration_date").datePicker("attr", "today")
    $("#wareHouceFullAdress").formValidate(true, "exception", 4, true);

    function getState(country_id = 102) {
        return $.ajax({
            url: `/states/getStates/${country_id}`,
            method: "GET",
            dataType: "json"
        });
    }

    function getCity(state_id) {
        return $.ajax({
            url: `/cities/getFilterCities`,
            method: "POST",
            data: {value: state_id},
            dataType: "json"
        });
    }

    $("#country_id").on("change", async function () {
        const country_id = $(this).val() ?? 102;
        $.ajax({
            url: `/countries/getCountryData/${country_id}`,
            method: 'GET',
            dataType: 'Json',
            success: result => {
                $("#area_code").text(result.area_code);
            }
        })
        $("#state_id").empty().prop('disabled', true);
        $("#city_id").empty().prop('disabled', true);

        const result = await getState(country_id);

        const options = result.map(data =>
            `<option value="${data.id}">${data.title}</option>`
        ).join('');

        $("#state_id").html(options).prop('disabled', false);
    });
    $("#state_id").on('change', async function () {
        const stateId = $(this).val();

        $("#city_id").empty().prop('disabled', true);

        if (!stateId) return;

        const result = await getCity(stateId);
        console.log(result)
        const options = result.map(data =>
            `<option value="${data.id}">${data.title}</option>`
        ).join('');

        $("#city_id").html(options).prop('disabled', false);
    });
    $("#owner_document").on('input', function () {
        validateDocument("owner_document")
    })
    $("#showDucomnet").on('click', function () {
        if (!validateDocument("owner_document")) return;
        const file = $("#owner_document")[0].files[0];
        if (!file) return;
        const fileUrl = URL.createObjectURL(file);
        Swal.fire({
            width: '90vw',
            padding: '10px',
            html: `
        ${file.type.startsWith("image/")
                ? `<img src="${fileUrl}" style="width:100%; height:80vh; object-fit:contain;">`
                : `<embed src="${fileUrl}" type="${file.type}" style="width:100%; height:80vh;">`
            }
    `,
            confirmButtonText: "بستن",
            didClose: () => URL.revokeObjectURL(fileUrl)
        });
    });
    $("#country_id").val("102").trigger("change");
    $('#personType').select2({
        width: '100%',
        tags: true,
        tokenSeparators: [',', ' ']
    });
    //wareHousekeeperTeam
});
