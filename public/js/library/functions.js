//function show image after select
const readImage = (input, showImageId) => {
    if (input.files && input.files[0]) {
        let reader = new FileReader();
        reader.onload = function (e) {
            $('#' + showImageId).attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
};


// tinymce editor create
const tinyEditor = (textAreaInput) => {
    tinymce.init({
        selector: textAreaInput,
        directionality: 'rtl',
        height: '300px',
        language: 'fa_IR',
        plugins: 'print preview table',
        menu: {tc: {title: 'TinyComments', items: 'addcomment showcomments deleteallconversations'}},
        toolbar: "undo redo | styleselect | fontselect | bold italic | alignleft aligncenter alignright alignjustify | outdent indent",
        toolbar_mode: 'sliding',
        contextmenu: 'link image imagetools table',
        font_formats: "tahoma=tahoma;iransans=primary-font",
    });
};

const tinyEditorGetValue = (editorId) => {
    return tinyMCE.get(editorId).getContent();
};

const tinyEditorSetValue = (tinyId, content) => {
    return tinyMCE.get(tinyId).setContent(content);
};

//alert
//success message
const successMessage = (defaultPage = 'main') => {
    let getLocation = window.location.href;
    swal.fire({
        icon: 'success', title: 'با موفقیت ذخیره شد', timer: 3000, allowOutsideClick: () => {
            if (getLocation.match('editIndex')) {
                let removeIdUrl = getLocation.replace('editIndex/' + getLocation.split('/')[5], '');
                window.location.href = removeIdUrl + defaultPage;
            } else {
                window.location.href = defaultPage;
            }
        }, didClose: () => {
            if (getLocation.match('editIndex')) {
                let removeIdUrl = getLocation.replace('editIndex/' + getLocation.split('/')[5], '');
                window.location.href = removeIdUrl + defaultPage;
            } else {
                window.location.href = defaultPage;
            }
        }, confirmButtonText: 'بستن', preConfirm: () => {
            if (getLocation.match('editIndex')) {
                let removeIdUrl = getLocation.replace('editIndex/' + getLocation.split('/')[5], '');
                window.location.href = removeIdUrl + defaultPage;
            } else {
                window.location.href = defaultPage;
            }
        }
    });
};
//error message
const errorMessage = (errorText = 'عملیات با خطا مواجه شد') => {
    swal.fire({
        icon: 'error', title: errorText, timer: 3000, confirmButtonText: 'بستن'
    });
};

const customSwalFire = (icon = 'success', title = '') => {
    swal.fire({
        icon: icon, title: title, timer: 3000, allowOutsideClick: () => {
            window.location.reload();
        }, didClose: () => {
            window.location.reload();
        }, confirmButtonText: 'بستن', preConfirm: () => {
            window.location.reload();
        }
    });
};

const buttonLoading = (buttonInput, text = '', disabled = true) => {
    $(buttonInput).attr('disabled', disabled).html(`<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> ` + text)
}
const buttonLoadingOff = (buttonInput, text, disabled = false) => {
    $(buttonInput).attr('disabled', disabled).html(text)
}


const customAlert = (icon = 'success', title = '', timerShow = 3000) => {
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: timerShow,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
        }
    });
    Toast.fire({
        position: 'top-left', icon: icon, title: title
    });
};

//active or deactive main button
const activeOrDeactive = (button, urlAction, resultCallBack) => {
    $(this).attr('disabled', true);
    $(button).on('click', function () {
        swal.fire({
            icon: 'question', title: 'از تغییر وضعیت اطمینان دارید؟', allowOutsideClick: () => {
                return false;
            }, confirmButtonText: 'بله', showCancelButton: true, cancelButtonText: 'انصراف', preConfirm: () => {
                let id = $(this).data('id');
                $.ajax({
                    url: urlAction, type: 'POST', data: {
                        id
                    }, success: result => {
                        if (result === resultCallBack) {
                            $(this).attr('disabled', false);
                            if ($(this).hasClass('btn-success')) {
                                $(this).removeClass('btn-success');
                                $(this).addClass('btn-danger');
                                $(this).children('i').removeClass('bx-check');
                                $(this).children('i').addClass('bx-block');
                                $(this).attr('data-original-title', 'غیرفعال');
                            } else if ($(this).hasClass('btn-danger')) {
                                $(this).removeClass('btn-danger');
                                $(this).addClass('btn-success');
                                $(this).children('i').removeClass('bx-block');
                                $(this).children('i').addClass('bx-check');
                                $(this).attr('data-original-title', 'فعال');
                            }
                        }
                    }
                });
            }
        }).then((dismiss) => {
            if (dismiss.isDismissed) {
                $(this).attr('disabled', false);
            }
        });
    });
};


//for show top url and change url
const changeUrl = (url) => {
    window.history.pushState('', '', url);
}
const goToUrl = (urlAddress, loadScript = []) => {
    $.ajax({
        url: urlAddress, success: result => {
            $(".app-content").html(result)
        }
    }).done(function () {
        if (loadScript.length > 0) {
            loadScript.forEach(function (item) {
                $.getScript(item)
            })
        }
    })
}


//map


//get price unit name
const priceUnitName = () => {
    $.ajax({
        url: '/appSetting/getUnitePrice', type: 'POST', success: result => {
            $(".priceUnit").html(result);
        }
    });
};

//convert AD date To Persian Date
const convertADateToPersianDate = (date = '2022/10/20') => {
    let originalDate;
    if (date.search('-') !== -1) {
        originalDate = date.replaceAll('-', '/');
    } else {
        originalDate = date.replaceAll('-', '/');
    }
    return new Date(originalDate).toLocaleDateString('fa-IR-u-nu-latn');
};

//convert hex to RGB Color
const hexToRgb = (hex) => {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16), g: parseInt(result[2], 16), b: parseInt(result[3], 16)
    } : null;
};
//get color name by hex code
const hexToColorName = (hex) => {
    let result = ntc.name(hex);
    return result[1];
};

//lock space
const lockSpace = (input) => {
    $(input).keypress(function (e) {
        if (e.which === 32) return false;
    });
};

//key press event
const keyPressEvent = (accessKeyCode, action) => {
    $(document).keypress(function (e) {
        if (e.which == accessKeyCode) {
            action();
        }
    });
};

//table
const destroyDataTable = (input) => {
    $(input).DataTable().destroy()
}

const dataTable = (input, dom = "Bfrtip", paging = true, info = true, showButton = true) => {

    let buttonsData = (showButton ? [{
        text: 'کپی', extend: 'copyHtml5', exportOptions: {
            columns: [0, ':visible']
        }
    }, {
        text: 'اکسل', extend: 'excelHtml5', exportOptions: {
            columns: ':visible'
        }, customize: function (xlsx) {
            var source = xlsx.xl['workbook.xml'].getElementsByTagName('sheet')[0];
            source.setAttribute('name', 'Roles');
        }

    }, {
        text: 'چاپ', extend: 'print', exportOptions: {
            columns: ':visible'
        }
    }, {
        text: 'فیلتر ستون', extend: 'colvis', exportOptions: {
            columns: ':visible'
        }
    }] : [])

    return $(input).DataTable({
        order: [[0, 'desc']],
        dom: dom,
        paging: paging,
        info: info,
        "language": {
            "sEmptyTable": "هیچ داده ای در جدول وجود ندارد",
            "sInfo": "نمایش _START_ تا _END_ از _TOTAL_ رکورد",
            "sInfoEmpty": "نمایش 0 تا 0 از 0 رکورد",
            "sInfoFiltered": "(فیلتر شده از _MAX_ رکورد)",
            "sInfoPostFix": "",
            "sInfoThousands": ",",
            "sLengthMenu": "نمایش _MENU_ رکورد",
            "sLoadingRecords": "در حال بارگزاری...",
            "sProcessing": "در حال پردازش...",
            "sSearch": "جستجو: ",
            "sZeroRecords": "رکوردی با این مشخصات پیدا نشد",
            "oPaginate": {
                "sFirst": "ابتدا", "sLast": "انتها", "sNext": "بعدی", "sPrevious": "قبلی"
            },
            "oAria": {
                "sSortAscending": ": فعال سازی نمایش به صورت صعودی",
                "sSortDescending": ": فعال سازی نمایش به صورت نزولی"
            }
        }, buttons: buttonsData
    });
};

