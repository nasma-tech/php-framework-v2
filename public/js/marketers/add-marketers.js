
$(function () {
    const config = {
        marketerDataUrl: '/marketers/MarketerData',
        addUrl: '/marketers/addMarketerGroup',
        editUrl: '/marketers/editMarketeGroup/'
    };

    $('#marketerTypeTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        let type = $(e.target).data('type');
        let target = $(e.target).attr('href');

        $('#marketer_type').val(type);

        $('#marketerTypeContent .tab-pane').each(function () {
            $(this).find(':input').prop('disabled', $(this).attr('id') !== target.replace('#', ''));
        });
    });

    $('#marketerTypeContent .tab-pane').not('#natural').find(':input').prop('disabled', true);

    function loadMarketerGroups() {
        $('#marketingGroupContent').html(`
            <div class="text-center p-3">در حال دریافت اطلاعات...</div>
        `);

        $.ajax({
            url: config.marketerDataUrl,
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                let html = `
                    <div class="mb-3 text-right">
                        <button type="button" class="btn btn-success btn-sm" id="addMarketerGroup">
                            افزودن گروه جدید
                        </button>
                    </div>

                    <div id="marketerGroupFormContainer"></div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped text-center">
                            <thead>
                                <tr>
                                    <th>ردیف</th>
                                    <th>عنوان گروه</th>
                                    <th>عملیات</th>
                                </tr>
                            </thead>
                            <tbody>
                `;

                if (response.length) {
                    response.forEach(function (item, index) {
                        html += `
                            <tr>
                                <td>${index + 1}</td>
                                <td>${$('<div>').text(item.title || '').html()}</td>
                                <td>
                                    <button type="button"
                                            class="btn btn-sm btn-warning editMarketerGroup"
                                            data-id="${item.id}"
                                            data-title="${$('<div>').text(item.title || '').html()}">
                                        ویرایش
                                    </button>
                                </td>
                            </tr>
                        `;
                    });
                } else {
                    html += `
                        <tr>
                            <td colspan="3">گروهی ثبت نشده است.</td>
                        </tr>
                    `;
                }

                html += `
                            </tbody>
                        </table>
                    </div>
                `;

                $('#marketingGroupContent').html(html);
            },
            error: function () {
                $('#marketingGroupContent').html(`
                    <div class="alert alert-danger">
                        دریافت اطلاعات گروه‌ها با خطا مواجه شد.
                    </div>
                `);
            }
        });
    }

    function showGroupForm(id = '', title = '') {
        $('#marketerGroupFormContainer').html(`
            <form id="marketerGroupForm" class="card card-body mb-3">
                <div class="form-group">
                    <label>عنوان گروه</label>
                    <input type="text"
                           name="title"
                           class="form-control"
                           value="${$('<div>').text(title).html()}"
                           required>
                </div>

                <div class="text-right">
                    <button type="submit" class="btn btn-success btn-sm">
                        ثبت
                    </button>
                    <button type="button" class="btn btn-secondary btn-sm" id="cancelGroupForm">
                        انصراف
                    </button>
                </div>
            </form>
        `);

        $('#marketerGroupForm').data('id', id);
    }

    $('#marketingGroupModal').on('shown.bs.modal', function () {
        loadMarketerGroups();
    });

    $(document).on('click', '#addMarketerGroup', function () {
        showGroupForm();
    });

    $(document).on('click', '.editMarketerGroup', function () {
        showGroupForm($(this).data('id'), $(this).data('title'));
    });

    $(document).on('click', '#cancelGroupForm', function () {
        $('#marketerGroupFormContainer').empty();
    });

    $(document).on('submit', '#marketerGroupForm', function (e) {
        e.preventDefault();

        let id = $(this).data('id');
        let url = id ? config.editUrl + id : config.addUrl;

        $.ajax({
            url: url,
            type: 'POST',
            data: $(this).serialize(),
            success: function (response) {
                if (response === 'addSucess' || response === 'editSucess') {
                    loadMarketerGroups();
                    return;
                }

                Swal.fire('خطا', 'ثبت اطلاعات انجام نشد.', 'error');
            },
            error: function () {
                Swal.fire('خطا', 'ارتباط با سرور برقرار نشد.', 'error');
            }
        });
    });
});
