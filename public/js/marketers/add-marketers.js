$(function () {
    $("#marketer_address").joditEditor()
    $("#marketer_national_code").numberInput();
    $("#company_national_code").numberInput(11);
    $("#marketer_mobiles").numberInput();
    $("#marketer_shebaNumber").numberInput();
    $("#marketer_accountNumber").numberInput();
    $("#commissionPercentage").numberInput(3, true, 100);
    $("#birth_date").datePicker("attr", "today");
    $("#registration_date").datePicker("attr", "today");
    $("#marketer_cardNumber").on('input', function () {
        let value = this.value.replace(/\D/g, '').slice(0, 16);
        this.value = value.replace(/(\d{4})(?=\d)/g, '$1-');
    });

    $('input[name="marketer_phones[]"]').on('input', function () {
        let value = this.value.replace(/\D/g, '');
        this.value = value.replace(/^(\d{3})(?=\d)/, '$1-');
    });

    $('input[name="marketer_mobiles[]"]').numberInput();
    $('input[name="marketer_phones[]"]').numberInput();
    validateDocument("#back_national_card_image");
    validateDocument("#front_national_card_image");
    validateDocument("#contract_image");
    validateDocument("#contract_image_legal");
    validateDocument("#official_newspaper_image");
    validateDocument("#last_changes_image");


    $(".viewFront_national_card_image").on('click', function () {
        let file = $("#front_national_card_image")[0].files[0];

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
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });
    $(".viewBack_national_card_image").on('click', function () {
        let file = $("#back_national_card_image")[0].files[0];

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
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });
    $(".viewContract_image").on('click', function () {
        let file = $("#contract_image")[viewContract_image].files[0];

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
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });
    $(".viewContract_image_legal").on('click', function () {
        let file = $("#contract_image_legal")[0].files[0];

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
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });
    $(".viewOfficial_newspaper_image").on('click', function () {
        let file = $("#official_newspaper_image")[0].files[0];

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
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });
    $(".viewLast_changes_image").on('click', function () {
        let file = $("#last_changes_image")[0].files[0];

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
            confirmButtonText: "بستن",
            didClose: function () {
                URL.revokeObjectURL(fileUrl);
            }
        });
    });

    let countMobile = 0;

    let countPhone = 0;

    const config = {
        marketerDataUrl: '/marketers/MarketerData',
        addUrl: '/marketers/addMarketerGroup',
        editUrl: '/marketers/editMarketeGroup/'
    };
    const phoneField = (counter) => {
        return `
      <div class="col-md-6 mt-2 mainPhoneDelete_${counter}">
      <label>شماره تماس ثابت</label>
          <div class="input-group">
            <input class="form-control marketer_phones" name="marketer_phones[]">
            <div class="input-group-append">
              <button class="btn btn-danger deleteButton" data-delete="mainPhoneDelete_${counter}" type="button" >حذف</button>
            </div>
        </div>
      </div>
      `;
    }
    const mobileField = (counter) => {
        return `
      <div class="col-md-6 mt-2 mainMobileDelete_${counter}">
      <label>شماره موبایل</label>
          <div class="input-group">
            <input class="form-control marketer_mobiles" name="marketer_mobiles[]" required>
            <div class="input-group-append">
              <button class="btn btn-danger deleteButton" data-delete="mainMobileDelete_${counter}" type="button" >حذف</button>
            </div>
        </div>
      </div>
      `;
    };

    function getCity(state_id) {
        return $.ajax({
            url: '/cities/getFilterCities',
            method: "POST",
            data: {value: state_id},
            dataType: "json"
        });
    }

    function loadMarketerGroups() {
        $('#marketingGroupContent').html(`
            <div class="text-center p-3">در حال دریافت اطلاعات...</div>
        `);

        $.ajax({
            url: config.marketerDataUrl,
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                let html = `
                    <div class="mb-3 text-right">
                        <button type="button" class="btn btn-success btn-sm" id="addMarketerGroup">
                            افزودن گروه جدید
                        </button>
                    </div>

                    <div id="marketerGroupFormContainer"></div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped text-center">
                            <thead>
                                <tr>
                                    <th>ردیف</th>
                                    <th>عنوان گروه</th>
                                    <th>عملیات</th>
                                </tr>
                            </thead>
                            <tbody>
                `;

                if (response.length) {
                    response.forEach(function (item, index) {
                        html += `
                            <tr>
                                <td>${index + 1}</td>
                                <td>${$('<div>').text(item.title || '').html()}</td>
                                <td>
                                    <button type="button"
                                            class="btn btn-sm btn-warning editMarketerGroup"
                                            data-id="${item.id}"
                                            data-title="${$('<div>').text(item.title || '').html()}">
                                        ویرایش
                                    </button>
                                </td>
                            </tr>
                        `;
                    });
                } else {
                    html += `
                        <tr>
                            <td colspan="3">گروهی ثبت نشده است.</td>
                        </tr>
                    `;
                }

                html += `
                            </tbody>
                        </table>
                    </div>
                `;

                $('#marketingGroupContent').html(html);
            },
            error: function () {
                $('#marketingGroupContent').html(`
                    <div class="alert alert-danger">
                        دریافت اطلاعات گروه‌ها با خطا مواجه شد.
                    </div>
                `);
            }
        });
    }

    function showGroupForm(id = '', title = '') {
        $('#marketerGroupFormContainer').html(`
            <form id="marketerGroupForm" class="card card-body mb-3">
                <div class="form-group">
                    <label>عنوان گروه</label>
                    <input type="text"
                           name="title"
                           class="form-control"
                           value="${$('<div>').text(title).html()}"
                           required>
                </div>

                <div class="text-right">
                    <button type="submit" class="btn btn-success btn-sm">
                        ثبت
                    </button>
                    <button type="button" class="btn btn-secondary btn-sm" id="cancelGroupForm">
                        انصراف
                    </button>
                </div>
            </form>
        `);

        $('#marketerGroupForm').data('id', id);
    }

    $('.marketerTypeButton').on('shown.bs.tab', function (e) {
        let target = $(e.target).attr('href');
        let type = target.replace('#', '');

        $('#marketer_type').val(type);

        $('#person, #legal').find(':input').prop('disabled', true);
        $(target).find(':input').prop('disabled', false);
    });

    $('#legal').find(':input').prop('disabled', true);

    $("#state_id").on('change', async function () {
        let id = $(this).val();

        $("#city_id").empty().prop('disabled', true)
            .append('<option value="">در حال دریافت شهرها...</option>');

        if (!id) {
            $("#city_id").html('<option value="">ابتدا استان را انتخاب کنید</option>');
            return;
        }

        try {
            const result = await getCity(id);

            const options = result.map(data =>
                `<option value="${data.id}">${data.title}</option>`
            ).join('');

            $("#city_id").html(
                '<option value="">انتخاب شهر</option>' + options
            ).prop('disabled', false);

        } catch (error) {
            $("#city_id").html('<option value="">خطا در دریافت شهرها</option>');
        }
    });

    $('.addPhoneButton').on('click', function () {
        $(".mainPhone").append(phoneField(countPhone))
        countPhone++;
        $(".deleteButton").on('click', function () {
            let deleteField = $(this).data('delete')
            $("." + deleteField).remove()
        })
    })

    $('.addMobileButton').on('click', function () {
        $(".mainMobile").append(mobileField(countMobile))
        countMobile++;
        $(".deleteButton").on('click', function () {
            let deleteField = $(this).data('delete')
            $("." + deleteField).remove()
        })
    })

    $('#marketingGroupModal').on('shown.bs.modal', function () {
        loadMarketerGroups();
    });

    $(document).on('click', '#addMarketerGroup', function () {
        showGroupForm();
    });

    $(document).on('click', '.editMarketerGroup', function () {
        showGroupForm($(this).data('id'), $(this).data('title'));
    });

    $(document).on('click', '#cancelGroupForm', function () {
        $('#marketerGroupFormContainer').empty();
    });

    $(document).on('submit', '#marketerGroupForm', function (e) {
        e.preventDefault();

        let id = $(this).data('id');
        let url = id ? config.editUrl + id : config.addUrl;

        $.ajax({
            url: url,
            type: 'POST',
            data: $(this).serialize(),
            success: function (response) {
                response = $.trim(response);

                if (response === 'addSucess' || response === 'editSucess') {
                    loadMarketerGroups();
                    return;
                }

                Swal.fire('خطا', 'ثبت اطلاعات انجام نشد.', 'error');
            },
            error: function () {
                Swal.fire('خطا', 'ارتباط با سرور برقرار نشد.', 'error');
            }
        }).then(() => {
            location.reload()
        });
    });


});
