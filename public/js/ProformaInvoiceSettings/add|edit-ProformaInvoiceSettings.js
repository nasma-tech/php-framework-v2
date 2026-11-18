$(function () {

    const sortable = new Sortable(
        document.getElementById('sortableRows'),
        {
            animation: 200,
            handle: '.drag-handle',
            ghostClass: 'sortable-ghost',
            chosenClass: 'sortable-chosen',
            onEnd: function () {
                let priorities = [];
                let counter = 1;
                $('#sortableRows tr').each(function (index) {
                    priorities.push({
                        id: $(this).data('id'),
                        priority: index + 1
                    });
                    $(this).find('td').eq(0).text(counter)
                    counter++;
                });
                console.log(priorities)
            }
        }
    );


    $("#top_invoice_text").joditEditor()
    $("#bottom_invoice_text").joditEditor()
    $("#payment_terms").joditEditor()


})