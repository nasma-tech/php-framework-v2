
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
                            <button class="btn btn-sm btn-danger deleteGroupTeam"
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

    // حذف تیم از گروه
    $(document).on('click', '.deleteGroupTeam', function () {
        let groupId = $(this).data('group-id');
        let teamId = $(this).data('team-id');

        Swal.fire({
            title: 'حذف تیم از گروه؟',
            text: 'آیا از حذف این تیم از گروه اطمینان دارید؟',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'بله، حذف شود',
            cancelButtonText: 'انصراف'
        }).then(result => {
            if (!result.isConfirmed) return;

            // درخواست حذف را با Route مربوط به پروژه ارسال کن.
            // groupId و teamId شناسه‌های مورد نیاز هستند.
        });
    });

});