//mask
const maskInput = (input, maskPattern, placeHolder = '') => {
    //pattern 9999 write
    let Inputmask = {
        init: function () {
            $(input).inputmask("mask", {
                mask: maskPattern, placeholder: placeHolder
            });
        }
    };
    jQuery(document).ready(function () {
        Inputmask.init();
    });
};

//close modal in jquery
const closeModal = (input) => {
    $(input).modal('toggle');
};


//generate random
const randomGenerate = (length, type = 'mixed') => {
    let result = '';
    let characters = '';
    switch (type) {
        case "mixed":
            characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-=~!@#$%^&*()_+./<>?;:[]{}|';
            break;
        case "number":
            characters = '0123456789';
            break;
        case "stringMixed":
            characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
            break;
        case "capitalString":
            characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            break;
        case "smallString":
            characters = 'abcdefghijklmnopqrstuvwxyz';
            break;
        case "character":
            characters = '-=~!@#$%^&*()_+./<>?;:[]{}|';
            break;
    }

    let charactersLength = characters.length;
    let counter = 0;
    while (counter < length) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
        counter += 1;
    }
    return result;
};

//get my ip
const myIp = () => {
    $.getJSON("https://api.ipify.org/?format=json", function (e) {
        console.log(e.ip);
    });

};

const getIpLocation = (ipAddress) => {
    $.getJSON("http://ip-api.com/json/" + ipAddress, function (e) {
        console.log(e);
    });
};

//convert date
const convertDate = (date = "2018-09-10") => {
    let date1 = new Date(date);
    let options = {year: 'numeric', month: 'numeric', day: 'numeric'};
    return date1.toLocaleDateString('fa-IR', options);
};

const loader = () => {
    return `
        <div id="l_loading">
            <div class="spinner-border" style="display: block;margin: 0 auto;" role="status">
                <span class="sr-only">در حال بارگذاری ...</span>
            </div>
        </div>
        `;
};

//just copy body
const cardLoader = (input) => {
    var $white = '#fff';
    var block_ele = $(input).closest('.card');
    $(block_ele).block({
        message: '<div class="semibold"><span class="bx bx-reset icon-spin text-left align-middle" style="padding-bottom:1.75px"></span>&nbsp; لطفا چند لحظه صبر کنید ...</div>',
        fadeIn: 1000,
        fadeOut: 1000,
        overlayCSS: {
            backgroundColor: $white, opacity: 0.8, cursor: 'wait'
        },
        css: {
            border: 0, padding: '10px 15px', color: $white, width: 'auto', backgroundColor: '#333'
        }
    });
    //unblock loader this code
    //you can under code use done ajax
    // $(block_ele).unblock();
};

const unblockCardLoader = (input) => {
    $(input).closest('.card').unblock();
};


// const filterDate = (fistId, secondId) => {
//     $("#" + fistId).attr('readonly', true);
//     $("#" + fistId).datepicker({
//         dateFormat: "yy/mm/dd",
//         showOtherMonths: true,
//         selectOtherMonths: false,
//         changeYear: true,
//         changeMonth: true,
//         maxDate: new Date(),
//         onSelect: result => {
//             $("#" + secondId).removeClass('hasDatepicker').val('').attr('readonly', true);
//             $("#"+secondId).val($("#"+fistId).val())
//             $("#" + secondId).datepicker({
//                 dateFormat: "yy/mm/dd",
//                 showOtherMonths: true,
//                 selectOtherMonths: false,
//                 changeYear: true,
//                 changeMonth: true,
//                 minDate: result
//             });
//         }
//     });
// };

const filterDate = (fistId, secondId) => {
    $("#" + fistId).attr('readonly', true);
    $("#" + fistId).datepicker({
        dateFormat: "yy/mm/dd",
        showOtherMonths: true,
        selectOtherMonths: false,
        changeYear: true,
        changeMonth: true, // maxDate: new Date(),
        onSelect: result => {
            $("#" + secondId).removeClass('hasDatepicker').val('').attr('readonly', true);
            $("#" + secondId).datepicker({
                dateFormat: "yy/mm/dd",
                showOtherMonths: true,
                selectOtherMonths: false,
                changeYear: true,
                changeMonth: true,
                minDate: result
            });
        }
    });
};
const filterDate1 = (element, fromDate = '', endDate = '') => {
    $("#" + element).removeClass('hasDatepicker').val('').attr('readonly', true);
    $("#" + element).datepicker({
        dateFormat: "yy/mm/dd", showOtherMonths: true, selectOtherMonths: false, changeYear: true, changeMonth: true
        // minDate:fromDate,
        // maxDate:endDate
    });
}

const diffTime = (firstTime, secondTime) => {
    function toTime(theTime) {
        return Date.parse('1970-01-01 ' + theTime.substr(0, 8)) / 1000 + (theTime.includes('PM') && (12 * 60 * 60));
    }

    let d = toTime(secondTime) - toTime(firstTime);
    return d >= 0 ? new Date(0, 0, 0, 0, 0, d).toTimeString().substr(0, 8) : '';
};

const copyToClipboard = (input) => {
    let $temp = $("<input>");
    $("body").append($temp);
    $temp.val(input.text()).select();
    document.execCommand("copy");
    $temp.remove();
    customAlert('success', 'کپی شد !', 1500);
};

const APP_URL = () => {
    return $("#APP_URL").val();
};

//date picker auto actions
//tip : just input name has date key word
const datePickerSelect = () => {
    $('input').each(function () {
        let name = $(this).attr('name');
        if (name) {
            if (name.search('date') !== -1) {
                $(this).attr('readonly', true);
                $(this).datepicker({
                    dateFormat: "yy/mm/dd", showOtherMonths: true, selectOtherMonths: false,
                });
            }
        }
    });
};

function detaileShowAsModal(elem) {
    let d = $(elem).parents('tr').attr('data-list').replaceAll('|', ',').split(',');
    let htm = '<div style="padding: 5px;border: 1px solid #ccca;border-radius: 5px;">';
    for (let i = 0; i < d.length; i++) {
        if (d[i].trim() !== '0' && d[i].trim() !== '') htm += '<span class="userrequest-info-header mb-1">ساعت ثبت شده<i style="padding: 0 1px">' + (i + 1) + '</i>' + ' :</span>' + '<i class="userrequest-info-data mb-1">' + d[i] + '</i>';
    }
    htm += '</div>';
    Swal.fire({
        title: "<h5>جزئیات تردد روز" + "<u style='color: blue;margin: 0 10px;'> " + $(elem).parents('tr').find('td').eq(1).text() + "</u>&nbsp;&nbsp;تاریخ  " + "<u style='color: blue;margin: 0 10px;'>" + $(elem).parents('tr').find('td').eq(2).text() + "</u>" + "</h5>",
        html: htm
    });

}

