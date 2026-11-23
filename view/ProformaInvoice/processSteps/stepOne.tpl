<div class="row">
    <div class="col-md-12">
        <div class="table table-responsive">
            <table class="table table-striped table-hover text-center">
                <thead class="thead-dark">
                <tr>
                    <th class="border">#</th>
                    <th class="border">نام محصول</th>
                    <th class="border">مقدار</th>
                    <th class="border">واحد</th>
                    <th class="border">قیمت واحد</th>
                    <th class="border">تخفیف</th>
                    <th class="border">جمع تخفیف</th>
                    <th class="border">جمع بدون تخفیف</th>
                    <th class="border">مبلغ نهایی</th>
                </tr>
                </thead>
                <tbody>
                {foreach $getData.invoiceProduct as $item}
                    <tr>
                        <td class="border">{$item.id}</td>
                        <td class="border">{$item.product.serial_number} - {$item.product.label}</td>
                        <td class="border">{$numberNormalizer->floatNumberFormat($item.amount)}</td>
                        <td class="border">{$item.product.measurementUnit.label}</td>
                        <td class="border">{$numberNormalizer->floatNumberFormat($item.unit_price_edit)}</td>
                        <td class="border">{$numberNormalizer->floatNumberFormat($item.discount_unit_amount_cash)}</td>
                        <td class="border">{$numberNormalizer->floatNumberFormat($item.discount_amount)}</td>
                        <td class="border">{$numberNormalizer->floatNumberFormat($item.sum_unit_price)}</td>
                        <td class="border">{$numberNormalizer->floatNumberFormat($item.total_product_price)}</td>
                    </tr>
                    {foreachelse}
                    <tr>
                        <td class="border" colspan="9">محصولی یافت نشد !!!</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-md-12">
        <div class="card bg-rgba-light border rounded">
            <div class="card-content">
                <div class="card-body">
                    <div class="invoice-subtotal">
                        <div class="invoice-calc d-flex justify-content-between mt-2">
                            <span class="invoice-title">جمع ناخالص</span>
                            <span class="invoice-value">{$numberNormalizer->floatNumberFormat($getData.invoiceDetail.invoice_sum)} <span>ریال</span></span>
                        </div>
                        <div class="invoice-calc d-flex justify-content-between mt-2">
                            <span class="invoice-title">تخفیف</span>
                            <span class="invoice-value">{$numberNormalizer->floatNumberFormat($getData.invoiceDetail.invoice_sum_discount)} <span>ریال</span></span>
                        </div>
                        <div class="invoice-calc d-flex justify-content-between mt-2">
                            <span class="invoice-title">جمع خالص</span>
                            <span class="invoice-value">{$numberNormalizer->floatNumberFormat($getData.invoiceDetail.invoice_net_sum)} <span>ریال</span></span>
                        </div>
                        {assign var="decodeChargesDeductions" value=json_decode($getData.invoiceDetail.charges_deductions,true)}
                        {assign var="decodeChargesDeductionsCalculate" value=json_decode($getData.invoiceDetail.invoice_sum_tax_details,true)}
                        {foreach $decodeChargesDeductions as $item}
                            {assign var="calculate" value=0}
                            {foreach $decodeChargesDeductionsCalculate as $calculateItem}
                                {if $calculateItem.charges_deduction_id == $item.charges_deduction_id}
                                    {assign var="calculate" value=$calculateItem.calculate}
                                    {break}
                                {/if}
                            {/foreach}
                            <div class="invoice-calc d-flex justify-content-between mt-2">
                                <span class="invoice-title">{$item.title}</span>
                                <span class="invoice-value">{$calculate|number_format:0:'.':','} <span>ریال</span></span>
                            </div>
                        {/foreach}
                        <hr>
                        <div class="invoice-calc d-flex justify-content-between mt-2">
                            <span class="invoice-title">جمع کل</span>
                            <span class="invoice-value">{$numberNormalizer->floatNumberFormat($getData.invoiceDetail.invoice_sum_total)} <span>ریال</span></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>