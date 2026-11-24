$(function () {
    validateDocument(".addressFile")

    $(".addressDescription").joditEditor();

    function getState(country_id) {
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

    $(".country_id").on("change", async function () {

        const key = $(this).data("key");
        const countryId = $(this).val();

        const stateSelect = $(`.state_id[data-key="${key}"]`);
        const citySelect = $(`.city_id[data-key="${key}"]`);

        stateSelect.empty().prop("disabled", true);
        citySelect.empty().prop("disabled", true);

        try {
            const result = await getState(countryId);

            let options = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`;

            options += result.map(data =>
                `<option value="${data.id}">${data.title}</option>`
            ).join("");

            stateSelect.html(options).prop("disabled", false);

        } catch (error) {
            console.error(error);
        }
    });

    $(".state_id").on("change", async function () {

        const key = $(this).data("key");
        const stateId = $(this).val();

        const citySelect = $(`.city_id[data-key="${key}"]`);

        citySelect.empty().prop("disabled", true);

        if (!stateId) return;

        try {
            const result = await getCity(stateId);

            let options = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`;

            options += result.map(data =>
                `<option value="${data.id}">${data.title}</option>`
            ).join("");

            citySelect.html(options).prop("disabled", false);

        } catch (error) {
            console.error(error);
        }
    });

    $(".viewAddressFile").on("click", function () {

        const key = $(this).data("key");
        const fileInput = $(`.addressFile`).eq(key - 1)[0];
        const file = fileInput.files[0];

        if (!file) {
            swal.fire('خطا', 'لطفاً ابتدا فایل را انتخاب کنید', 'error');
            return;
        }

        const fileUrl = URL.createObjectURL(file);

        swal.fire({
            html: `
            <embed src="${fileUrl}"
                   width="100%"
                   height="600px"
                   type="${file.type}">
        `,
            width: '80%',
            showCloseButton: true,
            showConfirmButton: true,
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });

    $(".country_id").val("102").trigger("change");

    $(".previewData").on('click',function () {
        let id = $(this).data('id')
        let file = $(this).data('file')
        let src = "/Storage/addressAnnouncement/" + id + "/" + file
        swal.fire({
            html: `
        <iframe src="${src}"
                width="100%"
                height="600px"
                style="border: none;">
        </iframe>
    `,
            width: '80%',
            showCloseButton: true,
            showConfirmButton: true,
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    })
});