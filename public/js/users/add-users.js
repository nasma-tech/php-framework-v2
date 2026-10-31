$(function () {
    // $("#company_id").on('change', function () {
    //     let companyId = $(this).val()
    //     $("#representation_id").html('<option value="0">بدون نمایندگی</option>')
    //     $.ajax({
    //         url: '/Representations/getFilterRepresentation',
    //         type: 'POST',
    //         data: {companyId},
    //         success: result => {
    //             if (result) {
    //                 let data = JSON.parse(result)
    //                 $.each(data, function (key, item) {
    //                     $("#representation_id").append(`<option value="${item.id}">${item.title}</option>`)
    //                 })
    //             }
    //         }
    //     })
    // })
    // $("#full_name").persianInput()
    // $("#national_code").numberInput(10)
    // $("#user_mobile").numberInput(11)

    $("#userIdentify_birth_date").datePicker()

    const numberInputs = {
        userIdentify_national_id: 10,
        userIdentify_passport_number: 10,
    }

    const persianInputs = [
        'userData_first_name',
        'userData_last_name',
        'userIdentify_father_name',
        'userIdentify_birth_place',
    ];

    $.each(numberInputs, function (key, value) {
        $(`#${key}`).numberInput(value)
    })

    $.each(persianInputs, function (index, value) {
        $(`#${value}`).persianInput();
    });

    $(".changeAvatar").on("click", function () {
        $("#avatarInput").click();
    });
    $("#avatarInput").on("change", function () {
        readImage(this, "avatarImage");
    });

    $("#userIdentify_national_id").on('input', async function () {
        let value = $(this).val()
        let $element = $('#userIdentify_issuing_place_id')
        let options = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`

        if (value.length === 10) {
            let result = await $.ajax({
                url: "/IssuingPlace/filter",
                dataType: "json",
                data: {
                    code: value.slice(0, 3)
                }
            })

            if (result.length > 0) {

                $element.prop('disabled', false)
                    .destroySelect2()

                $.each(result, function (key, obj) {
                    options += `<option value="${obj.id}">${obj.title}</option>`
                })

                $element
                    .html(options)
                    .select2({
                        width: "100%"
                    })
            } else {
                customAlert('warning', 'محل صدور کد ملی یافت نشد')
            }

        } else {
            $element
                .html(options)
                .prop('disabled', true)
                .destroySelect2()
        }
    })

    //*** address ***//

    let addressCounter = $("#addressTable tbody tr").length

    const addressRow = (addressCounter, data) => {
        const fullAddress = `شهر ${data.cityTitle}، ${data.main_street}, ${data.side_street}, کوچه ${data.alley_name}, پلاک ${data.plaque}, واحد ${data.unit}`
        return `
        <tr id="addressRow_${addressCounter}">
            <td class="border">
                <div class="radio">
                    <input class="form-control" type="radio" name="userAddress_is_default" id="userAddress_${addressCounter}_is_default"
                        ${((parseInt($("#addressTable tbody tr").length) === 0) ? 'checked' : '')}
                        value="${addressCounter}"
                     > 
                    <label for="userAddress_${addressCounter}_is_default"></label>
                </div>
            </td>
            <td class="border">
                <input type="hidden" id="userAddress_${addressCounter}_alley_name" name="userAddress[${addressCounter}][alley_name]" value='${data.alley_name}'>
                <input type="hidden" id="userAddress_${addressCounter}_area_code" name="userAddress[${addressCounter}][area_code]" value='${data.area_code}'>
                <input type="hidden" id="userAddress_${addressCounter}_city_id" name="userAddress[${addressCounter}][city_id]" value='${data.city_id}'>
                <input type="hidden" id="userAddress_${addressCounter}_landline_number" name="userAddress[${addressCounter}][landline_number]" value='${data.landline_number}'>
                <input type="hidden" id="userAddress_${addressCounter}_main_street" name="userAddress[${addressCounter}][main_street]" value='${data.main_street}'>
                <input type="hidden" id="userAddress_${addressCounter}_side_street" name="userAddress[${addressCounter}][side_street]" value='${data.side_street}'>
                <input type="hidden" id="userAddress_${addressCounter}_plaque" name="userAddress[${addressCounter}][plaque]" value='${data.plaque}'>
                <input type="hidden" id="userAddress_${addressCounter}_postal_code" name="userAddress[${addressCounter}][postal_code]" value='${data.postal_code}'>
                <input type="hidden" id="userAddress_${addressCounter}_unit" name="userAddress[${addressCounter}][unit]" value='${data.unit}'>
                <input type="text" id="userAddress_${addressCounter}_complete_address" class="form-control" name="userAddress[${addressCounter}][complete_address]" value="${fullAddress}">
            </td>
            <td class="border">
                <button type="button" class="btn btn-icon rounded-circle btn-light-warning editAddressData" data-id="${addressCounter}">
                    <i class="bx bx-edit"></i>
                </button>
                <button type="button" class="btn btn-icon rounded-circle btn-light-danger deleteAddressData" data-id="${addressCounter}">
                    <i class="bx bx-trash"></i>
                </button>
            </td>
        </tr>
        `
    }

    const addressForm = async (mode = "add", id) => {
        let data = []
        let citiesOption = `<option selected disabled>لطفا یک مورد را انتخاب کنید</option>`
        let result = await $.ajax({
            url: "/cities/getFilterCities",
            dataType: 'json',
        })

        if (mode === 'edit') {
            data = {
                alley_name: $(`#userAddress_${id}_alley_name`).val(),
                area_code: $(`#userAddress_${id}_area_code`).val(),
                city_id: $(`#userAddress_${id}_city_id`).val(),
                landline_number: $(`#userAddress_${id}_landline_number`).val(),
                main_street: $(`#userAddress_${id}_main_street`).val(),
                side_street: $(`#userAddress_${id}_side_street`).val(),
                plaque: $(`#userAddress_${id}_plaque`).val(),
                postal_code: $(`#userAddress_${id}_postal_code`).val(),
                unit: $(`#userAddress_${id}_unit`).val(),
            }
        }

        $.each(result, async function (key, obj) {
            citiesOption += `<option value="${obj.id}" ${((mode === 'edit' && parseInt(data.city_id) === parseInt(obj.id)) ? 'selected' : '')}>${obj.title}</option>`
        })

        return `
        <div class="card">
            <div class="card-body">
                <form id="addressForm">
                    <div class="row">
                        <div class="col-md-3">
                            <label for="city_id">شهر</label>
                            <select class="form-control" name="city_id" id="city_id" required>${citiesOption}</select>
                        </div>
                        <div class="col-md-5">
                            <label for="main_street">خیابان اصلی</label>
                            <input class="form-control" type="text" name="main_street" id="main_street" value="${((mode === 'edit') ? data.main_street : '')}" required>
                        </div>
                        <div class="col-md-4">
                            <label for="side_street">خیابان فرعی</label>
                            <input class="form-control" type="text" name="side_street" id="side_street" value="${((mode === 'edit') ? data.side_street : '')}" required>
                        </div>
                        <div class="col-md-2">
                            <label for="alley_name">کوچه</label>
                            <input class="form-control" type="text" name="alley_name" id="alley_name" value="${((mode === 'edit') ? data.alley_name : '')}" required>
                        </div>
                        <div class="col-md-2">
                            <label for="plaque">پلاک</label>
                            <input class="form-control" type="text" name="plaque" id="plaque" value="${((mode === 'edit') ? data.plaque : '')}" required>
                        </div>
                        <div class="col-md-2">
                            <label for="unit">واحد</label>
                            <input class="form-control" type="text" name="unit" id="unit" value="${((mode === 'edit') ? data.unit : '')}" required>
                        </div>
                        <div class="col-md-3">
                            <label for="postal_code">کد پستی</label>
                            <input class="form-control" type="text" name="postal_code" id="postal_code" value="${((mode === 'edit') ? data.postal_code : '')}" required>
                        </div>
                        <div class="col-md-3">
                            <label for="landline_number">شماره ثابت</label>
                            <div class="input-group">
                                <input class="form-control" type="text" name="landline_number" id="landline_number" value="${((mode === 'edit') ? data.landline_number : '')}" required>
                                <div class="input-group-append">
                                    <input class="form-control" type="text" name="area_code" id="area_code" value="${((mode === 'edit') ? data.area_code : '')}" required placeholder="کد" style="max-width: 50px">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        `
    }

    $("#newAddressBtn").on('click', async function () {
        let addressTable = $("#addressTable")

        swal.fire({
            title: "افزودن آدرس",
            width: "55vw",
            html: await addressForm(),
            showDenyButton: true,
            denyButtonText: "انصراف",
            confirmButtonText: "تایید",
            preConfirm: () => {
                if ($("#addressForm").formValidate(false)) {

                    let data = getInputsNested("#addressForm")

                    data.cityTitle = $("#city_id").find("option:selected").text()

                    addressTable.find('tbody').append(addressRow(++addressCounter, data))

                    actionAddressDataEvent()

                } else {
                    swalValidate('موارد مشخص شده را پر کنید')
                }
            }
        })

        addressModalEvents()

    })

    function actionAddressDataEvent() {
        $(".editAddressData")
            .off('click')
            .on('click', async function () {
                let id = $(this).data('id')

                swal.fire({
                    title: "ویرایش آدرس",
                    width: "55vw",
                    html: await addressForm("edit", id),
                    showDenyButton: true,
                    denyButtonText: "انصراف",
                    confirmButtonText: "تایید",
                    preConfirm: () => {
                        if ($("#addressForm").formValidate(false)) {

                            let data = getInputsNested("#addressForm")

                            $.each(data, function (key, obj) {
                                $(`#userAddress_${id}_${key}`).val(obj)
                            })

                        } else {
                            swalValidate('موارد مشخص شده را پر کنید')
                        }
                    }
                })

                addressModalEvents()
            })

        $(".deleteAddressData")
            .off('click')
            .on('click', function () {
                let id = $(this).data('id')

                swal.fire({
                    title: "حذف آدرس",
                    icon: 'error',
                    text: 'از حذف آدرس اطمینان دارید؟',
                    showDenyButton: true,
                    denyButtonText: 'انصراف',
                    confirmButtonText: 'تایید',
                    preConfirm: () => {
                        $(`#addressRow_${id}`).remove()
                    }
                })
            })
    }

    function addressModalEvents() {
        $("#city_id").select2({
            width: "100%",
        })

        const numberInputs = {
            postal_code: 10,
            landline_number: 8,
            area_code: 3,
        }

        $.each(numberInputs, function (key, value) {
            $(`#${key}`).numberInput(value, false)
        })
    }

    //*** address ***//

    //*** userContactType ***//

    $(".userContactTypeValue").on('input', function () {
        const pattern = $(this).attr("data-validation-pattern");
        const regex = new RegExp(pattern);

        if (regex.test($(this).val())) {
            $(this).addClass('is-valid').removeClass('is-invalid')
        } else {
            $(this).addClass('is-invalid').removeClass('is-valid')
        }
    })

    //*** userContactType ***//
})