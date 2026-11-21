document.addEventListener("DOMContentLoaded", function () {
    let rightcard = false;
    let tempblock;
    let tempblock2;
    flowy(document.getElementById("canvas"), drag, release, snapping);
    const blockList = () => {
        $.ajax({
            url: '/salesTeam/getUsers',
            type: 'POST',
            success: result => {
                $("#blocklist").html(result);
            }
        });
    };
    blockList();
    $("#searchField").on('input', function () {
        let value = $(this).val();
        if (value) {
            $.ajax({
                url: '/salesTeam/searchUserChart',
                type: 'POST',
                data: {
                    value
                }, success: result => {
                    if (result) {
                        $("#blocklist").html(result);
                    } else {
                        $("#blocklist").html('<h6 class="text-center">!موردی یافت نشد</h6>');
                    }

                }
            });
        } else {
            blockList();
        }


    });

    function addEventListenerMulti(type, listener, capture, selector) {
        let nodes = document.querySelectorAll(selector);
        for (let i = 0; i < nodes.length; i++) {
            nodes[i].addEventListener(type, listener, capture);
        }
    }


    const blockDrag = (drag) => {
        setTimeout(function () {
            $(".block").on('click', function () {
                let userName = $(this).find('.userNameChart').val();
                let workGroup = $(this).find('.workGroupId').val();
                $("#user_name_chart").val(userName).attr('readonly', true);
                $("#work_group_id").val(workGroup).change();
            });
            if ($(".arrowblock").length > 0) {
                $("#removeblock").hide();
            } else {
                $("#removeblock").show();
            }
            $(".blockelem").on('click', function () {
                $(".blockelem").find('.blockid').each(function () {
                    $(this).parent('div').removeClass('selectedblock');
                });
                $(this).addClass('selectedblock');
            });
        }, 200);

        return `
        <div class='blockyleft'>
        <div class="imageClassChart">
            <img class="round" src='${drag.querySelector(".imageClass").value}' width="30" alt="">
        </div>
        <div class="titleUserChart">
            <p class='blockyname'>${drag.querySelector(".userNameChart").value}</p>
            <p class='workGroupText'></p>
            <p class='blockyposition'></p>
        </div>
        </div>
        <div class='blockydiv'></div>
        <div class='blockyinfo float-left' dir="ltr">
        <div class="text-left pl-1">
            <span class="workGroupText"></span>
            <div class="det_lable">پست سازمانی</div> 
         </div>
        <span id="workGroupOriginalData" style="display: none"></span>
        <div class="text-left pl-1">
            <span id="hasCommission"></span> 
            <div class="det_lable">: دریافت کمیسیون از زیر گروه </div>  
        </div>
        <span id="commissionOriginalData" style="display: none"></span>
        <div class="text-left pl-1">
            <span id="percentCommission"></span>
            <div class="det_lable">: درصد کمیسیون</div> 
        </div>
        <div class="text-left pl-1">
            <span id="percentDiscount"></span>
            <div class="det_lable"> : درصد تخفیف</div> 
        </div>
            
        <input hidden name="workGroupIdValue" class="workGroupIdValue">
        <input hidden name="hasCommissionValue" class="hasCommissionValue">
        <input hidden name="percentCommissionValue" class="percentCommissionValue">
        <input hidden name="percentDiscountValue" class="percentDiscountValue">
        </div>
      `;
    };

    $("#saveBlock").on('click', function () {
        $(".selectedblock").find(".workGroupText").text($("#work_group_id option:selected").text());
        $(".selectedblock").find("#workGroupOriginalData").text($("#work_group_id option:selected").val());
        if ($("#hasCommission_id option:selected").val() == 'Yes') {
            $(".selectedblock").find("#hasCommission").text('بله');
        } else {
            $(".selectedblock").find("#hasCommission").text('خیر');
        }
        $(".selectedblock").find("#commissionOriginalData").text($("#hasCommission_id option:selected").val());
        $(".selectedblock").find("#percentCommission").text((($("#percent_commission_value").val()) ? $("#percent_commission_value").val() : 0));
        $(".selectedblock").find("#percentDiscount").text((($("#percent_discount_value").val()) ? $("#percent_discount_value").val() : 0));
        $("#close").click();
        $('#work_group_id').prop('selectedIndex', 0);
        $("#percent_commission_value").val('');
        $("#percent_discount_value").val('');
    });

    function snapping(drag, first) {
        let grab = drag.querySelector(".grabme");
        grab.parentNode.removeChild(grab);
        let blockin = drag.querySelector(".blockin");
        blockin.parentNode.removeChild(blockin);
        drag.innerHTML += blockDrag(drag);
        return true;
    }

    function drag(block) {
        block.classList.add("blockdisabled");
        tempblock2 = block;
    }

    function release() {
        if (tempblock2) {
            tempblock2.classList.remove("blockdisabled");
        }
    }

    let disabledClick = function () {
        document.querySelector(".navactive").classList.add("navdisabled");
        document.querySelector(".navactive").classList.remove("navactive");
        this.classList.add("navactive");
        this.classList.remove("navdisabled");
        if (this.getAttribute("id") == "triggers") {
            blockList();
        }
    };
    addEventListenerMulti("click", disabledClick, false, ".side");
    document.getElementById("close").addEventListener("click", function () {
        if (rightcard) {
            rightcard = false;
            document.getElementById("properties").classList.remove("expanded");
            setTimeout(function () {
                document.getElementById("propwrap").classList.remove("itson");
            }, 300);
            tempblock.classList.remove("selectedblock");
        }
    });

    document.getElementById("removeblock").addEventListener("click", function () {
        flowy.deleteBlocks();
        $("#close").click();
    });
    let aclick = false;
    let noinfo = false;
    let beginTouch = function (event) {
        aclick = true;
        noinfo = false;
        if (event.target.closest(".create-flowy")) {
            noinfo = true;
        }
    };
    let checkTouch = function (event) {
        aclick = false;
    };
    let doneTouch = function (event) {
        if (event.type === "mouseup" && aclick && !noinfo) {
            if (!rightcard && event.target.closest(".block") && !event.target.closest(".block").classList.contains("dragging")) {
                tempblock = event.target.closest(".block");
                rightcard = true;
                document.getElementById("properties").classList.add("expanded");
                document.getElementById("propwrap").classList.add("itson");
                tempblock.classList.add("selectedblock");
            }
        }
    };
    addEventListener("mousedown", beginTouch, false);
    addEventListener("mousemove", checkTouch, false);
    addEventListener("mouseup", doneTouch, false);
    addEventListenerMulti("touchstart", beginTouch, false, ".block");


    $("#saveData").on('click', function () {
        let team_title = $("#team_title").val();
        let Minimum_payment = $("#Minimum_payment").val();
        let license_payment = $("#license_payment").val();
        if (!team_title) {
            $("#team_title").addClass('is-invalid');
            customAlert('warning', 'عنوان تیم را انتخاب کنید');
        } else if (!Minimum_payment) {
            $("#Minimum_payment").addClass('is-invalid');
            customAlert('warning', 'حداقل پیش پرداخت را وارد کنید');
        } else {
            $("#team_title").removeClass('is-invalid');
            $("#Minimum_payment").removeClass('is-invalid');
            $("#team_title").addClass('is-valid');
            $("#Minimum_payment").addClass('is-valid');
            $(".blockyinfo").each(function () {
                $(this).find('.workGroupIdValue').val($(this).find('#workGroupOriginalData').text());
                $(this).find('.hasCommissionValue').val($(this).find('#commissionOriginalData').text());
                $(this).find('.percentCommissionValue').val($(this).find('#percentCommission').text());
                $(this).find('.percentDiscountValue').val($(this).find('#percentDiscount').text());
            });
            let dataJson = JSON.stringify(flowy.output());
            $.ajax({
                url: '/salesTeam/add',
                type: 'POST',
                data: {
                    team_title,
                    Minimum_payment,
                    license_payment,
                    dataJson
                }, success: result => {
                    if (result == 'addSuccess') {
                        swal.fire({
                            icon: 'success',
                            title: 'با موفقیت ثبت شد',
                            confirmButtonText: 'بستن',
                            preConfirm: () => {
                                window.location.href = APP_URL() + '/salesTeam/main';
                            },
                            allowOutsideClick: () => {
                                window.location.href = APP_URL() + '/salesTeam/main';
                            },
                            didClose: () => {
                                window.location.href = APP_URL() + '/salesTeam/main';
                            }
                        });
                    }
                }
            });
        }
    });

    if (window.location.href.search('viewIndex') != -1 || window.location.href.search('editIndex') != -1) {
        $.ajax({
            url: '/salesTeam/getChartData',
            type: 'POST',
            data: {
                teamId: $("#sale_team_id").val()
            }, success: result => {
                let data = JSON.parse(result);
                flowy.import(data);
            }
        });
    }

    $("#editData").on('click', function () {
        let team_title = $("#team_title").val();
        let Minimum_payment = $("#Minimum_payment").val();
        let license_payment = $("#license_payment").val();
        if (!team_title) {
            $("#team_title").addClass('is-invalid');
            customAlert('warning', 'عنوان تیم را انتخاب کنید');
        } else if (!Minimum_payment) {
            $("#Minimum_payment").addClass('is-invalid');
            customAlert('warning', 'حداقل پیش پرداخت را وارد کنید');
        } else {
            $("#team_title").removeClass('is-invalid');
            $("#Minimum_payment").removeClass('is-invalid');
            $("#team_title").addClass('is-valid');
            $("#Minimum_payment").addClass('is-valid');
            $(".blockyinfo").each(function () {
                $(this).find('.workGroupIdValue').val($(this).find('#workGroupOriginalData').text());
                $(this).find('.hasCommissionValue').val($(this).find('#commissionOriginalData').text());
                $(this).find('.percentCommissionValue').val($(this).find('#percentCommission').text());
                $(this).find('.percentDiscountValue').val($(this).find('#percentDiscount').text());
            });
            let dataJson = JSON.stringify(flowy.output());
            $.ajax({
                url: '/salesTeam/teamEdit',
                type: 'POST',
                data: {
                    team_title,
                    Minimum_payment,
                    license_payment,
                    dataJson,
                    teamId :$("#sale_team_id").val()
                }, success: result => {
                    if (result == 'editSuccess') {
                        swal.fire({
                            icon: 'success',
                            title: 'با موفقیت ویرایش شد',
                            confirmButtonText: 'بستن',
                            preConfirm: () => {
                                window.location.href = APP_URL() + '/salesTeam/main';
                            },
                            allowOutsideClick: () => {
                                window.location.href = APP_URL() + '/salesTeam/main';
                            },
                            didClose: () => {
                                window.location.href = APP_URL() + '/salesTeam/main';
                            }
                        });
                    }
                }
            });
        }
    });

    if (window.location.href.search('editIndex') != -1){
        setTimeout(function () {
            $(".blockelem").on('click',function () {
                $("#user_name_chart").val($(this).find('.userNameChart').val());
                $("#percent_discount_value").val($(this).find('#percentDiscount').text());
                $("#percent_commission_value").val($(this).find('#percentCommission').text());
                $("#work_group_id").val($(this).find('#workGroupOriginalData').text()).change();
                $("#hasCommission_id").val($(this).find('#commissionOriginalData').text()).change();
            });
        },500);

    }
    if (window.location.href.search('viewIndex') != -1){
        setTimeout(function () {
            $(".blockelem").on('click',function () {
                $("#user_name_chart").val($(this).find('.userNameChart').val());
                $("#percent_discount_value").val($(this).find('#percentDiscount').text());
                $("#percent_commission_value").val($(this).find('#percentCommission').text());
                $("#work_group_id").val($(this).find('#workGroupOriginalData').text()).change();
                $("#hasCommission_id").val($(this).find('#commissionOriginalData').text()).change();
            });
            $("#propwrap").find(':input').attr('disabled',true);
            $("#saveBlock").remove();
            $("#removeblock").remove();
            $("#canvas").on('mousedown',function () {
               return false;
            });
        },500);
    }

});
