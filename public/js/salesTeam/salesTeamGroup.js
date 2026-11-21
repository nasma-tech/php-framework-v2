$(function () {
    "use strict";

    function escapeHtml(value) {
        return $('<div>').text(value ?? '-').html();
    }

    $(".viewDetail").on('click', function () {
        let id = $(this).data('id');
        let label = $(this).data('label');

        $('#groupDetailModalLabel').text(`اعضای گروه ${label}`);
        $('#groupDetailContent').html(`
            <div class="text-center p-3">
                <i class="bx bx-loader-alt bx-spin"></i>
                در حال دریافت اطلاعات...
            </div>
        `);

        $('#groupDetailModal').modal('show');

        $.ajax({
            url: `/salesTeam/getGroupData/${id}`,
            method: "GET",
            dataType: "json",

            success: function (result) {
                console.log(result);

                let data = Array.isArray(result)
                    ? result
                    : Array.isArray(result.data)
                        ? result.data
                        : [];

                if (!data.length) {
                    $('#groupDetailContent').html(`
                        <div class="alert alert-info text-center">
                            تیمی برای این گروه ثبت نشده است.
                        </div>
                    `);
                    return;
                }

                let rows = data.map((item, index) => `
                    <tr class="text-center">
                        <td>${index + 1}</td>
                        <td>${escapeHtml(item.sales_team?.team_title)}</td>
                        <td>${escapeHtml(item.user?.full_name)}</td>
                        <td>${escapeHtml(item.created_at)}</td>
                        <td>${escapeHtml(item.updated_at)}</td>
                        <td>
                            <a class="btn btn-sm btn-warning"
                                href="/salesTeam/editIndex/${item.salesTeam_id}">
                                <i class="bx bx-show text-white"></i>
                            </a>
                            <a class="btn btn-sm btn-primary"
                                href="/salesTeam/permissions/${item.salesTeam_id}">
                                <i class="bx bx-key text-white"></i>
                            </a>
                            <button class="btn btn-sm btn-danger deleteGroupTeam"
                                data-team-name="${item.sales_team?.team_title}"
                                data-groupname="${escapeHtml(label)}"
                                data-group-id="${item.SalesTeamGroup_id}"
                                data-team-id="${item.salesTeam_id}">
                                <i class="bx bx-trash-alt"></i>
                            </button>
                        </td>
                    </tr>
                `).join('');

                $('#groupDetailContent').html(`
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        

                        <a href="/salesTeam/addTeamIndex/${id}" class="btn btn-sm btn-primary addTeamToGroup"
                            data-group-id="${id}">
                            <i class="bx bx-plus"></i>
                            افزودن تیم
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr class="text-center">
                                    <th>#</th>
                                    <th>نام تیم فروش</th>
                                    <th>ثبت‌کننده</th>
                                    <th>تاریخ ایجاد</th>
                                    <th>آخرین ویرایش</th>
                                    <th>عملیات</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${rows}
                            </tbody>
                        </table>
                    </div>
                `);
            },

            error: function (xhr) {
                console.log(xhr.responseText);

                $('#groupDetailContent').html(`
                    <div class="alert alert-danger text-center">
                        خطا در دریافت اطلاعات گروه
                    </div>
                `);
            }
        });
    });
    $(document).on('click', '.deleteGroupTeam', function () {
        let group_id = $(this).data("group-id")
        let team_id = $(this).data("team-id")
        let team_name = $(this).data("team-name")
        let group_name = $(this).data("groupname")

        swal.fire({
            icon: 'question',
            title: `آیا از حذف تیم ${team_name} در گروه ${group_name} مطمعن هستید؟`,
            confirmButtonText: "حذف شود",
            showDenyButton: true,
            denyButtonText: 'بستن',
            preConfirm: () => {
                $.ajax({
                    url: "deleteSalesTeam",
                    method: "POST",
                    data: {
                        team_id: team_id,
                        group_id: group_id
                    },
                    success: result => {
                        if (result == "deleteSucess") {
                            swal.fire({
                                icon: "success",
                                title: 'با موفقیت حذف شد',
                                confirmButtonText: 'بستن',
                            }).then(() => {
                                location.reload();
                            })
                        } else {
                            swal.fire({
                                icon: "warning",
                                title: 'حذف انجام نشد',
                                confirmButtonText: 'بستن',
                            }).then(() => {
                                location.reload();
                            })
                        }
                    }
                })
            }
        })
    });


    $(document).on("click", ".deleteGroup", function () {
        let id = $(this).data('id');

        $.ajax({
            url: `/salesTeam/checkGroupTeam/${id}`,
            method: "GET",
            dataType: "json",

            success: result => {
                if (result.message === 'withData') {

                    let teamList = result.data.map((item, index) => `
                    <tr>
                        <td>${$('<div>').text(item.sales_team?.team_title ?? '-').html()}</td>
                    </tr>
                `).join('');

                    Swal.fire({
                        icon: "warning",
                        title: "تیم‌های متصل به گروه",
                        html: `
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>نام تیم</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    ${teamList}
                                </tbody>
                            </table>
                        </div>
                    `,
                        showCancelButton: true,
                        confirmButtonText: "حذف گروه",
                        cancelButtonText: "بستن",
                        confirmButtonColor: "#ea5455"
                    }).then(result => {
                        if (result.isConfirmed) {
                            $.ajax({
                                url: `deleteGroup/${id}`,
                                method: "GET",
                                success: result => {
                                    if (result == "deleteSucess") {
                                        swal.fire({
                                            icon: "success",
                                            title: "با موفقیت حذف شد",
                                            confirmButtonText: "بستن"
                                        }).then(() => {
                                            location.reload();
                                        })
                                    } else {
                                        swal.fire({
                                            icon: "warning",
                                            title: "حذف انجام نشد",
                                            confirmButtonText: "بستن"
                                        }).then(() => {
                                            location.reload();
                                        })
                                    }
                                }
                            })
                        }
                    });

                } else {
                    swal.fire({
                        icon: "question",
                        title: 'از حذف گروه مطمعا هستید؟',
                        confirmButtonText: "بله",
                        showDenyButton: true,
                        denyButtonText: 'انصراف',
                    })
                }
            }
        });
    });


});
