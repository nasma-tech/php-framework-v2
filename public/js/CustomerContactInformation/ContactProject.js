$(function () {
    const makeProductRow = (counter) => {
        $(`#product_id_${counter}`).getOptionsValue({
            urlAddress: '/Products/getProductData', callback: result => {
                $.each(result, function (key, item) {
                    $(`#product_id_${counter}`).append(`<option value="${item.id}"><item className="title">${item.title}</item></option>`)
                })
            }
        })
        return `
            <tr>
                <td class="border">
                    <select class="form-control projectOptionsSelect carTipId select2" data-count="${counter}" id="product_id_${counter}" name="projectRequest[${counter}][product_id]">
                            <option selected disabled>یک مورد را انتخاب کنید</option>
                    </select>
                </td>
                <td class="border" width="150">
                    <input class="form-control requestAmount" dir="ltr" type="text"  data-count="${counter}" name="projectRequest[${counter}][request_amount]">
                </td>
                <td class="border">
                    <div class="dropup">
                        <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="menu">
                        </span>
                        <div class="dropdown-menu" x-placement="bottom-start">
                            <a class="dropdown-item text-danger removeRequestRow" data-count="1">
                                <i class="bx bx-trash text-danger mr-1"></i>
                                حذف
                            </a>
                            <a class="dropdown-item text-primary inquiryRequestRow" data-count="1">
                                <i class="bx bx-search text-primary mr-1"></i>
                                استعلام
                            </a>
                        </div>
                    </div>
                </td>
            </tr>
        `
    }
    let productCounter = $("#productRequestTableBody tr").length ;

    $("#productAppend").on('click',function () {
        $("#productRequestTableBody").append(makeProductRow(productCounter))
        $(".projectOptionsSelect").select2({
            width: '100%'
        })
        $(".requestAmount").numberInput()
        productCounter++
    })

    $("#productRequestTableBody").on('click','.removeRequestRow',function () {
        $(this).closest('tr').remove()
    })



})