const datePickerSelectByInput1 = (input, minDateShow = '') => {
    $(input).attr('readonly', true);
    $(input).datepicker({
        dateFormat: "yy/mm/dd", showOtherMonths: true, selectOtherMonths: false, changeYear: true, changeMonth: true
        // minDate: minDateShow
    });
};
const datePickerSelectByInput = (input, minDateShow = '') => {
    $(input).attr('readonly', true);
    $(input).datepicker({
        dateFormat: "yy/mm/dd",
        showOtherMonths: true,
        selectOtherMonths: false,
        changeYear: true,
        changeMonth: true,
        minDate: minDateShow
    });
};


const datePickerMaxDateSelectByInput = (input, minDateShow = '') => {
    $(input).attr('readonly', true);
    $(input).datepicker({
        dateFormat: "yy/mm/dd",
        showOtherMonths: true,
        selectOtherMonths: false,
        changeYear: true,
        changeMonth: true,
        maxDate: minDateShow
    });
};

const getTdValue = (tableId, cellNumber = 0) => {
    return $("#" + tableId).find("td").eq(cellNumber).html();
};

const removeDuplicatesOptionValue = (selectInput) => {
    $(selectInput).find('option').each(function () {
        $(this).siblings('[value="' + this.value + '"]').remove();
    });
};

//modal event
//just copy to use
const showModalEvent = (modalId, functionMethod) => {
    $(modalId).on('shown.bs.modal', function (e) {
        return functionMethod;
    });
};

const closeModalEvent = (modalId, functionMethod) => {
    $(modalId).on('hidden.bs.modal', function (e) {
        return functionMethod;
    });
};

const convertJalaliToGregorian = (date = "1402/01/27") => {
    let split = date.split('/');
    if (split.length === 3) {
        return jalali_to_gregorian(parseInt(split[0]), parseInt(split[1]), parseInt(split[2]));
    }
    return null
};

const updateClock = () => {
    function pad(n) {
        return (n < 10) ? '0' + n : n;
    }

    var now = new Date();
    var s = pad(now.getUTCHours()) + ':' + pad(now.getUTCMinutes()) + ':' + pad(now.getUTCSeconds());

    $('#clock').html(s);

    var delay = 1000 - (now % 1000);
    setTimeout(updateClock, delay);
};

// const swalValidate = (text) => {
//     Swal.showValidationMessage(text);
// };

const formValidator = (formId) => {
    let checkOut;
    $("#" + formId).find(':input').each(function () {
        if (typeof $(this).attr('required') !== 'undefined') {
            if ($(this).attr('required', true)) {
                if ($(this).val() === '') {
                    $(this).addClass('is-invalid');
                    $(this).parent('div').addClass('has-error');
                } else {
                    $(this).removeClass('is-invalid');
                    $(this).addClass('is-valid');
                    $(this).parent('div').removeClass('has-error');
                }
                if ($(this).prop("tagName") === "SELECT") {
                    if ($(this).val() == null) {
                        $(this).parent().removeClass('not-error');
                        $(this).parent().addClass('has-error');
                    } else {
                        $(this).parent().removeClass('has-error');
                        $(this).parent().addClass('not-error');
                    }
                }
            }
        }
        if ($(this).hasClass('is-invalid') || $(this).parent().hasClass('has-error')) {
            swal.fire({
                icon: 'warning',
                title: 'توجه !',
                text: 'لطفا موارد را با دقت پر کنید',
                timer: 3000,
                confirmButtonText: 'بستن'
            });
            checkOut = 1;
        }
        //email validate
        if ($(this).attr('type') == 'email') {
            if ($(this).val().search('@') == -1) {
                $(this).addClass('is-invalid');
                swal.fire({
                    icon: 'warning',
                    title: 'توجه !',
                    text: 'آدرس ایمیل اشتباه است',
                    timer: 3000,
                    confirmButtonText: 'بستن'
                });
                checkOut = 1;
            } else {
                $(this).removeClass('is-invalid').addClass('is-valid');
            }
        }
    });
    return checkOut;
};

const inArray = (param, array = []) => {
    let find = 0;
    if (jQuery.inArray(param, data) != -1) {
        find = 1;
    }
    return find;
};
const fillFakeInput = (formId) => {
    let textArray = 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد';
    let emailArray = 'test saman ali reza pish trs';
    $("#" + formId).find(':input').each(function () {
        if ($(this).attr('type') == 'text' && !$(this).is('[readonly]')) {
            $(this).val(textArray.split(' ')[Math.floor((Math.random() * textArray.split(' ').length) + 1)]);
        }
        if ($(this).attr('type') == 'email') {
            $(this).val(emailArray.split(' ')[Math.floor((Math.random() * emailArray.split(' ').length) + 1)] + '@gmail.com');
        }
    });
};
const firstStringToUpperCase = (string) => {
    let str = string;
    str = str.toLowerCase().replace(/\b[a-z]/g, function (letter) {
        return letter.toUpperCase();
    });
    return str;
};

const checkNumber = (x) => {
    if (typeof x == 'number' && !isNaN(x)) {
        if (Number.isInteger(x)) {
            return 'integer'
        } else {
            return 'float';
        }
    } else {
        return 'notANumber'
    }
}

const checkHasAttr = (input, attrName) => {
    let attr = $(input).attr(attrName);
    return typeof attr != 'undefined' && attr != false;
}

const getFileSuffix = (fileName) => {
    return fileName.split('.').pop()
}

const showFilesBySuffix = (filePath) => {
    let file = getFileSuffix(filePath);
    if (file == 'pdf') {
        return `<embed src="${filePath}" class="w-100" height="600px" />`
    }
    let imageSuffixList = ['jpg', 'png', 'jpeg',];
    if (inArray(file, imageSuffixList)) {
        return `<img src="${filePath}" class="w-100" height="600px" alt="">`
    }
}

//webSocket
const webSocket = () => {
    $(document).ready(function () {
        let conn = new WebSocket('ws://localhost:8080');
        let chatForm = $('#chatForm');
        let userMessage = $("#message");
        let msgList = $('.msg-list');
        chatForm.on('submit', function (e) {
            e.preventDefault();
            let message = userMessage.val();
            conn.send(message);
            msgList.prepend("<li style='color:blue;'>" + message + "</li>");
        });
        conn.onopen = function (e) {
            console.log("Connection stablished");
            conn.onmessage = function (e) {
                if ($("#userId").val() == 1) {
                    console.log(e.data);
                    msgList.prepend("<li style='color:red;'>" + e.data + "</li>");
                }
            }
        }

        conn.onmessage = function (e) {
            console.log(e.data);
            msgList.prepend("<li style='color:red;'>" + e.data + "</li>");
        }
    });
}

const getUserInfo = () => {
    return sessionStorage.getItem('userInfo')
}
const csrfToken = () => {
    return $("input[name=csrfToken]").val();
}

const notificationSound = () => {
    let myAudio = new Audio(APP_URL() + '/Storage/sound/notification.mp3')
    myAudio.play()
}

const socketJs = (status, params = {}) => {
    let userIdLogin = $("#userLogInId").val();
    if (Object.keys(params).length > 0) {
        let make = '';
        let count = 1;
        $.each(params, function (key, item) {
            $.each(item, function (k, i) {
                if (count == Object.keys(item).length) {
                    make += k + '=' + i;
                } else {
                    make += k + '=' + i + '&';
                }
                count++
            })
        })
        return new WebSocket('ws://172.20.111.11?userId=' + userIdLogin + '&status=' + status + '&' + make);
    } else {
        return new WebSocket('ws://172.20.111.11?userId=' + userIdLogin + '&status=' + status);
    }
}

const afterLoadAjax = (functionMain) => {
    $(document).ajaxStop(functionMain());
}

