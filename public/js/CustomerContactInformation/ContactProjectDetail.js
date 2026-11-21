$(function () {
    $(".actionMenuButton").on('click', function () {
        let type = $(this).data('type');
        switch (type) {
            case "add": {
                let followUpId = $(this).data('followup');
                $("[name='contact_project_followUp_id']").val(followUpId)
                $("#followUp_action_description").attr('readOnly',false).val('')
                $("#showDate").html('')
                $("#showUser").html('')
                $("#modalSubmit").show()
            }
                break;
            case "show": {
                let description = $(this).data('action')
                let date = $(this).data('date')
                let user = $(this).data('user')
                $("#followUp_action_description").attr('readOnly',true).val(description)
                $("#showDate").html(`<h6>تاریخ و ساعت : ${date}</h6>`)
                $("#showUser").html(`<h6>کاربر : ${user}</h6>`)
                $("#modalSubmit").hide()
            }
                break;
        }
    })
})