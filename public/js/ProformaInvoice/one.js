$(function () {
    const makeCompanyForm = () => {
        return `
                 <style>
                    .swal2-html-container{
                        margin: 0 !important;
                    }
                    .swal2-popup{
                        padding: 0 !important;
                    }
                 </style>
                 <form id="companiesForm">
                    <div class="row w-100 text-left">
                            <div class="col-md-6 mt-2">
                                <label>شناسه ملی</label>
                                <div class="input-group">
                                    <input class="form-control numberCheck" required id="national_ID" name="national_ID">
                                    <div class="input-group-append">
                                        <button class="input-group-btn btn-sm btn btn-primary" id="inquiryCompanyButton" type="button">استعلام</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label>نام شرکت</label>
                                <input class="form-control companyData" id="company_name" required readonly name="company_name">
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>تاریخ تاسیس</label>
                                <input class="form-control companyData" id="establishment_date" required readonly name="establishment_date">
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>وضعیت</label>
                                <input class="form-control companyData" id="company_status" required readonly name="company_status">
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>شماره ثبت</label>
                                <input class="form-control companyData numberCheck" id="registration_number" required readonly name="registration_number">
                            </div>
                            <div class="col-md-6 mt-2">
                                <label>کداقتصادی</label>
                                <input class="form-control companyData numberCheck" id="economic_code" required readonly name="economic_code">
                            </div>
                            <div class="col-md-6 mt-2">
                                <label>کدپستی</label>
                                <input class="form-control companyData numberCheck" id="postal_code" required readonly name="postal_code">
                            </div>
                            <div class="col-md-12 mt-2">
                                <label>آدرس</label>
                                <textarea class="form-control companyData" rows="6" id="address" required readonly name="address" style="resize: none"></textarea>
                            </div>
                    </div>
                 </form>
            `
    }
    $("#quickAddCustomerCompanyButton").on('click', function () {
        Swal.fire({
            title: `<h5>اطلاعات شرکت</h5>`,
            width: '800px',
            html: makeCompanyForm(),
            confirmButtonText: 'ثبت نهایی',
            preConfirm: () => {
                let form = $("#companiesForm");
                let formData = new FormData(form[0]);
                formData.append('csrfToken', csrfToken());
                if ($("#companiesForm").formValidate(false)) {
                    $.ajax({
                        url: '/Companies/addCompanies',
                        type: 'POST',
                        data: formData,
                        contentType: false,
                        processData: false,
                        cache: false,
                        dataType: 'json',
                        success: result => {
                            if (result.status) {
                                customAlert('success', result.message)
                                $("#customer_company_id").val(result.id)
                                $("#customer_company_title").val(`${result.nationalID} - ${result.companyName}`)
                            } else {
                                swalValidate(result.message)
                            }
                        }
                    })
                }
                return false;
            }
        })

        $(".numberCheck").numberInput(100, false)

        $("#inquiryCompanyButton").on('click', function () {
            let companyNationalID = $("#national_ID").val();
            if (companyNationalID) {
                $.ajax({
                    url: '/Companies/findCompanies',
                    data: {
                        companyNationalID
                    },
                    dataType: 'json',
                    success: result => {
                        if (result.status) {
                            $.each(result.data, function (key, value) {
                                $(`#${key}`).val(value)
                            })
                        } else {
                            swalValidate(result.message)
                        }
                    }
                })
            } else {

            }
        })
    })

    $("#searchCustomerCompanyButton").on('click', function () {
        swal.fire({
            title: `<h5>جستجوی شرکت</h5>`,
            width: '800px',
            html: makeCompanyForm()
        })
    })
})