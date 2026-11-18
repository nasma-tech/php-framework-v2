$(function () {
    addForm();
    editForm();
    justNumber("#manager_percent", 2);
    justNumber("#supervisor_percent", 2);

    $("#financial_manager").on('change', function () {
        let valueSelected = $(this).val();
        $("#sales_manager").html('').attr('disabled', false);
        $("#financial_manager option").each(function () {
            if (valueSelected != $(this).val()) {
                if ($(this).val().search('لطفا') != -1) {
                    $("#sales_manager").append('<option selected disabled>لطفا یک مورد را انتخاب کنید</option>');
                } else {
                    $("#sales_manager").append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                }
            }
        });
    });

    $("#sales_manager").on('change', function () {
        let valueSelected = $(this).val();
        $("#document_controller").html('').attr('disabled', false);
        $("#sales_manager option").each(function () {
            if (valueSelected != $(this).val()) {
                if ($(this).val().search('لطفا') != -1) {
                    $("#document_controller").append('<option selected disabled>لطفا یک مورد را انتخاب کنید</option>');
                } else {
                    $("#document_controller").append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                }
            }
        });
    });

    $("#document_controller").on('change', function () {
        let valueSelected = $(this).val();
        let financial_manager = $("#financial_manager").val();
        $("#sales_supervisor").html('').attr('disabled', false);
        $("#team_leader").html('').attr('disabled', false);
        $("#sales_expert").html('').attr('disabled', false);
        $("#sales_manager option").each(function () {
            if (valueSelected != $(this).val() && valueSelected != financial_manager) {
                if ($(this).val().search('لطفا') != -1) {
                    $("#sales_supervisor").append('<option selected disabled>لطفا یک مورد را انتخاب کنید</option>');
                    $("#team_leader").append('<option selected disabled>لطفا یک مورد را انتخاب کنید</option>');
                } else {
                    $("#sales_supervisor").append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                    $("#team_leader").append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                    $("#sales_expert").append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                }
            }
        });
    });


    $("#team_leader").on('change', function () {
        let leader = $(this).val();
        $("#sales_expert").val(leader).change();
    });
    
});