const calcHours = (timeArray = []) => {
    let hour = 0;
    let minute = 0;
    let second = 0;
    $.each(timeArray, function (key, item) {
        if (item) {
            let i = item.split(':');
            let hourEach = parseInt(i[0]);
            let minuteEach = parseInt(i[1]);
            let secondEach = i[2] !== undefined ? parseInt(i[2]) : 0;
            hour += hourEach;
            minute += minuteEach;
            second += secondEach;
            if (minute >= 60) {
                hour += 1;
                minute = minute - 60;
            }
            if (second >= 60) {
                minute += 1;
                second = second - 60;
            }
        }
    })

    if (second) return ((hour < 10) ? '0' + hour : hour) + ':' + ((minute < 10) ? '0' + minute : minute) + ':' + ((second < 10) ? '0' + second : second); else return ((hour < 10) ? '0' + hour : hour) + ':' + ((minute < 10) ? '0' + minute : minute);
}

const getContractText = (type = '') => {
    switch (type) {
        case 'مدت معین': {
            return `<p><strong>حقوق و مزاياي كارگر:</strong>بصورت ماهانه به شماره شبا [sheba_number] توسط كارفرما يا نماينده قانوني وي پرداخت مي گردد</p>
                <p><strong>بيمه :</strong> به موجب ماده (148) قانون كار، كارفرما مكلف است كارگر را نزد سازمان تأمين اجتماعي بيمه نمايد </p>
                <p><strong>عيدي و پاداش سالانه :</strong> به موجب ماده واحده قانون مربوط به تعيين عيدي و پاداش سالانه كارگران شاغل در
                    كارگاه هاي مشمول قانون كار- مصوب 1370/12/06 مجلس شواري اسلامي، به ازاي يك سال كار معادل شصت روز مزد مبنا (تا سقف نود روز حداقل مزد روزانه قانوني كارگران ) به عنوان عيدي و پاداش سالانه به كارگر پرداخت
                    مي شود. براي كار كمتر از يك سال، ميزان عيدي و پاداش و سقف مربوط به نسبت محاسبه خواهد شد.</p>
                <p><strong>حق سنوات يا مزاياي پايان كار:</strong>به هنگام فسخ يا خاتمه قرارداد كار، حق سنوات مطابق قانون و مصوبه
                    مورخ 1387/08/25 مجمع تشخيص مصلحت نظام به نسبت كاركرد كارگر پرداخت مي شود</p>
                <p>اين قرارداد در چهار نسخه تنظيم مي شود كه يك نسخه نزد كارفرما ، يك نسخه نزد كارگر ، يك نسخه به تشكل كارگري (در صورت وجود) و يك نسخه نيز توسط كارفرما از طريق نامه الكترونيكي يا اينترنت و يا ساير طرق به اداره تعاون، كار و رفاه اجتماعي محل تحويل مي شود</p>
                <p>کلیه مکاتبات، اخطارها ،اعلانات از طریق پست الکترونیکی به کارمند ارسال و طبق توافق طرفین به منزله ی ابلاغ قانونی محسوب می شود </p>`;
        }
        case 'مشاوره': {
            return `<p><strong>تبصره 1:</strong>کارفرما می تواند با اعلام قبلی از طریق پیامک یا ابلاغ کتبی (ظرف مدت یکماه)نسبت به فسخ قرارداد اقدادم نماید و مشاور حق هیچ گونه اعتراضی نخواهد داشت.</p>
                <p><strong>حق الزحمه:</strong>حق الزحمه مشاور بر اساس حجم فعالیت های اجرایی و اطلاعات کار ایشان محاسبه و پس از درخواست مشاور و متعاقب تائیدیه مدیریت به حساب و حسابهای اعلامی توسط مشاور،واریز خواهد شد.</p>
                <p><strong>تبصره 2:</strong>سقف پرداختی به مشاور [FeeNum] میلیون ریال([FeeNumString]) در ماه بصورت خالص مورد توافق گردید</p>
                <p>بدیهی است که هر وایز به منزله تسویه حساب عملکرد مشاور تا زمان صورت وضعیت مورد توافق خواهد بود.</p>
                <p><strong>سایر شروط و تعهدات مشاور:</strong>مشاور می بایست حداکثر تلاش خود را در جهت انجام موضوع قرارداد به خدمت بگیرد.</p>
                <p><strong>محل اجرا:</strong>[companyAddress]</p>`;
            break;
        }
    }
    return '';
}

function secondsToTime(seconds) {
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    return (hours < 10 ? '0' + hours : hours) + ':' + (minutes < 10 ? '0' + minutes : minutes);
}

const checkNumberIntORFloat = (numberInt, toFixNumberFloat = 4) => {
    if (checkNumber(numberInt) == 'float') {
        return numberInt.toFixed(toFixNumberFloat);
    } else {
        return numberInt;
    }
}

const autoTab = (currentInput, targetInput, length) => {
    if ($(currentInput).val().length == length) {
        $(targetInput).focus();
    }
}
const checkIsSet = (value) => {
    return typeof value !== 'undefined';
}

const select2WorkModal = (input, modalInput) => {
    $(input).select2({
        dropdownParent: $(modalInput)
    });
}

const addErrorAnimate = (input) => {
    $(input).addClass('is-invalid animate__animated animate__headShake animate__infinite')
}
const removeErrorAnimate = (input) => {
    $(input).removeClass('is-invalid animate__animated animate__headShake animate__infinite')
}

const imagePayment = (imageSrc, paymentDescription) => {
    let extension = imageSrc.split('.')
    return `${(extension.slice(-1) == "pdf" ? `<embed src="${imageSrc}" alt="" style="width: 100%;height: 80vh">` : `<div style="max-height: 75vh;overflow: auto"><img src="${imageSrc}" alt=""></div>`)}<h6 class="text-center">توضیحات  : ${paymentDescription}</h6>`
}

const notification = (title, message, goToUrl = '', iconUrl = '', imageUrl = '', withSound = false) => {
    if (Notification.permission === 'granted') {
        const notification = new Notification(title, {
            body: message, icon: iconUrl, image: imageUrl, requireInteraction: true, timestamp: Date.now()
        });
        if (withSound) {
            notificationSound()
        }
        if (goToUrl) {
            notification.onclick = function () {
                window.open(goToUrl, "_blank");
            };
        }
    } else if (Notification.permission === 'default') {
        Notification.requestPermission().then(permission => {
            if (permission === 'granted') {
                const notification = new Notification(title, {
                    body: message, icon: iconUrl, image: imageUrl, requireInteraction: true, timestamp: Date.now()
                });
                if (withSound) {
                    notificationSound()
                }
                if (goToUrl) {
                    notification.onclick = function () {
                        window.open(goToUrl, "_blank");
                    };
                }
            }
        });
    }
};

// const socket = new WebSocket('wss://172.20.111.11/ws/');

const arrayUnique = (array) => {
    array.sort();
    return $.unique(array);
}

const convertObjectToArray = (object) => {
    return Object.keys(object).map(key => object[key])
}

const convertPersianToEnglishNumbers = (input) => {
    const persianNumbers = [/۰/g, /۱/g, /۲/g, /۳/g, /۴/g, /۵/g, /۶/g, /۷/g, /۸/g, /۹/g];
    const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    let output = input;
    for (let i = 0; i < persianNumbers.length; i++) {
        output = output.replace(persianNumbers[i], englishNumbers[i]);
    }
    return output;
}


//new
$.fn.getOptionsFilter = function (urlAddress, method = 'GET', callback) {
    $(this).on('change', function () {
        let value = $(this).val()
        $.ajax({
            url: urlAddress, type: method, data: {value}, success: result => {
                if (callback) {
                    if (result) {
                        callback(JSON.parse(result));
                    }
                }
            }
        })
    })
};

