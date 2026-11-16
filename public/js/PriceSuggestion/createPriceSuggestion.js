$(function () {
    $("#country_id").change(function () {
        let countryId = $(this).val();
        $("#city_id").empty().attr('disabled', true)
        $(this).getOptionsValue({
            urlAddress: '/states/getStatesFilterByCountry',
            dataSend: {
                countryId
            },
            callback: result => {
                $("#state_id").html(`<option selected disabled>یک استان انتخاب کنید</option>`)
                $.each(result, function (key, item) {
                    $("#state_id").append(`<option value="${item.id}">${item.title}</option>`)
                })
            }
        })
    })

    $("#state_id").change(function () {
        let value = $(this).val();
        $(this).getOptionsValue({
            urlAddress: '/cities/getFilterCities',
            dataSend: {
                value
            },
            callback: result => {
                $("#city_id").attr('disabled', false).html(`<option selected disabled>یک شهر انتخاب کنید</option>`)
                $.each(result, function (key, item) {
                    $("#city_id").append(`<option value="${item.id}">${item.title}</option>`)
                })
            }
        })
    })

    const countProductRow = () => {
        let count = 1;
        $("#mainProduct tr").each(function () {
            $(this).find('td').eq(0).text(count)
            count++;
        })
    }

    const sumAllRow = () => {
        let result = {
            sumRow: 0,
            sumDiscount: 0,
        }
        $("#mainProduct tr").each(function () {
            let sumRow = parseFloat($(this).find('td').eq(5).find('.productSumRow').val().replaceAll(',', ''));
            let discountAmount = parseFloat($(this).find('td').eq(5).find('.discountAmount').val().replaceAll(',', ''));
            if (!isNaN(sumRow)) {
                result.sumRow += sumRow;
            }
            if (!isNaN(discountAmount)) {
                result.sumDiscount += discountAmount
            }
        })

        $("#sumAllProductRow").text(result.sumRow.toLocaleString())
        $("#sumAllDiscountRow").text(result.sumDiscount.toLocaleString())
        return result;
    }

    const makeProductRow = (rowCounter) => {
        let brandId = $("#brand_id").val()
        $("#Products").getOptionsValue({
            urlAddress: "/Products/getProductDataFilterByBrand",
            dataSend: {
                brandId
            },
            callback: result => {
                $(`#product_id_${rowCounter}`).html(`<option selected disabled>انتخاب کنید</option>`)
                $.each(result, function (key, item) {
                    $(`#product_id_${rowCounter}`).append(`<option value="${item.id}" 
                        data-price="${item.unitPrice}"
                        data-unit="${item.unitName}"
                        >${item.title}</option>`).select2({
                        width: '100%'
                    })
                })
            }
        })
        return `
            <tr>
                <td class="border"></td>
                <td class="border">
                    <select class="form-control product_id" id="product_id_${rowCounter}" name="productList[${rowCounter}][product_id]"></select>
                </td>
                <td class="border">
                    <input class="form-control product_amount" readonly required id="" name="productList[${rowCounter}][product_amount]"/>
                </td>
                <td class="border">
                    <span>-</span>
                </td>
                <td class="border">
                    <input class="form-control product_unit_price" readonly required id="" name="productList[${rowCounter}][product_unit_price]"/>
                </td>
                <td class="border">
                    <div class="input-group">
                        <input class="form-control text-center productSumRow" value="0" readonly id="" name="">
                        <div class="input-group-append">
                            <span class="input-group-text font-small-2">ریال</span>
                        </div>
                    </div>
                    <input class="form-control discountType" type="hidden" readonly placeholder="نوع تحفیف" name="productList[${rowCounter}][discount_type]">
                    <div class="input-group" style="margin-top: 3px">
                        <div class="input-group-append">
                            <span class="input-group-text font-small-2">واحد تخفیف</span>
                        </div>
                        <input class="form-control discountUnitAmount text-center" readonly placeholder="واحد تخفیف" name="productList[${rowCounter}][discount_unit_amount]">
                    </div>
                    <div class="input-group" style="margin-top: 3px">
                        <div class="input-group-append">
                            <span class="input-group-text font-small-2">مجموع تخفیف</span>
                        </div>
                        <input class="form-control discountAmount text-center" readonly placeholder="مجموع تخفیف" name="productList[${rowCounter}][discount_amount]">
                        <div class="input-group-append">
                            <span class="input-group-text font-small-2">ریال</span>
                        </div>
                    </div>
                    <div class="input-group" style="margin-top: 3px">
                        <div class="input-group-append">
                            <span class="input-group-text font-small-2">
                                قیمت واحد پس از تخفیف
                            </span>
                        </div>
                        <input class="form-control text-center unitPriceAfterDiscount" readonly placeholder="قیمت واحد پس از تخفیف" name="productList[${rowCounter}][unit_price_after_discount]">
                        <div class="input-group-append">
                            <span class="input-group-text font-small-2">
                                ریال
                            </span>
                        </div>
                    </div>
                </td>
                <td class="border">
                    <div class="dropup">
                        <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="menu">
                        </span>
                        <div class="dropdown-menu" x-placement="bottom-start">
                            <a class="dropdown-item text-danger removeProductRowButton" style="cursor: pointer">
                                <i class="bx bx-trash-alt text-danger mr-1"></i>
                                حذف ردیف
                            </a>
                            <a class="dropdown-item text-primary discountButton" data-type="percentage" style="cursor: pointer;">
                                <i class="bx bxs-discount text-primary mr-1"></i>
                                تخفیف درصدی
                            </a>
                            <a class="dropdown-item text-secondary discountButton" data-type="cash" style="cursor: pointer;">
                                <i class="bx bx-money text-secondary mr-1"></i>
                                تخفیف ریالی
                            </a>
                            <a class="dropdown-item text-danger removeDiscountButton" style="cursor: pointer;display: none">
                                <i class="bx bx-x text-danger mr-1"></i>
                                حذف تخفیف
                            </a>
                        </div>
                    </div>
                </td>
            </tr>
        `
    }

    let mainProductCount = $("#mainProduct tr").length + 1;

    $("#addProductButton").on('click', function () {
        let brand = $("#brand_id").val()
        if (brand) {
            $("#mainProduct").append(makeProductRow(mainProductCount))
            countProductRow()
            mainProductCount++
        } else {
            customAlert('warning', 'برند را انتخاب کنید')
        }
    })

    $("#mainProduct").on('click', '.removeProductRowButton', function () {
        if ($(this).data('id') !== undefined) {
            swal.fire({
                icon: 'warning',
                title: '<h5>توجه !</h5>',
                text: 'بعد از حذف امکان بازگشت وجود ندارد',
                confirmButtonText: 'تایید',
                showDenyButton: true,
                denyButtonText: 'انصراف',
                preConfirm: () => {
                    $.ajax({
                        url: '/PriceSuggestion/removeProductRow',
                        type: 'POST',
                        data: {
                            id: $(this).data('id')
                        }, success: result => {
                            if (result === 'deleteSuccess') {
                                $(this).closest('tr').remove()
                                sumAllRow()
                                countProductRow()
                                customAlert('success', 'حذف با موفقیت انجام شد')
                            } else {
                                customAlert('error', 'خطا در حذف')
                            }
                        }
                    })
                }
            })
        } else {
            $(this).closest('tr').remove()
            sumAllRow()
            countProductRow()
        }
    })

    $("#mainProduct").on('change', '.product_id', function () {
        let $selectRow = $(this).closest('tr').find('td');
        let $selected = $(this).find(':selected');
        let unitPrice = $selected.data('price');
        let unitName = $selected.data('unit');
        $selectRow.eq(2).find('input').attr('readonly', false).priceInput();
        $selectRow.eq(3).find('span').text(unitName);
        $selectRow.eq(4).find('input').attr('readonly', false).val(unitPrice.toLocaleString()).priceInput();
        $selectRow.eq(5).find('.unitPriceAfterDiscount').val(unitPrice.toLocaleString());
    })

    $("#mainProduct").on('input', '.product_amount, .product_unit_price', function () {
        let $row = $(this).closest('tr');
        let productAmount = parseFloat($row.find('.product_amount').val().replaceAll(',', '')) || 0;
        let productUnitPrice = parseFloat($row.find('.unitPriceAfterDiscount').val().replaceAll(',', '')) || 0;
        let totalPrice = productAmount * productUnitPrice;
        $row.find('td').eq(5).find('.productSumRow').val(totalPrice.toLocaleString()).priceInput()
        sumAllRow()
    });

    $("#mainProduct").on('click', '.discountButton', function () {
        let $row = $(this).closest('tr');
        let discountType = $(this).data('type');
        let textDiscountType = $(this).text().trim();
        let unitPrice = parseFloat($row.find('td').eq(4).find('input').val().replaceAll(',', ''))
        let productAmount = parseFloat($row.find('td').eq(2).find('input').val());
        if (!unitPrice) {
            swal.fire({
                icon: 'warning',
                title: '<h6>توجه !</h6>',
                text: 'لطفا ابتدا یک محصول و قیمت واحد را وارد کنید',
                confirmButtonText: 'متوجه شدم'
            })
        } else {
            swal.fire({
                title: `<h6>${textDiscountType}</h6><hr>`,
                html: `
                <div class="input-group">
                    <input class="form-control" id="discountAmount">
                    <div class="input-group-append">
                        <span class="input-group-text">${((discountType == 'percentage') ? '%' : 'ریال')}</span>
                    </div>
                </div>
            `,
                confirmButtonText: 'ثبت',
                preConfirm: () => {
                    let discountAmount = parseFloat($("#discountAmount").val().replaceAll(',', ''))
                    if (!isNaN(discountAmount)) {
                        if (discountType == 'percentage') {
                            $("#discountAmount").priceInput(2)
                            $row.find('td').eq(5).find('.discountType').val(discountType)
                            $row.find('td').eq(5).find('.discountAmount').val((productAmount * (unitPrice * discountAmount) / 100).toLocaleString())
                            $row.find('td').eq(5).find('.unitPriceAfterDiscount').val((unitPrice - (unitPrice * discountAmount) / 100).toLocaleString())
                        }
                        if (discountType == 'cash') {
                            $("#discountAmount").priceInput()
                            $row.find('td').eq(5).find('.discountType').val(discountType)
                            $row.find('td').eq(5).find('.discountAmount').val((productAmount * discountAmount).toLocaleString())
                            $row.find('td').eq(5).find('.unitPriceAfterDiscount').val((unitPrice - discountAmount).toLocaleString())
                        }
                        $(this).closest('.dropdown-menu').find('.discountButton').hide()
                        $(this).closest('.dropdown-menu').find('.removeDiscountButton').show()
                        $row.find('td').eq(5).find('.discountUnitAmount').val(discountAmount.toLocaleString())
                    } else {
                        swalValidate('لطفا مقدار تخفیف را وارد کنید')
                    }
                    let unitPriceAfterDiscount = parseFloat($row.find('td').eq(5).find('.unitPriceAfterDiscount').val().replaceAll(',', ''))
                    $row.find('td').eq(5).find('.productSumRow').val((unitPriceAfterDiscount * productAmount).toLocaleString())
                    sumAllRow()
                }
            })
            if (discountType == 'percentage') {
                $("#discountAmount").priceInput(2)
            }
            if (discountType == 'cash') {
                $("#discountAmount").priceInput()
            }
        }
    })

    $("#mainProduct").on('click', '.removeDiscountButton', function () {
        let $row = $(this).closest('tr');
        let productAmount = parseFloat($row.find('td').eq(2).find('input').val());
        let unitPrice = parseFloat($row.find('td').eq(4).find('input').val().replaceAll(',', ''))
        $row.find('td').eq(5).find('.discountType').val('')
        $row.find('td').eq(5).find('.discountAmount').val('')
        $row.find('td').eq(5).find('.discountUnitAmount').val('')
        $row.find('td').eq(5).find('.unitPriceAfterDiscount').val(unitPrice.toLocaleString())
        $row.find('td').eq(5).find('.productSumRow').val((unitPrice * productAmount).toLocaleString())
        sumAllRow()
        $(this).closest('.dropdown-menu').find('.discountButton').show()
        $(this).closest('.dropdown-menu').find('.removeDiscountButton').hide()
    })

    $("#brand_id").change(function () {
        $("#mainProduct").empty()
        mainProductCount = $("#mainProduct tr").length;
    })

    sumAllRow()

})