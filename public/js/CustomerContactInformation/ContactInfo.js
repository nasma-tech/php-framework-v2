$(function () {
    const subscriberForm = () => {
        $("#contact_group_id").getOptionsValue({
            urlAddress: '/ContactsGroup/getContactsGroup', callback: result => {
                $.each(result, function (key, item) {
                    $("#contact_group_id").append(`<option value="${item.id}">${item.title}</option>`)
                })
            }
        })
        $("#contact_acquisition_source_id").getOptionsValue({
            urlAddress: '/ContactAcquisitionSources/getContactAcquisitionSources', callback: result => {
                $.each(result, function (key, item) {
                    $("#contact_acquisition_source_id").append(`<option value="${item.id}">${item.title}</option>`)
                })
            }, defaultOption: true
        })
        $("#state_id").getOptionsValue({
            urlAddress: '/states/getStates', callback: result => {
                $.each(result, function (key, item) {
                    $("#state_id").append(`<option value="${item.id}">${item.title}</option>`)
                })
            }
        })
        return `
            <div class="col-md-4">
            <label for="first_name">نام</label>
            <input class="form-control" required="required" id="first_name" name="first_name">
        </div>
        <div class="col-md-4">
            <label for="last_name">نام خانوادگی</label>
            <input class="form-control" required="required" id="last_name" name="last_name">
        </div>
        <div class="col-md-4">
            <label for="contact_group_id">گروه مشتری</label>
            <select class="form-control select2" required="required" id="contact_group_id" name="contact_group_id">
                <option selected disabled>یک مورد را انتخاب کنید</option>
            </select>
        </div>
        <div class="col-md-4 mt-2">
            <label for="contact_acquisition_source_id">نحوه آشنایی</label>
            <select class="form-control select2" required="required" id="contact_acquisition_source_id" name="contact_acquisition_source_id">
                <option selected disabled>یک مورد را انتخاب کنید</option>
            </select>
        </div>
        `
    }
    const realForm = () => {
        return `
        ${subscriberForm()}
        <div class="col-md-4 mt-2">
            <label for="national_code">کد ملی</label>
            <input class="form-control" id="national_code" name="national_code">
        </div>
        <div class="col-md-4 mt-2">
            <label for="state_id">استان محل سکونت</label>
            <select class="form-control select2" required="required" id="state_id" name="state_id">
                <option selected disabled>یک استان را انتخاب کنید</option>
            </select>
        </div>
        <div class="col-md-4 mt-2">
            <label for="city_id">شهر محل سکونت</label>
            <select class="form-control select2" required="required" disabled id="city_id" name="city_id"></select>
        </div>
      `
    }
    const legalForm = () => {
        return `
            ${subscriberForm()}
            <div class="col-md-4 mt-2">
                <label for="national_ID">شناسه ملی</label>
                <input class="form-control" required="required" id="national_ID" name="national_ID">
            </div>
            <div class="col-md-4 mt-2">
                <label for="economic_code">کد اقتصادی</label>
                <input class="form-control" id="economic_code" name="economic_code">
            </div>
            <div class="col-md-4 mt-2">
                <label for="company_name">عنوان شرکت</label>
                <input class="form-control" id="company_name" name="company_name">
            </div>
            <div class="col-md-4 mt-2">
                <label for="establishment_date">تاریخ تاسیس</label>
                <input class="form-control" id="establishment_date" name="establishment_date">
            </div>
            <div class="col-md-4 mt-2">
                <label for="company_status">وضعیت</label>
                <input class="form-control" id="company_status" name="company_status">
            </div>
            <div class="col-md-4 mt-2">
                <label for="registration_number">تاریخ ثبت</label>
                <input class="form-control" id="registration_number" name="registration_number">
            </div>
            <div class="col-md-4 mt-2">
                <label for="address">آدرس</label>
                <input class="form-control" id="address" name="address">
            </div>
            <div class="col-md-4 mt-2">
                <label for="postal_code">کدپستی</label>
                <input class="form-control" id="postal_code" name="postal_code">
            </div>
        `
    }
    $(".selectContactTypeButton").on('click', function () {
        $(".selectContactTypeButton").each(function () {
            $(this).removeClass('active')
        })
        let buttonType = $(this).data('type');
        switch (buttonType) {
            case "real": {
                $("#mainContactForm").html(realForm())
                $("#contact_type").val(1)
            }
                break;
            case "legal": {
                $("#mainContactForm").html(legalForm())
                $("#contact_type").val(2)
            }
                break;
        }
        $("#contact_group_id,#contact_acquisition_source_id,#state_id").select2()
        $("#state_id").getOptions({
            urlAddress: "/cities/getFilterCities", callback: result => {
                $("#city_id").empty();
                $.each(result, function (key, item) {
                    $("#city_id").append(`<option value="${item.id}">${item.title}</option>`).attr('disabled', false)
                })
                $("#city_id").select2()
            }
        })
        $(this).addClass('active')
        $("#national_code").checkNationalCode({
            onValid: function () {
                $(this).removeClass('is-invalid').addClass('is-valid');
            },
            onInvalid: function () {
                $(this).removeClass('is-valid').addClass('is-invalid');
            }
        })
    })


    //follow up
    $("#state_id").getOptions({
        urlAddress: "/cities/getFilterCities", callback: result => {
            $("#city_id").empty();
            $.each(result, function (key, item) {
                $("#city_id").append(`<option value="${item.id}">${item.title}</option>`).attr('disabled', false)
            })
            $("#city_id").select2()
        }
    })
    let locationUrl = window.location.href;
    if (locationUrl.search('contactDetail') < 0) {
        $(".selectContactTypeButton")[0].click()
    }

})