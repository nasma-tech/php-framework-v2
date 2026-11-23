$(function () {
    const editBody = (id, amount, enterDate, unitTitle) => {
        return `
            <div class="card">
                <div class="card-body">
                    <form id="mainForm">
                        <div class="row">
                            <div class="col-md-12">
                                <label for="amount">مقدار ورود</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" required name="amount" id="amount" value="${amount}">
                                    <div class="input-group-append">
                                        <span class="input-group-text">${unitTitle}</span>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="col-md-12 mt-1">
                                <label for="description">توضیحات</label>
                                <textarea class="form-control" name="description" id="description" rows="5"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        `
    }

    const deleteBody = (id) => {
        return `<div class="card">
            <div class="card-body">
                <form id="mainForm">
                    <div class="row">
                        <div class="col-md-12">
                            <label for="description">توضیحات</label>
                            <textarea class="form-control" name="description" id="description" rows="5"></textarea>
                        </div>
                    </div>
                </form>
            </div>
        </div>`
    }

    $(".editRow").on('click', function () {
        let id = $(this).data('id')
        let amount = $(this).data('amount')
        let enteDate = $(this).data('enter_date')
        let unitTitle = $(this).data('unit_title')
        let productId = $(this).data('product_id')

        swal.fire({
            title: `ویرایش ورود به انبار ${productId}`,
            width: '40vw',
            html: editBody(id, amount, enteDate, unitTitle),
            showDenyButton: true,
            denyButtonText: 'انصراف',
            confirmButtonText: 'تایید',
            preConfirm: () => {

                    let formData = new FormData($("#mainForm")[0])
                    formData.append('csrfToken', csrfToken())

                    swal.fire({
                        title: 'در انتظار تایید نهایی ',
                        icon: 'warning',
                        text: 'از انتخاب خود اطمینان دارید؟',
                        showDenyButton: true,
                        reverseButtons: true,
                        denyButtonText: 'انصراف',
                        confirmButtonText: 'تایید',
                        preConfirm: () => {
                            $.ajax({
                                url: `/EntryWarehouse/EntryWarehouseEdit/${id}`,
                                method: "POST",
                                data: formData,
                                processData: false,
                                contentType: false,
                                cache: false,
                                success: result => {
                                    handeOfAjaxJsonResponse(result)
                                }
                            })
                        }
                    })
            }
        })


        priceFormatWithDecimals("#amount")
    })

    $(".deleteRow").on('click', function () {
        let id = $(this).data('id')
        let productId = $(this).data('product_id')

        swal.fire({
            title: `حذف ورود به انبار ${productId}`,
            width: '35vw',
            html: deleteBody(id),
            showDenyButton: true,
            denyButtonText: 'انصراف',
            confirmButtonText: 'تایید',
            preConfirm: () => {
                let formData = new FormData($("#mainForm")[0])
                formData.append('csrfToken', csrfToken())

                swal.fire({
                    title: 'در انتظار تایید نهایی ',
                    icon: 'warning',
                    text: 'از انتخاب خود اطمینان دارید؟',
                    showDenyButton: true,
                    reverseButtons: true,
                    denyButtonText: 'انصراف',
                    confirmButtonText: 'تایید',
                    preConfirm: () => {
                        $.ajax({
                            url: `/EntryWarehouse/EntryWarehouseDelete/${id}`,
                            method: "POST",
                            data: formData,
                            processData: false,
                            contentType: false,
                            cache: false,
                            success: result => {
                                handeOfAjaxJsonResponse(result)
                            }
                        })
                    }
                })
            }
        })
        console.log(id)
    })

    $(".plates").on('click',function (){
        let data = $(this).data('text');

        data = typeof data === 'string' ? JSON.parse(data) : data;
        data = Array.isArray(data) ? data[0] : data;

        Swal.fire({
            title: '<i class="bx bx-car"></i> اطلاعات پلاک خودرو',
            html: `
        <div class="iran-plate-container" dir="ltr">

            <div class="iran-plate">

                <div class="plate-country">
                    <div class="iran-flag"></div>
                    <strong>I.R.</strong>
                    <strong>IRAN</strong>
                </div>

                <div class="plate-numbers">
                    <div class="plate-section">${data.first}</div>
                    <div class="plate-section plate-letter">${data.two}</div>
                    <div class="plate-section">${data.three}</div>
                </div>

                <div class="plate-code">
                    <strong>${data.four}</strong>
                    <span>ایران</span>
                    <div class="iran-emblem">☀</div>
                </div>

            </div>

            <div class="plate-details" dir="rtl">
                <div class="plate-detail">
                    <span>نوع خودرو</span>
                    <strong>${data.car_type}</strong>
                </div>
            </div>

        </div>
    `,
            confirmButtonText: 'تایید',
            customClass: {
                popup: 'iran-plate-swal',
                confirmButton: 'iran-plate-confirm'
            },
            buttonsStyling: false
        });
    })
    $(".file").on('click', function () {
        let data = $(this).data('text');
        let id = $(this).data('id');

        data = typeof data === 'string' ? JSON.parse(data) : data;
        data = Array.isArray(data) ? data[0] : data;

        let src = `/Storage/DirectEntryWarehouse/${id}/${data.fileAddress}`;

        Swal.fire({
            title: data.name,
            imageUrl: src,
            imageWidth: 500,
            imageAlt: data.description,
            text: data.description,
            showCloseButton: true,
            showConfirmButton: false
        });
    });

    $(".description").on('click', function () {
        let data = $(this).data('text');

        Swal.fire({
            title: 'توضیحات',
            text: data,
            confirmButtonText: 'تایید'
        });
    });
})