<style>
    #step_4 {
        --preview-primary: #243b64;
        --preview-accent: #e34b4b;
        --preview-border: #e9edf3;
        --preview-bg: #f7f8fb;
        --preview-text: #344054;
        --preview-muted: #8490a3;

        background: #fff;
        border: 1px solid var(--preview-border);
        border-radius: 12px;
        box-shadow: 0 5px 22px rgba(30, 50, 80, .055) !important;
        overflow: hidden;
    }

    #step_4 .card-body {
        padding: 22px;
    }

    #step_4 .divider {
        margin: 0 0 22px;
    }

    #step_4 .divider .divider-text {
        color: var(--preview-primary);
        font-size: 13px !important;
        font-weight: 700;
        padding: 0 12px;
    }

    #step_4 .divider:before,
    #step_4 .divider:after {
        border-color: var(--preview-border);
    }

    /* Preview Sections */
    #step_4 .container {
        width: 100%;
        max-width: 100%;
        padding: 0;
        margin: 0 !important;
    }

    #step_4 .table-responsive {
        margin-bottom: 20px;
        border: 1px solid var(--preview-border);
        border-radius: 9px;
        overflow: hidden;
        background: #fff;
    }

    /* Tables */
    #step_4 table {
        margin-bottom: 0;
        width: 100%;
        border-collapse: collapse;
        color: var(--preview-text);
        font-size: 12px;
    }

    #step_4 table thead.thead-dark th {
        background: var(--preview-primary);
        color: #fff;
        border-color: rgba(255,255,255,.1) !important;
        font-size: 12px;
        font-weight: 600;
        padding: 11px 10px;
    }

    #step_4 table tbody td {
        padding: 11px 12px;
        border-color: var(--preview-border) !important;
        vertical-align: middle;
        color: var(--preview-text);
    }

    #step_4 table tbody tr:nth-child(even) {
        background: #f8f9fc;
    }

    #step_4 table tbody tr:hover {
        background: #f0f4fa;
    }

    /* Information Labels */
    #step_4 table tbody td:first-child {
        width: 30%;
        color: var(--preview-muted);
        font-weight: 600;
        white-space: nowrap;
    }

    #step_4 table tbody td:first-child span {
        font-size: 12px !important;
        font-weight: 600 !important;
    }

    /* Product Table */
    #step_4 #productsSummary tr td:first-child {
        width: auto;
    }

    #step_4 table th {
        white-space: nowrap;
    }

    #step_4 #productsSummary td {
        font-size: 11px;
    }

    /* Section Separators */
    #step_4 hr {
        border: 0;
        border-top: 1px dashed var(--preview-border);
        margin: 18px 0;
    }

    /* Text Areas */
    #step_4 textarea.form-control {
        min-height: 85px;
        resize: vertical;
        background: var(--preview-bg);
        border: 1px solid var(--preview-border);
        border-radius: 8px;
        padding: 13px 15px;
        color: var(--preview-text);
        font-size: 12px;
        line-height: 2;
        box-shadow: none;
    }

    #step_4 textarea.form-control:focus {
        border-color: #b6c5dc;
        background: #fff;
    }

    /* Responsive */
    @media (max-width: 767px) {
        #step_4 .card-body {
            padding: 12px;
        }

        #step_4 table {
            font-size: 11px;
        }

        #step_4 table tbody td {
            padding: 9px 8px;
        }

        #step_4 table tbody td:first-child {
            width: 35%;
        }

        #step_4 .table-responsive {
            margin-bottom: 14px;
        }
    }

</style>
<div class="card shadow stepsCard" style="margin-top: 3px" data-step="4" id="step_4">
    <div class="card-content">
        <div class="card-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="divider divider-left">
                        <div class="divider-text" style="font-size: 12px">پیش نمایش</div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="container">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover text-center">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border text-center" colspan="2">اطلاعات اولیه</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="border">
                                        <span style="font-weight: bold;font-size: 12px">تیم</span>
                                    </td>
                                    <td class="border" id="teamSummary"></td>
                                </tr>
                                <tr>
                                    <td class="border">
                                        <span style="font-weight: bold;font-size: 12px">مشتری</span>
                                    </td>
                                    <td class="border" id="customerSummary"></td>
                                </tr>
                                <tr>
                                    <td class="border">
                                        <span style="font-weight: bold;font-size: 12px">شرکت مشتری</span>
                                    </td>
                                    <td class="border" id="customerCompanySummary"></td>
                                </tr>
                                <tr>
                                    <td class="border">
                                        <span style="font-weight: bold;font-size: 12px">اعتبار</span>
                                    </td>
                                    <td class="border" id="validitySummary"></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="container" style="margin-top: 20px">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover text-center">
                                <thead class="thead-dark">
                                    <tr>
                                        <th class="border text-center" colspan="2">برند و محصول</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="border">
                                            <span style="font-weight: bold;font-size: 12px">برند</span>
                                        </td>
                                        <td class="border" id="brandSummary"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <hr>
                            <table class="table table-hover table-striped text-center">
                                <thead class="thead-dark text-center">
                                    <tr>
                                        <th class="border" colspan="8">محصولات</th>
                                    </tr>
                                    <tr>
                                        <th class="border">ردیف</th>
                                        <th class="border">محصول</th>
                                        <th class="border">مقدار</th>
                                        <th class="border">واحد</th>
                                        <th class="border">قیمت واحد (ریال)</th>
                                        <th class="border">مجموع</th>
                                        <th class="border">تخفیف</th>
                                        <th class="border">مجموع نهایی</th>
                                    </tr>
                                </thead>
                                <tbody id="productsSummary"></tbody>
                            </table>
                            <hr>
                            <table class="table table-hover table-striped text-center">
                                <thead class="thead-dark text-center">
                                <tr>
                                    <th class="border" colspan="2">اطلاعات تکمیلی</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="border">
                                            <span style="font-weight: bold;font-size: 12px">معرف</span>
                                        </td>
                                        <td class="border" id="marketerSummary"></td>
                                    </tr>
                                    <tr>
                                        <td class="border">
                                            <span style="font-weight: bold;font-size: 12px">کشور</span>
                                        </td>
                                        <td class="border" id="countrySummary"></td>
                                    </tr>
                                    <tr>
                                        <td class="border">
                                            <span style="font-weight: bold;font-size: 12px">استان</span>
                                        </td>
                                        <td class="border" id="stateSummary"></td>
                                    </tr>
                                    <tr>
                                        <td class="border">
                                            <span style="font-weight: bold;font-size: 12px">شهر</span>
                                        </td>
                                        <td class="border" id="citySummary"></td>
                                    </tr>
                                    <tr>
                                        <td class="border">
                                            <span style="font-weight: bold;font-size: 12px">تحویل</span>
                                        </td>
                                        <td class="border" id="deliverySummary"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="container" style="margin-top: 20px">
                        <textarea class="form-control" readonly id="paymentTermsSummary"></textarea>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="container" style="margin-top: 20px">
                        <textarea class="form-control" readonly id="bottomInvoiceTextSummary"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>