$.fn.englishInput = function (spaceLock = true) {
    $(this).attr('dir', 'ltr')
    $(this).on('keypress', function () {
        let ew = event.which;
        if (ew === 32) return !spaceLock;
        if (48 <= ew && ew <= 57) return true;
        if (65 <= ew && ew <= 90) return true;
        return 97 <= ew && ew <= 122;
    });
}

$.fn.numberInput = function (Length = 100, showAlert = true) {
    $(this).attr({
        maxLength: Length, dir: 'ltr'
    });
    $(this).on('keypress', function (e) {
        if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
            if (showAlert) {
                customAlert('warning', 'مقدار ورودی باید فقط عدد باشد', 3000)
            }
            return false;
        }
    });
}

$.fn.numberInputAndDecimal = function () {
    $(this).on("input", function () {
        let value = $(this).val();
        if (!value) {
            $(this).val("");
            return;
        }

        // فقط اعداد و نقطه مجاز، حذف بقیه کاراکترها
        value = value.replace(/[^0-9.]/g, "");

        // فقط یک نقطه مجاز
        const firstDotIndex = value.indexOf(".");
        if (firstDotIndex !== -1) {
            // حذف بقیه نقطه‌ها
            value = value.slice(0, firstDotIndex + 1) + value.slice(firstDotIndex + 1).replace(/\./g, "");
        }

        // حذف کاماهای قبلی برای پردازش
        value = value.replace(/,/g, "");

        if (value.includes(".")) {
            const [intPart, decPart] = value.split(".");

            const formattedInt = intPart ? Number(intPart).toLocaleString() : "0";

            if (decPart === "") {
                $(this).val(formattedInt + ".");
            } else {
                $(this).val(`${formattedInt}.${decPart}`);
            }
        } else {
            $(this).val(Number(value).toLocaleString());
        }
    });

    $(this).on("blur", function () {
        let value = $(this).val();
        if (value.endsWith(".")) {
            $(this).val(value.slice(0, -1));
            $(this).trigger("input");
        }
    });

    // اعمال اولیه روی مقدار فعلی input
    $(this).trigger("input").attr({
        dir: 'ltr'
    });
}

$.fn.persianInput = function () {
    // Arabic characters fall in the Unicode range 0600 - 06FF
    let persianCharUnicodeRange = /[\u0600-\u06FF]/;
    $(this).bind("keypress", function (event) {
        let key = event.which;
        // 0 = numpad
        // 8 = backspace
        // 32 = space
        if (key === 8 || key === 0 || key === 32) {
            return true;
        }
        let str = String.fromCharCode(key);
        return persianCharUnicodeRange.test(str);
    });
}

$.fn.withSeparator = function () {
    return this.each(function () {
        let num = $(this).val() || $(this).text();
        num = parseFloat(num.toString().replace(/,/g, ''));
        if (!isNaN(num)) {
            $(this).val(num.toLocaleString('fa-IR'));
        }
    });
};

$.fn.separatorInput = function () {
    $(this).on('input', function () {
        let number = parseInt($(this).val().replaceAll(',', ''));
        if ($(this).val() == '' || isNaN(parseFloat($(this).val().replaceAll(',', '')))) {
            number = 0;
        }
        $(this).val(number.toLocaleString());
    });
};

$.fn.datePicker = function (minDate = 'attr', maxDate = 'attr') {
    $(this).attr('readonly', true).attr('data-jdp', true)
    jalaliDatepicker.startWatch({
        minDate: minDate, maxDate: maxDate
    });
    minDate = $(this).attr('data-jdp-min-date')
    maxDate = $(this).attr('data-jdp-max-date')
    let dateValue;
    if (!$(this).val()) {
        dateValue = jdate().jalali.date
    } else {
        dateValue = $(this).val()
    }

    if (checkIsSet(minDate) && dateToTimestamp(convertJalaliToGregorian(minDate)) > dateToTimestamp(convertJalaliToGregorian(dateValue))) {
        $(this).val(minDate)
    }

    if (checkIsSet(maxDate) && dateToTimestamp(convertJalaliToGregorian(dateValue)) > dateToTimestamp(convertJalaliToGregorian(maxDate))) {
        $(this).val(maxDate)
    }
}

