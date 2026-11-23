$(function () {
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

    $("#country_id")
        .on("change", async function () {
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

            let options = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`
            options += result.map(data =>
                `<option value="${data.id}">${data.title}</option>`
            ).join('');

            $("#state_id").html(options).prop('disabled', false);
        })
        .val("102")
        .trigger("change");
    $("#state_id").on('change', async function () {
        const stateId = $(this).val();

        $("#city_id").empty().prop('disabled', true);

        if (!stateId) return;

        const result = await getCity(stateId);
        let options = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`
        options += result.map(data =>
            `<option value="${data.id}">${data.title}</option>`
        ).join('');

        $("#city_id").html(options).prop('disabled', false);
    });
})