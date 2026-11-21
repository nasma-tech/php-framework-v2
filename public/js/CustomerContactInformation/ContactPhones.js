$(function () {
    const makePhoneRow = (counter) => {
        $.ajax({
            url: '/ContactPhoneLabel/getContactPhoneLabel',
            type: 'GET',
            dataType: 'json',
            success: result => {
                $(`#contact_phone_label_id_${counter}`).append('<option selected disabled>انتخاب کنید</option>')
                $.each(result, function (key, item) {
                    $(`#contact_phone_label_id_${counter}`).append(`<option data-social="${item.hasSocial}" value="${item.id}">${item.title}</option>`)
                })
            }
        })
        return `
            <tr>
                <td class="border">
                    <select id="contact_phone_label_id_${counter}" required="required" data-count="${counter}" name="contactPhone[${counter}][contact_phone_label_id]" class="contact_phone_label_id"></select>
                </td>
                <td class="border">
                    <input class="form-control phone_number" required="required" type="text" dir="ltr" data-count="${counter}" id="phone_number_${counter}" name="contactPhone[${counter}][phone_number]">
                </td>
                <td class="border">
                    <div class="dropup">
                                <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="menu">
                                </span>
                        <div class="dropdown-menu" x-placement="bottom-start">
                            <a class="dropdown-item text-danger removePhoneRow" data-count="${counter}" href="#">
                                <i class="bx bx-trash text-danger mr-1"></i>
                                حذف
                            </a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr id="socialTrRow_${counter}">
                <td class="border" colspan="3">
                    <ul class="list-unstyled" style="margin-top: 5px;margin-bottom: 3px" id="socialRow_${counter}"></ul>
                </td>
            </tr>
        `
    }
    let phoneTrCounter = $(".phoneRowTr").length + 1;
    $("#phoneAppend").on('click', function () {
        $("#phoneTableBody").append(makePhoneRow(phoneTrCounter))
        $(".contact_phone_label_id").select2({
            width: '100%'
        })
        $("#phoneTableBody .phone_number").last().numberInput(11);
        phoneTrCounter++
    })

    $("#phoneTableBody").on('click', '.removePhoneRow', function () {
        let count = $(this).data('count');
        $(this).closest('tr').remove()
        $(`#socialTrRow_${count}`).remove()
    })

    $("#phoneTableBody").on('input', '.phone_number', function () {
        let value = $(this).val();
        if (value.length !== 11) {
            $(this).addClass('is-invalid').removeClass('is-valid')
        } else {
            $.ajax({
                url: '/ContactPhones/checkNumberInput',
                method: "POST",
                data: {phone_number: value},
                dataType: 'JSON',
                success: (result) => {
                    if (result.status == "exist") {
                        swal.fire({
                            icon: 'warning',
                            title: `این شماره به نام ${result.contactFirstName} ${result.contactLastName}`
                        })
                        $(this).addClass('is-invalid').removeClass('is-valid')
                    }else if (result.status == "Nont_exist") {
                        $(this).removeClass('is-invalid').addClass('is-valid')
                    }
                }
            })
        }
    })

    $("#phoneTableBody").on('change', '.contact_phone_label_id', function () {
        let count = $(this).data('count');
        let hasSocial = $(this).find(':selected').data('social');
        if (hasSocial) {
            $.ajax({
                url: '/SocialNetworksList/getSocialNetworkList',
                dataType: 'json',
                success: result => {
                    $.each(result, function (key, item) {
                        let makeId = count + '_' + key;
                        $(`#socialRow_${count}`).append(`
                                <li class="d-inline-block mr-2 mb-1">
                                    <fieldset>
                                        <div class="checkbox checkbox-primary checkbox-glow">
                                            <input type="checkbox" name="contactPhone[${count}][socialList][]" value="${item.id}" id="socialBox_${makeId}">
                                            <label for="socialBox_${makeId}"><img src="${item.icon}" alt="${item.title}" width="20" height="20"></label>
                                        </div>
                                    </fieldset>
                                </li>
                            `)
                    })
                }
            })
        } else {
            $(`#socialRow_${count}`).empty()
        }
    })


})