$.fn.priceInput = function (Length = 100, showAlert = true) {
    // تابع جداکننده سه رقمی
    function formatNumber(val) {
        return val.replace(/\D/g, "")
            .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // تابع حذف کاما
    function unformatNumber(val) {
        return val.replace(/,/g, "");
    }

    $(this).each(function () {
        const $input = $(this);
        $input.attr('maxLength', Length);
        // جلوگیری از تایپ غیرعدد
        $input.on('keypress', function (e) {
            if (e.which < 48 || e.which > 57) {
                if (e.which !== 8 && e.which !== 0) {
                }
            }
        });
        // جلوگیری از paste غیرعدد
        $input.on('paste', function (e) {
            let data = (e.originalEvent || e).clipboardData.getData('text');
            if (!/^\d+$/.test(data)) {
                e.preventDefault();
            }
        });
        // جداکننده سه‌رقمی هنگام تایپ
        $input.on('input', function () {
            let cursorPos = this.selectionStart;

            let raw = unformatNumber(this.value);
            this.value = formatNumber(raw);

            this.selectionStart = this.selectionEnd = cursorPos + (this.value.length - raw.length);
        });
        // حذف کاما قبل از ارسال فرم
        $input.closest("form").on("submit", function () {
            $input.val(unformatNumber($input.val()));
        });

        $(this).attr({
            dir: 'ltr'
        })

    });

};

// $.fn.datePicker = function (minDate =false, maxDate = false) {
//     $(this).attr('readonly', true).attr('data-jdp', true)
//     jalaliDatepicker.startWatch({
//         minDate: 'attr',
//         maxDate: 'attr'
//     });
//     minDate = $(this).attr('data-jdp-min-date')
//     maxDate = $(this).attr('data-jdp-max-date')
//     let dateValue;
//     if (!$(this).val()) {
//         dateValue = jdate().jalali.date
//     } else {
//         dateValue = $(this).val()
//     }
//
//     if (checkIsSet(minDate) && dateToTimestamp(convertJalaliToGregorian(minDate)) > dateToTimestamp(convertJalaliToGregorian(dateValue))) {
//         $(this).val(minDate)
//     }
//
//     if (checkIsSet(maxDate) && dateToTimestamp(convertJalaliToGregorian(dateValue)) > dateToTimestamp(convertJalaliToGregorian(maxDate))) {
//         $(this).val(maxDate)
//     }
// }

$.fn.valWithRemovePriceSeparator = function () {
    let val = $(this).val();
    if (!val) return val;
    return val.replace(/,/g, '');
};

$.fn.formValidate = function (showErrorMessage = true, exceptionValue = 'exception', maximumFileSize = 4, validateTextArea = false, checkRequiredAttribute = true, ignoreDisabledValue = false, enableRealtimeValidation = true) {

    let submitAccept = true;
    let fileSizeAccept = true;
    const $form = $(this);

    const validateElement = function ($el) {
        const tag = $el.prop("tagName").toLowerCase();
        const type = $el.attr("type") ? $el.attr("type").toLowerCase() : tag;

        if (checkRequiredAttribute && !$el.prop('required')) {
            return;
        }

        const shouldValidate = type !== 'button' && (ignoreDisabledValue || !$el.is(':disabled')) && (exceptionValue === '' || !$el.hasClass(exceptionValue)) && !$el.hasClass('select2-search__field') && (validateTextArea || tag !== "textarea");

        if (!shouldValidate) return;

        switch (tag) {
            case 'select':
                const $container = $el.data('select2')?.$container;
                const val = $el.val();

                if (val === null || val === '') {
                    if ($container && $container.length) {
                        $container.find('.select2-selection')
                            .removeClass('is-valid').addClass('is-invalid');
                    }
                    $el.removeClass('is-valid').addClass('is-invalid');
                    $el.parent().removeClass('not-error').addClass('has-error');
                    submitAccept = false;
                } else {
                    if ($container && $container.length) {
                        $container.find('.select2-selection')
                            .removeClass('is-invalid').addClass('is-valid');
                    }
                    $el.removeClass('is-invalid').addClass('is-valid');
                    $el.parent().removeClass('has-error').addClass('not-error');
                }
                break;
            case 'input':
            case 'textarea':

                let value = $el.val();

                if (typeof tinymce !== 'undefined') {
                    const editor = tinymce.get($el.attr('id'));
                    if (editor) {
                        value = editor.getContent({format: 'text'}).trim();
                    }
                }

                if (value === '') {
                    $el.removeClass('is-valid').addClass('is-invalid');
                    $el.parent('div').addClass('has-error');
                    submitAccept = false;
                } else {
                    $el.removeClass('is-invalid').addClass('is-valid');
                    $el.parent('div').removeClass('has-error');
                }

                break;
            // case 'textarea':
            //     if ($el.val().trim() === '') {
            //         $el.removeClass('is-valid').addClass('is-invalid');
            //         $el.parent('div').addClass('has-error');
            //         submitAccept = false;
            //     } else {
            //         $el.removeClass('is-invalid').addClass('is-valid');
            //         $el.parent('div').removeClass('has-error');
            //     }
            //     break;
            case 'file':
                const files = $el.prop("files");
                if (files && files.length > 0) {
                    for (let i = 0; i < files.length; i++) {
                        const fileSizeInMB = checkNumberIntORFloat(files[i].size / (1024 * 1024), 2);
                        if (fileSizeInMB > maximumFileSize) {
                            $el.removeClass('is-valid').addClass('is-invalid');
                            $el.parent('div').addClass('has-error');
                            submitAccept = false;
                            fileSizeAccept = false;
                        } else {
                            $el.removeClass('is-invalid').addClass('is-valid');
                            $el.parent('div').removeClass('has-error');
                        }
                    }
                } else {
                    $el.removeClass('is-valid').addClass('is-invalid');
                    $el.parent('div').addClass('has-error');
                    submitAccept = false;
                }
                break;
        }
    };

    $form.find(':input').each(function () {
        validateElement($(this));
    });

    if (enableRealtimeValidation) {
        $form.find(':input').off('input.formValidate change.formValidate')
            .on('input.formValidate change.formValidate', function () {
                validateElement($(this));
            });

        $form.find('select.select2').off('select2:select.formValidate select2:clear.formValidate')
            .on('select2:select.formValidate select2:clear.formValidate', function () {
                validateElement($(this));
            });
    }


    if (showErrorMessage && !submitAccept) {
        if (fileSizeAccept) {
            swal.fire({
                icon: 'warning', title: 'توجه !', text: 'موارد مشخص شده را پر کنید', confirmButtonText: 'متوجه شدم !'
            });
        } else {
            customAlert('error', `حجم فایل انتخابی بیشتر از ${maximumFileSize} مگابایت است.`);
        }
    }

    return submitAccept;
};

$.fn.validateFormBeforeSend = function (options = {}) {

    const defaults = {
        showErrorMessage: true,
        exceptionValue: 'exception',
        maximumFileSize: 4,
        validateTextArea: false,
        checkRequiredAttribute: true,
        ignoreDisabledValue: false,
        enableRealtimeValidation: true
    }

    const settings = {...defaults, ...options}

    if (settings.checkRequiredAttribute) {
        $("form").attr('novalidate', '')
    } else {
        $("form :input").attr('required', false)
    }

    $("form").on('submit', function (e) {
        if (!$(this).formValidate(settings.showErrorMessage, settings.exceptionValue, settings.maximumFileSize, settings.validateTextArea, settings.checkRequiredAttribute, settings.ignoreDisabledValue, settings.enableRealtimeValidation)) {
            e.preventDefault()
        } else {
            $("form").find('button[type="submit"]').prop('disabled', true)
        }
    })
}

$.fn.setInputMinMax = function (min = null, max = null, showAlert = false, castToPriceInput = false) {
    return this.each(function () {
        const $input = $(this);

        if (min != null) {
            $input.attr("min", min);
        } else {
            $input.removeAttr("min");
        }

        if (max != null) {
            $input.attr("max", max);
        } else {
            $input.removeAttr("max");
        }

        $input.off("input.setInputMinMax");

        $input.on("input.setInputMinMax", function () {
            let val = $(this).val();

            val = val.replace(/[^0-9.]/g, "");

            const parts = val.split(".");
            if (parts.length > 2) {
                val = parts[0] + "." + parts.slice(1).join("");
            }

            $(this).val(val);

            const value = parseFloat(val);

            if (isNaN(value)) {
                return;
            }

            if (min != null && value < min) {
                if (castToPriceInput) {
                    $(this).val(min.toLocaleString());
                } else {
                    $(this).val(min);
                }


                if (showAlert) {
                    if (swal.isVisible()) {
                        swalValidate("مقدار وارد شده کمتر از مجاز است");
                    } else {
                        customAlert("warning", "مقدار وارد شده کمتر از مجاز است");
                    }
                }
            } else if (max != null && value > max) {
                if (castToPriceInput) {
                    $(this).val(max.toLocaleString());
                } else {
                    $(this).val(max);
                }

                if (showAlert) {
                    if (swal.isVisible()) {
                        swalValidate("مقدار وارد شده بیشتر از مجاز است");
                    } else {
                        customAlert("warning", "مقدار وارد شده بیشتر از مجاز است");
                    }
                }
            }
        });
    });
};

const dateToTimestamp = ([gy, gm, gd]) => {
    const date = new Date(gy, gm - 1, gd);
    return Math.floor(date.getTime() / 1000);
};

const swalValidate = (text) => {
    Swal.showValidationMessage(text);
};

const swalClearValidate = () => {
    Swal.resetValidationMessage();
};

const swalConfirmButton = ({enableOrDisable = false}) => {
    let confirmButton = Swal.getConfirmButton();
    confirmButton.disabled = enableOrDisable;
}

function initTooltips(container = document) {
    $(container).find('[data-toggle="tooltip"]').tooltip();
}

$.fn.datePickerMinOrMax = function (secondInputId) {
    const $startInput = $(this);
    const $endInput = $(secondInputId);

    $startInput.attr("readonly", true);
    $endInput.attr({
        readonly: true,
        disabled: true
    });

    jalaliDatepicker.startWatch();

    $startInput.on("change", function () {
        const startDate = $(this).val();
        const endDate = $endInput.val();
        $endInput.attr('disabled', false)
        const startTimeStamp = dateToTimestamp(convertJalaliToGregorian(startDate));
        const endTimeStamp = endDate ? dateToTimestamp(convertJalaliToGregorian(endDate)) : null;

        if (!endDate || endTimeStamp < startTimeStamp) {
            $endInput.val(startDate);
        }

        $endInput.attr("data-jdp-min-date", startDate);

        jalaliDatepicker.startWatch({
            minDate: "attr", maxDate: "attr",
        });
    });

    const startVal = $startInput.val();
    const endVal = $endInput.val();

    if (startVal && endVal) {
        const startTimeStamp = dateToTimestamp(convertJalaliToGregorian(startVal));
        const endTimeStamp = dateToTimestamp(convertJalaliToGregorian(endVal));

        if (endTimeStamp < startTimeStamp) {
            $startInput.trigger("change");
        }
    }
}

const jdate = (input = "", options = {}) => {
    let date;

    // --- تشخیص نوع ورودی ---
    if (!input) {
        date = new Date();
    } else if (!isNaN(input) && input.toString().length === 10) {
        // timestamp ثانیه
        date = new Date(input * 1000);
    } else if (!isNaN(input) && input.toString().length === 13) {
        // timestamp میلی‌ثانیه
        date = new Date(parseInt(input));
    } else if (/^\d{4}\/\d{2}\/\d{2}$/.test(input)) {
        // تاریخ شمسی YYYY/MM/DD → تبدیل به میلادی
        const [jy, jm, jd] = input.split('/').map(Number);
        // ساده‌ترین روش: با Intl نمی‌توان مستقیم شمسی→میلادی، نیاز به کتابخانه داریم
        // برای مثال می‌توانیم از Date خود JS استفاده کنیم (ولی باید تبدیل دستی شمسی→میلادی بگیریم)
        throw new Error("Shamsi to Gregorian conversion requires library (مثلا 'jalaali-js')");
    } else {
        // تاریخ میلادی
        date = new Date(input);
    }

    // --- تاریخ شمسی ---
    const faCalendarLong = new Intl.DateTimeFormat('en-US-u-ca-persian', {
        dateStyle: 'full', timeStyle: 'long'
    });
    const faCalendarParts = new Intl.DateTimeFormat('en-US-u-ca-persian', {
        year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit'
    }).formatToParts(date);

    const jYear = faCalendarParts.find(p => p.type === 'year').value;
    const jMonth = faCalendarParts.find(p => p.type === 'month').value;
    const jDay = faCalendarParts.find(p => p.type === 'day').value;
    const jHour = faCalendarParts.find(p => p.type === 'hour').value;
    const jMinute = faCalendarParts.find(p => p.type === 'minute').value;
    const jSecond = faCalendarParts.find(p => p.type === 'second').value;

    const jalali = {
        long: faCalendarLong.format(date).replace(/\s?AP$/, '').trim(),
        date: `${jYear}/${jMonth}/${jDay}`,
        time: `${jHour}:${jMinute}:${jSecond}`
    };

    // --- تاریخ میلادی ---
    const enCalendar = new Intl.DateTimeFormat('en-CA', {
        year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit'
    });

    const gregorian = {
        long: enCalendar.format(date), date: date.toISOString().slice(0, 10), time: date.toTimeString().slice(0, 8)
    };

    // --- timestamp ---
    const timestamp = Math.floor(date.getTime() / 1000);

    return {
        jalali, gregorian, timestamp
    };
};

$.fn.getOptions = function ({urlAddress, method = "GET", callback}) {
    $(this).on('change', function () {
        let value = $(this).val();
        $.ajax({
            url: urlAddress,
            type: method,
            data: {value},
            dataType: 'json',
            success: result => {
                if (callback) {
                    callback(result);
                }
            }
        });
    });
};

$.fn.getOptionsValue = function ({urlAddress, method = "GET", callback}) {
    $.ajax({
        url: urlAddress,
        type: method,
        dataType: 'json',
        success: result => {
            if (callback) {
                callback(result);
            }
        }
    });

}

const getAddressByLocation = (latitude, longitude, apiKey, showResultInput) => {
    $.ajax({
        url: "https://api.neshan.org/v5/reverse?lat=" + latitude + "&lng=" + longitude, type: 'GET', headers: {
            'Api-Key': apiKey
        }, success: result => {
            $(showResultInput).val(result.formatted_address);
        }
    });
};

const map = (latitude = 35.73280037844341, longitude = 51.33327548631564, zoom = 16, markerIconUrl = '') => {
    $("#map").after(`<input  name="latitude" hidden id="latInput" readonly="readonly" value="${latitude}"><br><input  name="longitude" id="lngInput" readonly="readonly" hidden value="${longitude}">`);
    $("#map").css('height', '250px');
    var map = L.map('map', {
        center: [((latitude) ? latitude : 35.73280037844341), (longitude) ? longitude : 51.33327548631564], zoom: zoom
    });
    let date = new Date();
    // var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    // var osm = L.tileLayer('https://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
    var osm = L.tileLayer('https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', {
        attribution: `&copy; ${date.getFullYear()} Deep Erp`
    }).addTo(map);
    var centuryIcon = L.icon({
        iconUrl: markerIconUrl, iconSize: [40, 40]
    });
    var marker = L.marker([((latitude) ? latitude : $("#latInput").val()), ((longitude) ? longitude : $("#lngInput").val())], (markerIconUrl) ? {icon: centuryIcon} : '').addTo(map);
    map.on('click', function (e) {
        marker.remove();
        marker = L.marker([e.latlng.lat, e.latlng.lng], (markerIconUrl) ? {icon: centuryIcon} : '').addTo(map);
        $("#latInput").val(e.latlng.lat);
        $("#lngInput").val(e.latlng.lng);
    });
};

function select2AllOrItems(inputSelector) {
    let $select = $(inputSelector);

    $select.on('select2:select', function (e) {
        let selected = $(this).val() || [];

        if (e.params.data.id === 'all') {
            $(this).val(['all']).trigger('change.select2');
        } else {
            let filtered = selected.filter(v => v !== 'all');
            $(this).val(filtered).trigger('change.select2');
        }
    });

    $select.on('select2:unselect', function (e) {
        let selected = $(this).val() || [];

        if (selected.length === 0) {
            $(this).val(['all']).trigger('change.select2');
        }
    });

    $(".select2-selection__rendered").css({
        "max-height": "56px", "overflow-y": "auto"
    });
}

$.fn.checkBoxEvent = function (options) {

    const settings = $.extend({
        checkedValue: 1, uncheckedValue: 0, onChecked: null, onUnchecked: null
    }, options);

    return this.each(function () {
        const $el = $(this);

        $el.on('change', function () {
            if (this.checked) {
                $el.val(settings.checkedValue);

                if (typeof settings.onChecked === 'function') {
                    settings.onChecked.call(this, $el);
                }

            } else {
                $el.val(settings.uncheckedValue);
                if (typeof settings.onUnchecked === 'function') {
                    settings.onUnchecked.call(this, $el);
                }
            }
        });
    });
};

$.fn.checkNationalCode = function (options) {
    $(this).attr({
        maxlength: 10, dir: 'ltr'
    })
    const settings = $.extend({
        onValid: null, onInvalid: null
    }, options);

    return this.each(function () {
        const $el = $(this);
        $el.on('input', function () {
            let code = $el.val();

            let isValid = true;

            if (!/^\d{10}$/.test(code)) {
                isValid = false;
            } else {
                let check = parseInt(code[9]);
                let sum = 0;

                for (let i = 0; i < 9; i++) {
                    sum += parseInt(code[i]) * (10 - i);
                }

                let remainder = sum % 11;
                isValid = (remainder < 2) ? check === remainder : check === (11 - remainder);
            }

            if (isValid) {
                if (typeof settings.onValid === 'function') {
                    settings.onValid.call(this, $el);
                }
            } else {
                if (typeof settings.onInvalid === 'function') {
                    settings.onInvalid.call(this, $el);
                }
            }
        });
    });
};

$.fn.checkEmailInput = function (options) {
    $(this).attr({
        dir: 'ltr'
    })
    const settings = $.extend({
        onValid: null, onInvalid: null
    }, options);
    return this.each(function () {
        const $el = $(this);

        $el.on('input', function () {
            let val = $el.val();

            val = val.replace(/[^a-zA-Z0-9@._-]/g, '');
            $el.val(val);

            const isValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val);

            if (isValid) {
                if (typeof settings.onValid === 'function') {
                    settings.onValid.call(this, $el);
                }
            } else {
                if (typeof settings.onInvalid === 'function') {
                    settings.onInvalid.call(this, $el);
                }
            }
        });
    });
};

