$(function () {
    $(document).validateFormBeforeSend({
        validateTextArea: true
    })
    $('form').on('submit', function (e) {

        $("#btnExport").click()

        this.submit
    })
});
