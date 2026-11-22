$(function () {
    tinyEditor("#wareHousePartDescription");

    let counter = 0;
    let plateIndex = $(".exitData-plate-row").length;
    let fileIndex = 0;

    const $mainTableBody = $("#mainTable tbody");
    const $plateList = $(".exitData-plates-list");
    const $fileBody = $(".exitData-files-body");

    $("#entryDateTime").datePicker("attr", "today");

    // --------------------------------------------------
    // Helpers
    // --------------------------------------------------

    const escapeHtml = (value) => {
        return $("<div>").text(value ?? "").html();
    };

    const updatePlateEmptyState = () => {
        $(".exitData-plates-empty").toggle(
            $plateList.find(".exitData-plate-row").length === 0
        );
    };

    const updateFileEmptyState = () => {
        const hasFiles = $fileBody.find(".exitData-file-row").length > 0;

        $fileBody.find(".exitData-files-empty").toggle(!hasFiles);
    };

    const updateProductRowNumbers = () => {
        $mainTableBody.find("tr").each(function (index) {
            $(this).find("td:first").text(index + 1);
        });
    };

    // --------------------------------------------------
    // Product Rows
    // --------------------------------------------------

    const newRowHtml = (index, products) => {
        const options = products.map(product => `
            <option value="${escapeHtml(product.id)}"
                    data-unit-name="${escapeHtml(product.unit_title)}">
                ${escapeHtml(product.product_id)} - ${escapeHtml(product.title)}
            </option>
        `).join("");

        return `
            <tr id="row_${index}">
                <td class="border">${$mainTableBody.find("tr").length + 1}</td>

                <td class="border">
                    <select name="product_data[${index}][product_id]"
                            id="product_data_${index}_product_id"
                            class="form-control product-select">
                        <option value="" selected disabled>
                            لطفا یک مورد را انتخاب کنید
                        </option>
                        ${options}
                    </select>
                </td>

                <td class="border">
                    <input type="text"
                           name="product_data[${index}][amount]"
                           id="product_data_${index}_amount"
                           class="form-control"
                           value="0"
                           disabled>
                </td>

                <td class="border">
                    <input type="text"
                           id="product_data_${index}_unit_name"
                           class="form-control"
                           disabled>
                </td>

                <td class="border text-center">
                    <button type="button"
                            class="btn btn-sm btn-danger removeButton"
                            data-id="${index}">
                        <i class="bx bx-trash"></i>
                    </button>
                </td>
            </tr>
        `;
    };

    $("#newRowButton").on("click", function () {
        const $warehouse = $("#warehouse_id");
        const warehouseId = $warehouse.val();

        if (!warehouseId) {
            customAlert("warning", "ابتدا انبار را مشخص کنید");
            return;
        }

        const selectedBrands = $warehouse
            .find(":selected")
            .data("selected-brand-ids");

        cardLoader(".card");

        $.ajax({
            url: "/Products/fetchProductsByFilteredBrandsForm",
            method: "POST",
            dataType: "json",
            data: {
                csrfToken: csrfToken(),
                selectedBrands: selectedBrands
            },

            success: function (result) {
                if (!result.status) {
                    customAlert(
                        "warning",
                        result.message || "دریافت محصولات با خطا مواجه شد"
                    );
                    return;
                }

                const currentIndex = counter++;

                $mainTableBody.append(
                    newRowHtml(currentIndex, result.data.products || [])
                );

                const $select = $(`#product_data_${currentIndex}_product_id`);

                $select.select2({
                    width: "100%"
                });

                priceFormatWithDecimals(
                    `#product_data_${currentIndex}_amount`
                );
            },

            error: function (xhr) {
                console.error("Product fetch error:", xhr);

                customAlert(
                    "error",
                    "خطا در دریافت اطلاعات محصولات"
                );
            },

            complete: function () {
                unblockCardLoader(".card");
            }
        });
    });

    // انتخاب محصول
    $(document).on("change", ".product-select", function () {
        const $select = $(this);
        const index = $select.attr("id").match(/\d+/)[0];

        const $selected = $select.find(":selected");

        $(`#product_data_${index}_amount`)
            .prop("disabled", false)
            .val(0);

        $(`#product_data_${index}_unit_name`)
            .val($selected.data("unit-name"));
    });

    // حذف محصول
    $(document).on("click", ".removeButton", function () {
        const id = $(this).data("id");

        $(`#row_${id}`).remove();

        updateProductRowNumbers();
    });

    // تغییر انبار
    $("#warehouse_id").on("change", function () {
        $mainTableBody.empty();
        counter = 0;
    });

    // --------------------------------------------------
    // File Rows
    // --------------------------------------------------

    const createFileRow = (index) => {
        return `
            <tr class="exitData-file-row">
                <td>
                    <input type="text"
                           name="files[${index}][name]"
                           class="form-control"
                           placeholder="نام فایل"
                           required>
                </td>

                <td>
                    <input type="text"
                           name="files[${index}][description]"
                           class="form-control"
                           placeholder="توضیحات فایل">
                </td>

                <td>
                    <input type="file"
                           name="files[${index}][file]"
                           class="form-control"
                           required>
                </td>

                <td class="text-center">
                    <button type="button"
                            class="btn btn-sm btn-outline-danger removeFileBtn"
                            title="حذف فایل">
                        <i class="bx bx-trash"></i>
                    </button>
                </td>
            </tr>
        `;
    };

    // افزودن فایل
    $(".addFileBtn").on("click", function () {
        const index = fileIndex++;

        $fileBody.append(createFileRow(index));

        updateFileEmptyState();

        $fileBody
            .find(".exitData-file-row")
            .last()
            .find("input:first")
            .trigger("focus");
    });

    // حذف فایل
    $(document).on("click", ".removeFileBtn", function () {
        $(this).closest(".exitData-file-row").remove();

        updateFileEmptyState();
    });

    // --------------------------------------------------
    // Plate Rows
    // --------------------------------------------------

    const createPlate = (index) => {
        return `
            <div class="border rounded p-3 mb-2 exitData-plate-row">
                <div class="form-row align-items-end">

                    <div class="col-md-3 mb-2">
                        <label>نوع خودرو</label>
                        <input type="text"
                               name="driver_plaques[${index}][car_type]"
                               class="form-control text-center"
                               placeholder="مثلاً کامیون"
                               autocomplete="off">
                    </div>

                    <div class="col-md-2 mb-2">
                        <label>دو رقم اول</label>
                        <input type="text"
                               name="driver_plaques[${index}][first]"
                               class="form-control text-center"
                               maxlength="2"
                               inputmode="numeric"
                               autocomplete="off">
                    </div>

                    <div class="col-md-2 mb-2">
                        <label>حرف پلاک</label>
                        <input type="text"
                               name="driver_plaques[${index}][two]"
                               class="form-control text-center"
                               maxlength="1"
                               autocomplete="off">
                    </div>

                    <div class="col-md-2 mb-2">
                        <label>سه رقم پلاک</label>
                        <input type="text"
                               name="driver_plaques[${index}][three]"
                               class="form-control text-center"
                               maxlength="3"
                               inputmode="numeric"
                               autocomplete="off">
                    </div>

                    <div class="col-md-2 mb-2">
                        <label>ایران</label>
                        <input type="text"
                               name="driver_plaques[${index}][four]"
                               class="form-control text-center"
                               maxlength="2"
                               inputmode="numeric"
                               autocomplete="off">
                    </div>

                    <div class="col-md-1 mb-2">
                        <button type="button"
                                class="btn btn-outline-danger btn-block removePlateBtn"
                                title="حذف پلاک">
                            <i class="bx bx-trash"></i>
                        </button>
                    </div>

                </div>
            </div>
        `;
    };

    $(".addPlateBtn").on("click", function () {
        $plateList.append(createPlate(plateIndex++));

        updatePlateEmptyState();

        $plateList
            .find(".exitData-plate-row")
            .last()
            .find('input[name$="[first]"]')
            .trigger("focus");
    });

    $(document).on("click", ".removePlateBtn", function () {
        $(this).closest(".exitData-plate-row").remove();

        updatePlateEmptyState();
    });

    // --------------------------------------------------
    // Initial State
    // --------------------------------------------------

    updatePlateEmptyState();
    updateFileEmptyState();

});