$.fn.multipleFile = function () {
    FilePond.registerPlugin(FilePondPluginImagePreview, FilePondPluginImageCrop, FilePondPluginImageResize, FilePondPluginImageTransform);

    const pond = FilePond.create(document.querySelector(this), {
        instantUpload: false,
        allowProcess: false,
        storeAsFile: true,

        imageCropAspectRatio: '1:1',
        imageResizeTargetWidth: 500,
        imageResizeTargetHeight: 500,
        imageTransformOutputMimeType: 'image/jpeg'
    });

    pond.on('activatefile', (file) => {
        if (pond.allowImageEdit && file) {
            pond.editFile(file.id);
        }
    });
}

const filterMonthWithName = (fromMonthId, toMonthId) => {
    let month = {
        1: 'فروردین',
        2: 'اردیبهشت',
        3: 'خرداد',
        4: 'تیر',
        5: 'مرداد',
        6: 'شهریور',
        7: 'مهر',
        8: 'آبان',
        9: 'آذر',
        10: 'دی',
        11: 'بهمن',
        12: 'اسفند',
    };
    $.each(month, function (key, item) {
        $("#" + fromMonthId).append(`<option value="${key}">${item}</option>`)
        $("#" + toMonthId).append(`<option value="${key}">${item}</option>`)
    })
    $("#" + fromMonthId).on('change', function () {
        let monthSelect = $(this).find(':selected').val();
        $("#" + toMonthId).html('')
        for (let a = monthSelect; a <= 12; a++) {
            $("#" + toMonthId).append(`<option value="${a}">${month[a]}</option>`)
        }
    })
}

