$(function () {
    validateDocument(".address_file")
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

    $(document).on("change", ".country_id", async function () {
        const form = $(this).closest(".location-form");
        const country_id = $(this).val() ?? 102;

        const state = form.find(".state_id");
        const city = form.find(".city_id");

        state.empty().prop("disabled", true).trigger("change");
        city.empty().prop("disabled", true).trigger("change");

        $.ajax({
            url: `/countries/getCountryData/${country_id}`,
            method: "GET",
            dataType: "json",
            success: result => {
                form.find(".area_code").text(result.area_code);
            }
        });

        try {
            const result = await getState(country_id);

            let options = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`;

            options += result.map(data =>
                `<option value="${data.id}">${data.title}</option>`
            ).join("");

            state.html(options).prop("disabled", false).trigger("change.select2");

        } catch (error) {
            console.error(error);
        }
    });

    $(document).on("change", ".state_id", async function () {
        const form = $(this).closest(".location-form");
        const stateId = $(this).val();
        const city = form.find(".city_id");

        city.empty().prop("disabled", true).trigger("change");

        if (!stateId) return;

        try {
            const result = await getCity(stateId);

            let options = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`;

            options += result.map(data =>
                `<option value="${data.id}">${data.title}</option>`
            ).join("");

            city.html(options).prop("disabled", false).trigger("change.select2");

        } catch (error) {
            console.error(error);
        }
    });

    $(document).on("click", ".viewFile", function () {
        let id = $(this).data('id')
        let imageFile =  $(this).data('file')
        if (id && imageFile){
            let src = "/Storage/addressAnnouncement/" + id + "/" + imageFile;
            Swal.fire({
                title: 'نمایش فایل',
                html:`<embed src="${src}" style="width: 100%;height: 70vh">`,
                width: '80%',
                showCloseButton: true,
                confirmButtonText: "بستن",
                didClose: function () {
                    URL.revokeObjectURL(src);
                }
            });
            return ;
        }
        const form = $(this).closest("form");
        const file = form.find(".address_file")[0].files[0];

        if (!file) {
            Swal.fire('خطا', 'ابتدا یک فایل انتخاب کنید', 'warning');
            return;
        }

        const src = URL.createObjectURL(file);

        Swal.fire({
            title: 'نمایش فایل',
            html: `
                ${file.type.startsWith('image/')
                ? `<img src="${src}" style="width:100%; max-height:600px; object-fit:contain;">`
                : file.type === 'application/pdf'
                    ? `<iframe src="${src}" width="100%" height="600px"></iframe>`
                    : 'فرمت فایل پشتیبانی نمی‌شود'
            }
            `,
            width: '800px',
            showCloseButton: true,
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(src);
            }
        });
    });

    $(".location-form").each(function () {
        const form = $(this);

        form.find(".select2").select2({
            width: "100%"
        });

        form.find(".country_id").val("102").trigger("change");
    });
});