$(function () {
    $(".viewDescription").on('click',function () {
        let text = $(this).data('text')
        swal.fire({
            icon:'info',
            text:`${text}`,
            confirmButtonText:'بستن'
        })
    })
})