$.fn.makeDataTable = function (dom = "Bfrtip", paging = true, info = true, showButton = true) {
    let buttonsData = (showButton ? [{
        text: 'کپی', extend: 'copyHtml5', exportOptions: {
            columns: [0, ':visible']
        }
    }, {
        text: 'اکسل', extend: 'excelHtml5', exportOptions: {
            columns: ':visible'
        }, customize: function (xlsx) {
            var source = xlsx.xl['workbook.xml'].getElementsByTagName('sheet')[0];
            source.setAttribute('name', 'Roles');
        }

    }, {
        text: 'چاپ', extend: 'print', exportOptions: {
            columns: ':visible'
        }
    }, {
        text: 'فیلتر ستون', extend: 'colvis', exportOptions: {
            columns: ':visible'
        }
    }] : [])
    return $(this).DataTable({
        order: [[0, 'desc']],
        dom: dom,
        paging: paging,
        info: info,
        "language": {
            "sEmptyTable": "هیچ داده ای در جدول وجود ندارد",
            "sInfo": "نمایش _START_ تا _END_ از _TOTAL_ رکورد",
            "sInfoEmpty": "نمایش 0 تا 0 از 0 رکورد",
            "sInfoFiltered": "(فیلتر شده از _MAX_ رکورد)",
            "sInfoPostFix": "",
            "sInfoThousands": ",",
            "sLengthMenu": "نمایش _MENU_ رکورد",
            "sLoadingRecords": "در حال بارگزاری...",
            "sProcessing": "در حال پردازش...",
            "sSearch": "جستجو: ",
            "sZeroRecords": "رکوردی با این مشخصات پیدا نشد",
            "oPaginate": {
                "sFirst": "ابتدا", "sLast": "انتها", "sNext": "بعدی", "sPrevious": "قبلی"
            },
            "oAria": {
                "sSortAscending": ": فعال سازی نمایش به صورت صعودی",
                "sSortDescending": ": فعال سازی نمایش به صورت نزولی"
            }
        }, buttons: buttonsData
    });
}

$.fn.destroyDataTable = function () {
    $(this).DataTable().destroy()
}

function handeOfAjaxJsonResponse(result, element = this, refreshAfterResult = true, callBack) {
    result = JSON.parse(result)
    customAlert(result.status, result.message)
    if (result.status && refreshAfterResult) {
        setTimeout(function () {
            window.location.reload()
        }, 2000)
    } else if (!refreshAfterResult) {
        callBack()
    }
}


$.fn.fileSizeCheck = function ({minSize, maxSize, errorMessage, fileInfo = false}) {
    let fileData = $(this)[0].files[0];
    let fileSize = $(this)[0].files[0].size;
    let thisInputId = $(this).attr('id');
    if (fileInfo) {
        console.log({
            'fileSize': Math.abs(fileSize / 1000), 'fileName': fileData
        })
    }
    if (fileSize < minSize) {
        if (errorMessage) {
            $(this).after(`<small id="${thisInputId}_error" class="text-danger">${errorMessage}</small>`)
        } else $(this).after(`<small id="${thisInputId}_error" class="text-danger">فایل کمتر از حد مجاز</small>`)
    } else if (fileSize > maxSize) {
        if (errorMessage) {
            $(this).after(`<small id="${thisInputId}_error" class="text-danger">${errorMessage}</small>`)
        } else $(this).after(`<small id="${thisInputId}_error" class="text-danger">فایل بیشتر از حد مجاز</small>`)
    } else {
        $("#" + thisInputId + '_error').remove()
    }
}

const alarmNotification = ({title, description}) => {
    Toastify({
        text: `
        <div class="erp-toast">
            <a href="${url}">
            <img src="/Storage/DefaultImages/bell.webp" class="toast-avatar">
            <div class="content" style="margin-right: 0 !important;">
            
                <div class="title">${title}</div>
                <hr>
                <div class="desc">${description}</div>
            </div>
            </a>
        </div>
    `,
        escapeMarkup: false,
        gravity: "bottom",
        position: "left",
        duration: -1,
        close: true,
        className: "erp-toastify"
    }).showToast();

}


/**
 *
 * @param route route address
 * result should [
 *     id:*
 *     value:*
 * ]
 * @param delayTime
 * delay time for send request
 */
$.fn.select2Ajax = function (route, delayTime = 200) {
    $(this).select2({
        placeholder: 'جستجو کنید...',
        allowClear: true,
        dir: "rtl",
        language: "fa",
        ajax: {
            url: route,
            dataType: 'json',
            delay: delayTime,
            data: function (params) {
                return {
                    value: params.term,
                    page: params.page || 1
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                return {
                    results: data.map(function (item) {
                        return {
                            id: item.id,
                            text: item.value
                        };
                    }),
                    pagination: {
                        more: data.current_page < data.last_page
                    }
                };
            },
            cache: true
        },
        minimumInputLength: 0,
        templateResult: formatResult,
        templateSelection: formatSelection
    });

    function formatResult(item) {
        if (item.loading) {
            return item.text;
        }
        return $('<div>').text(item.text);
    }

    function formatSelection(item) {
        return item.text;
    }
}

/**
 *
 * @param data get last array value
 * @returns {*}
 */
function end(data) {
    return data.at(-1)
}

function getInputsNested(selector) {
    const result = {};

    $(selector).find('input[name], select[name], textarea[name]').each(function () {
        const name = $(this).attr('name');
        const value = $(this).val();

        if (!name) return;

        const keys = name.replace(/\]/g, "").split("[");
        let current = result;

        keys.forEach((key, index) => {
            if (index === keys.length - 1) {
                current[key] = value;
            } else {
                if (!current[key] || typeof current[key] !== "object") {
                    current[key] = {};
                }
                current = current[key];
            }
        });
    });

    return result;
}

$.fn.destroySelect2 = function () {
    if (this.hasClass('select2-hidden-accessible')) {
        this.select2('destroy');
    }
}