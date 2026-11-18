$(function () {
    $('.editFormAjax').on('click', function () {
        document.getElementById("jsonOutput").value = OrgChartModel.toJSON(window.__orgChartDiagram);
    });
    editForm('mainForm', 'edit', 'editSuccess', true, 'duplicate', 'حداقل یک کاربر در تیم دیگری عضو است.');
});