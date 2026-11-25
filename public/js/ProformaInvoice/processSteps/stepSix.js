$(function () {

    const driverInfoForm = (driverInfoCounter) => {
        return `
            <div class="card shadow border" style="margin-top: 3px">
                <div class="card-header d-flex justify-content-between align-items-center">
                     <h6 class="card-title">اطلاعات راننده</h6>
                     <i class="bx bx-trash text-danger font-medium-3 cursor-pointer removeRowButton"></i>
                </div>
                <div class="card-content border-top">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 mt-2">
                                <label>نام و نام خانوادگی راننده</label>
                                <input class="form-control" id="" name="driverInfo[${driverInfoCounter}][driver_full_name]">
                            </div>
                            <div class="col-md-3 mt-2">
                                <label>شماره تماس راننده</label>
                                <input class="form-control" id="" name="driverInfo[${driverInfoCounter}][driver_phone]">
                            </div>
                            <div class="col-md-3 mt-2">
                                <label>کدملی راننده</label>
                                <input class="form-control" id="" name="driverInfo[${driverInfoCounter}][driver_national_id]">
                            </div>
                            <div class="col-md-3 mt-2">
                                <label>بارنامه</label>
                                <input type="file" class="form-control" id="" name="driverInfo[${driverInfoCounter}][cargo_file]">
                            </div>
                            <div class="col-md-4 mt-2"></div>
                            <div class="col-md-4 mt-2">
                                

<div class="ir-plate-wrapper">
    <div class="ir-plate">
        <div class="ir-plate-country">
            <div class="ir-plate-flag">
                <span class="ir-flag-green"></span>
                <span class="ir-flag-white">
                    <i></i>
                </span>
                <span class="ir-flag-red"></span>
            </div>
            <div class="ir-plate-country-text">
                I.R.<br>
                IRAN
            </div>
        </div>
        <div class="ir-plate-main">
            <div class="ir-plate-number">
                <input
                    type="text"
                    class="ir-plate-input ir-plate-first"
                    maxlength="2"
                    inputmode="numeric"
                    placeholder="--"
                    autocomplete="off"
                    name="driverInfo[${driverInfoCounter}][plate][two_left_digit_plate]"
                    aria-label="دو رقم اول پلاک"
                >

                <!-- حرف پلاک -->
                <select class="ir-plate-select" aria-label="حرف پلاک" name="driverInfo[${driverInfoCounter}][plate][license_plate_letter]">
                    <option value="" selected disabled>-</option>
                    <option value="ا">ا</option>
                    <option value="آ">آ</option>
                    <option value="ب">ب</option>
                    <option value="پ">پ</option>
                    <option value="ت">ت</option>
                    <option value="ث">ث</option>
                    <option value="ج">ج</option>
                    <option value="چ">چ</option>
                    <option value="ح">ح</option>
                    <option value="خ">خ</option>
                    <option value="د">د</option>
                    <option value="ذ">ذ</option>
                    <option value="ر">ر</option>
                    <option value="ز">ز</option>
                    <option value="ژ">ژ</option>
                    <option value="س">س</option>
                    <option value="ش">ش</option>
                    <option value="ص">ص</option>
                    <option value="ض">ض</option>
                    <option value="ط">ط</option>
                    <option value="ظ">ظ</option>
                    <option value="ع">ع</option>
                    <option value="غ">غ</option>
                    <option value="ف">ف</option>
                    <option value="ق">ق</option>
                    <option value="ک">ک</option>
                    <option value="گ">گ</option>
                    <option value="ل">ل</option>
                    <option value="م">م</option>
                    <option value="ن">ن</option>
                    <option value="و">و</option>
                    <option value="ه">ه</option>
                    <option value="ی">ی</option>
                </select>

                <!-- سه رقم آخر -->
                <input
                    type="text"
                    class="ir-plate-input ir-plate-last"
                    maxlength="3"
                    inputmode="numeric"
                    placeholder="---"
                    autocomplete="off"
                    name="driverInfo[${driverInfoCounter}][plate][three_digit_plate]"
                    aria-label="سه رقم آخر پلاک"
                >

            </div>

            <span class="ir-plate-screw ir-screw-main-left"></span>
            <span class="ir-plate-screw ir-screw-main-right"></span>

        </div>

        <!-- کد شهر -->
        <div class="ir-plate-city">
            <div class="ir-plate-city-title">
                ایران
            </div>
            <input
                type="text"
                class="ir-plate-city-code"
                maxlength="2"
                inputmode="numeric"
                placeholder="--"
                autocomplete="off"
                name="driverInfo[${driverInfoCounter}][plate][two_right_digit_plate]"
                aria-label="کد شهر"
            >
            <span class="ir-plate-screw ir-screw-city"></span>
        </div>
    </div>
</div>


                            </div>
                            <div class="col-md-4 mt-2"></div>
                        </div>
                    </div>
                </div>
            </div>
        `
    }

    let driverInfoCounter = $(".exit_main_info").length + 1;
    $(".exitPartInfoAppendButton").on('click', function () {
        let partId = $(this).data('part');
        $(`#exit_main_info_${partId}`).append(driverInfoForm(driverInfoCounter))
        $(document).on('input', '.ir-plate-input, .ir-plate-city-code', function () {

            let value = $(this).val();

            // تبدیل اعداد انگلیسی به فارسی
            value = value.replace(/[0-9]/g, function (digit) {
                return '۰۱۲۳۴۵۶۷۸۹'[digit];
            });

            // تبدیل اعداد عربی به فارسی
            value = value.replace(/[٠-٩]/g, function (digit) {
                return '۰۱۲۳۴۵۶۷۸۹'[digit.charCodeAt(0) - 1632];
            });

            // حذف کاراکترهای غیرعددی
            value = value.replace(/[^۰-۹]/g, '');

            // محدودیت تعداد ارقام
            let maxLength = parseInt($(this).attr('maxlength'));

            value = value.substring(0, maxLength);

            $(this).val(value);

        });
        driverInfoCounter++;
    })

    $(".exit_main_info").on('click', '.removeRowButton', function () {
        if ($(this).data('cargoexitcarinfo') !== undefined) {
            let cargoExitCarInfoId = $(this).data('cargoexitcarinfo')
            swal.fire({
                icon: 'warning',
                title: '<h6>توجه !</h6>',
                text: 'با تایید حذف این اطلاعات حذف میشود و قابل بازگشت نیست',
                confirmButtonText: 'تایید',
                showDenyButton: true,
                denyButtonText: 'انصراف',
                preConfirm: () => {
                    $.ajax({
                        url: '/CargoExit/removeCargoExitInfo',
                        type: 'POST',
                        data: {
                            cargoExitCarInfoId
                        }, success: result => {
                            if (result == 'deleteSuccess') {
                                customAlert('success', 'حذف با موفقیت انجام شد')
                                $(this).closest('.card').slideUp()
                                setTimeout(function () {
                                    window.location.reload()
                                }, 1000)
                            } else {
                                customAlert('error', 'حذف با خطا مواجه شد', 1500)
                            }
                        }
                    })
                }
            })
        } else {
            $(this).closest('.card').remove()
        }
    })

    $(".exit_main_info").on('click', '.showCargoExitCarInfo', function () {
        let fileData = $(this).attr('src')
        swal.fire({
            width: '80vw',
            html: `<embed src="${fileData}" style="width: 100%;max-height: 90vh"">`,
            confirmButtonText: 'بستن',
        })
    })

})