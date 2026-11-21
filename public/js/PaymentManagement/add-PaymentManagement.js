$(function () {

    const documentInputs = (mainCounter, rowDocumentCounter) => {
        return `
            <div class="col-md-12 rowMainDocument" style="margin-top: 3px">
                <div class="input-group">
                    <input class="form-control" type="file" name="payment_documents[]">
                    <div class="input-group-append">
                        <button class="btn btn-sm btn-danger btn-icon bx bx-x removeDocumentRow" type="button"></button>
                    </div>
                </div>
            </div>
        `
    }

    const inputsMethodPayment = (counter, paymentMethod) => {
        switch (paymentMethod) {
            case 1: {
                return `
                    <div class="col-md-6 mainPaid" id="mainPaid_${counter}" style="margin-top: 3px">
                        <div class="card shadow">
                            <div class="card-header pt-1">
                                <h6 class="float-left" id="mainPaidTitle_${counter}"></h6>
                                <div class="badge badge-danger float-right removeCardButton" style="cursor: pointer;">
                                    <i class="bx bx-x"></i>
                                </div>
                            </div>
                            <div class="card-body">
                                <form id="mainPaidForm_${counter}" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" value="${csrfToken()}" name="csrfToken">
                                    <input type="hidden" readonly="readonly" id="payment_method_id_${counter}" name="payment_method_id">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>تاریخ چک</label>
                                            <input class="form-control" readonly="readonly" data-jdp id="cheque_deposit_date${counter}" name="cheque_deposit_date">
                                        </div>
                                        <div class="col-md-6">
                                            <label>شماره صیاد چک</label>
                                            <input class="form-control" dir="ltr" id="cheque_number_${counter}" name="cheque_number">
                                        </div>
                                        <div class="col-md-6 mt-2">
                                            <label>مبلغ چک</label>
                                            <div class="input-group">
                                                <input class="form-control" dir="ltr" id="cheque_amount_${counter}" name="cheque_amount">
                                                <div class="input-group-append">
                                                    <span class="input-group-text">ریال</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mt-2">
                                            <label>تصویر چک</label>
                                            <input class="form-control" type="file" id="cheque_document_${counter}" name="cheque_document">
                                        </div>
                                        <div class="col-md-12 mt-2">
                                            <label>توضیحات</label>
                                            <textarea class="form-control" id="cheque_description_${counter}" name="cheque_description" rows="6" style="resize: none"></textarea>
                                        </div>
                                        <div class="col-md-12 mt-2">
                                            <hr>
                                        <button class="btn btn-sm btn-primary float-right" id="submitPaymentButton_${counter}" data-counter="${counter}" type="button">ثبت چک</button>
                                        </div>
                                    </div>
                                </form>
                                   
                            </div>
                        </div>
                    </div>
                      `
            }
            default: {
                $.ajax({
                    url: '/BankAccount/getAllBankAccountList',
                    type: 'GET',
                    dataType: 'json',
                    success: result => {
                        if (result.length > 0) {
                            $.each(result, function (key, item) {
                                $("#bank_account_id_" + counter).append(`
                                    <option value="${item.id}">
                                        ${item.bankName} | 
                                        شعبه : ${item.branchName} | 
                                         حساب : ${item.bankAccountNumber}
                                    </option>
                                `)
                            })
                            $("#bank_account_id_" + counter).select2()
                        }
                    }
                })
                return `
                        <div class="col-md-6 mainPaid" id="mainPaid_${counter}" style="margin-top: 3px">
                        <div class="card shadow">
                            <div class="card-header pt-1">
                                <h6 class="float-left" id="mainPaidTitle_${counter}"></h6>
                                <div class="badge badge-danger float-right removeCardButton" style="cursor: pointer;">
                                    <i class="bx bx-x"></i>
                                </div>
                            </div>
                            <div class="card-body">
                                <form id="mainPaidForm_${counter}" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" value="${csrfToken()}" name="csrfToken">
                                    <input type="hidden" readonly="readonly" id="payment_method_id_${counter}" name="payment_method_id">
                                    <div class="row">
                                    <div class="col-md-12">
                                        <label>شماره حساب</label>
                                        <select class="form-control select2" name="bank_account_id" id="bank_account_id_${counter}"></select>
                                    </div>
                                    <div class="col-md-6 mt-2">
                                        <label>شماره پیگیری</label>
                                        <input class="form-control" dir="ltr" id="reference_no_${counter}" name="reference_no">
                                    </div>
                                    <div class="col-md-6 mt-2">
                                        <label>تاریخ واریز</label>
                                        <input class="form-control" readonly="readonly" data-jdp id="date_deposit_${counter}" name="date_deposit">
                                    </div>
                                    <div class="col-md-12 mt-2">
                                        <label>مبلغ</label>
                                        <div class="input-group">
                                            <input class="form-control" dir="ltr" id="amount_paid_${counter}" name="amount_paid">
                                            <div class="input-group-append">
                                                <span class="input-group-text">ریال</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mt-2">
                                        <label>توضیحات</label>
                                        <textarea class="form-control" rows="6" style="resize: none" id="payment_description_${counter}"
                                                  name="payment_description"></textarea>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="divider divider-left mt-5">
                                            <div class="divider-text" style="font-size: 12px">مستندات واریز</div>
                                        </div>
                                        <div class="badge badge-success float-left" id="addDocumentRow_${counter}" data-counter="${counter}" style="cursor: pointer">افزودن مستندات</div>
                                    </div>
                                    <div class="col-md-12 mt-2">
                                        <div class="row" id="mainDocumentsRow_${counter}" style="height: 200px;overflow-y: auto"></div>
                                    </div>
                                    <div class="col-md-12 mt-3">
                                    <hr>
                                        <button class="btn btn-sm btn-primary float-right" id="submitPaymentButton_${counter}" data-counter="${counter}" type="button">ثبت واریزی</button>
                                    </div>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                `
            }
        }
    }

    let counterCard = $(".mainPaid").length;
    $("#addPaymentRow").on('click', function () {
        const buttonsList = () => {
            $.ajax({
                url: '/PaymentMethod/getPaymentMethod',
                type: 'GET',
                dataType: 'json',
                success: result => {
                    if (result.length > 0) {
                        $("#mainButtons").html(`
                            <input type="hidden" readonly="readonly" id="payment_method_id">
                            <input type="hidden" readonly="readonly" id="payment_method_name">
                        `)
                        $.each(result, function (key, item) {
                            $("#mainButtons").append(`
                                <div class="col-md-6">
                                    <button class="btn btn-sm btn-secondary w-100 selectButton" id="selectButton_${item.id}" style="margin-top: 3px" data-select="${item.id}">${item.title}</button>
                                </div>                            
                            `)
                        })
                    }
                }
            }).done(function () {
                $(".selectButton").on('click', function () {
                    let buttonId = $(this).data('select')
                    $('.selectButton').each(function () {
                        $(this).removeClass('btn-success btn-secondary').addClass('btn-secondary')
                    })
                    $(this).removeClass('btn-secondary').addClass('btn-success')
                    $("#payment_method_id_" + counterCard).val(buttonId)
                    $("#payment_method_id").val(buttonId)
                    $("#payment_method_name").val($(this).text())
                })
            })
            return `
                <div class="row" id="mainButtons"></div>
            `
        }
        Swal.fire({
            title: '<h5>نحوه پرداخت</h5><hr>',
            html: buttonsList(),
            width: '40rem',
            confirmButtonText: 'تایید',
            showDenyButton: true,
            denyButtonText: 'انصراف',
            allowOutsideClick: () => {
                if (!$("#payment_method_id").val()) {
                    swalValidate('لطفا یک مورد را انتخاب کنید')
                    return false;
                }
            },
            allowEscapeKey: () => {
                if (!$("#payment_method_id").val()) {
                    swalValidate('لطفا یک مورد را انتخاب کنید')
                    return false;
                }
            },
            preConfirm: () => {
                if (!$("#payment_method_id").val()) {
                    swalValidate('لطفا یک مورد را انتخاب کنید')
                    return false;
                } else {
                    $("#mainRowPayment").append(inputsMethodPayment(counterCard, parseInt($("#payment_method_id").val())))
                    $("#mainPaidTitle_" + counterCard).text($("#payment_method_name").val())
                    $("#date_deposit" + counterCard).datePicker()
                    $("#cheque_deposit_date" + counterCard).datePicker()
                    $("#amount_paid_" + counterCard).priceInput()
                    $("#addDocumentRow_" + counterCard).on('click', function () {
                        let thisCounter = $(this).data('counter');
                        $("#mainDocumentsRow_" + thisCounter).append(documentInputs())
                        $(".removeDocumentRow").off('click').on('click', function () {
                            let removeDocumentRow = $(this)
                            removeDocumentRow.closest('.rowMainDocument').hide('slow')
                            setTimeout(function () {
                                removeDocumentRow.closest('.rowMainDocument').remove()
                            }, 1000)
                        })
                    })
                    $("#payment_method_id_" + counterCard).val($("#payment_method_id").val())
                    $("#submitPaymentButton_" + counterCard).on('click', function () {
                        let thisFormCounter = $(this).data('counter');
                        let form = $("#mainPaidForm_" + thisFormCounter);
                        let formData = new FormData(form[0])
                        $.ajax({
                            url: '/PaymentManagement/add',
                            type: 'POST',
                            data: formData,
                            processData: false,
                            contentType: false,
                            cache: false,
                            dataType: 'json',
                            success: result => {
                                if (result.status) {
                                    customAlert('success', 'با موفقیت ثبت شد')
                                    $("#mainPaid_" + thisFormCounter).hide('slow');
                                    setTimeout(function () {
                                        $("#mainPaid_" + thisFormCounter).remove()
                                    }, 1000)
                                } else {
                                    customAlert('error','خطا در ثبت')
                                }
                            }
                        })
                    })
                    $("#cheque_number_"+counterCard).numberInput(16)
                    $("#cheque_amount_"+counterCard).priceInput()
                    counterCard++
                }
            }
        }).then(function () {
            $(".removeCardButton").off('click').on('click', function () {
                let removeButton = $(this)
                swal.fire({
                    icon: 'question',
                    title: '<h6>از حدف رکورد اطمینان دارید؟</h6>',
                    text: 'بعد از حدف امکان بازگشت وجود ندارد',
                    confirmButtonText: 'انصراف',
                    showDenyButton: true,
                    denyButtonText: 'حذف',
                    preDeny: () => {
                        removeButton.closest('.mainPaid').hide('slow')
                        setTimeout(function () {
                            removeButton.closest('.mainPaid').remove()
                        }, 1000)
                    }
                })
            })
        })
    })
})