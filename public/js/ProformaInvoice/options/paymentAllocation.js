$(function () {
    let invoiceId = $("#invoiceId").val()
    const depositAllocationForm = () => {
        $.ajax({
            url: '/PaymentManagement/getPayments',
            dataType: 'json',
            success: result => {
                if (result.payment){
                    $.each(result.payment,function (key,item) {
                        $("#payment_management_id").append(`<option value="${item.id}">${item.bankName} | ${item.branchName} | شناسه واریز :  ${item.referenceNo}</option>`).select2()
                    })
                }
                if (result.cheque){
                    $.each(result.cheque,function (key,item) {
                        $("#payment_management_id").append(`<option value="${item.id}">شماره صیادی چک : ${item.chequeNumber}</option>`).select2()
                    })
                }
                $.map(result.allocationType, function (item, key) {
                    $("#payment_allocation_type_id").append(`<option value="${item.id}">${item.title}</option>`).select2()
                })
            }
        })
        return `
            <form id="depositForm">
                <input type="hidden" value="${csrfToken()}" name="csrfToken">
                <div class="row w-100 text-left">
                    <div class="col-md-6">
                        <label>انتخاب واریزی</label>
                        <select class="form-control" required="required" id="payment_management_id" name="payment_management_id">
                            <option selected disabled>یک مورد را انتخاب کنید</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label>نوع واریزی</label>
                        <select class="form-control" required="required" id="payment_allocation_type_id" name="payment_allocation_type_id">
                            <option selected disabled>یک مورد را انتخاب کنید</option>
                        </select>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>تاریخ</label>
                        <input class="form-control text-center" readonly="readonly" id="allocation_date">
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>مانده از واریزی</label>
                        <div class="input-group">
                            <input class="form-control text-center" required="required" id="allocation_remaining_payment_amount" readonly="readonly">
                            <div class="input-group-append">
                                <div class="input-group-text">ریال</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>مقدار واریزی</label>
                        <div class="input-group">
                            <input class="form-control" required="required" readonly="readonly" id="allocation_payment_amount" name="payment_amount">
                            <div class="input-group-append">
                                <div class="input-group-text">ریال</div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
      `
    }

    $("#option_payment_allocation").on('click',function () {
        swal.fire({
            title: '<h6>فرم تخصیص واریزی</h6>',
            html: depositAllocationForm(),
            width: '70rem',
            confirmButtonText: 'تایید',
            showDenyButton: true,
            denyButtonText: 'انصراف',
            preConfirm: () => {
                let form = $("#depositForm");
                if (form.formValidate(false)) {
                    let formData = new FormData(form[0]);
                    formData.append('invoiceId', invoiceId)
                    $.ajax({
                        url: '/PaymentAllocation/submitPaymentAllocation',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        cache: false,
                        success: result => {
                            handeOfAjaxJsonResponse(result)
                        }
                    })
                } else {
                    swalValidate('موارد مشخص شده را پر کنید')
                }
            },
            allowOutsideClick: () => {
                return false;
            },
            allowEscapeKey: () => {
                return false;
            }, didOpen: () => {
                $("#allocation_date").val(jdate().jalali.date)
                $("#payment_management_id").change(function () {
                    let paymentManagementId = $(this).val()
                    $.ajax({
                        url: '/PaymentManagement/getRemainingPayment',
                        data: {
                            paymentManagementId
                        },
                        success: result => {
                            $("#allocation_remaining_payment_amount").val(parseFloat(result).toLocaleString())
                            if (result) {
                                $("#allocation_payment_amount").attr('readonly', false)
                            } else {
                                $("#allocation_payment_amount").attr('readonly', true)
                            }
                        }
                    })
                })
                $("#allocation_payment_amount").on('input', function () {
                    let remaining = parseFloat($("#allocation_remaining_payment_amount").val().replaceAll(',', ''))
                    let paymentAmount = parseFloat($(this).val().replaceAll(',', ''))
                    if (paymentAmount > remaining) {
                        swalValidate('مقدار واریزی بیشتر از حد مجاز')
                        swalConfirmButton({enableOrDisable: true})
                    } else {
                        swalClearValidate()
                        swalConfirmButton({enableOrDisable: false})
                    }
                }).priceInput()
            }
        })
    })
})