<div class="row">
    {foreach $productPart as $item}
        <div class="col-md-12">
            <form action="/ProductExitParts/add" method="post">
                <input type="hidden" name="part_id" value="{$item.id}">
                <input type="hidden" name="proforma_invoice_id" value="{$item.proforma_invoice_id}">
                {$csrf->csrfTokenInput()}
                <div class="card shadow border" style="margin-top: 6px">
                    <div class="card-content">
                        <div class="card-body">
                            <div class="table-responsive">
                                {assign var="decodeChargesDeductions" value=json_decode($item.proformaInvoice.invoiceDetail.charges_deductions,true)}
                                <table class="table table-striped table-hover text-center">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border" colspan="5">پارت - P {$item.id}</th>
                                    </tr>
                                    <tr>
                                        <th class="border">محصول</th>
                                        <th class="border">مقدار اولیه</th>
                                        <th class="border">واحد</th>
                                        <th class="border">
                                            قیمت واحد
                                            <br>
                                            <small class="text-white">پس از کسر تخفیف</small>
                                        </th>
                                        <th class="border" width="200">مقدار خروج</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $item.productPartItems as $partItem}
                                        <tr>
                                            <td style="display: none">
                                                <input type="hidden" class="form-control finalUnitPrice" readonly
                                                       data-part="{$item.id}"
                                                       value="{$partItem.invoiceProduct.total_unit_price}"
                                                       name="exitData[{$partItem.id}][total_unit_price]">
                                                {foreach $decodeChargesDeductions as $chargesDeductions}
                                                    <input type="hidden" class="form-control chargesDeductionInputs"
                                                           data-coefficient="{$chargesDeductions['coefficient']}"
                                                           data-merge="{$chargesDeductions['netSumMerge']}"
                                                           data-deduction="{$chargesDeductions['charges_deduction_id']}"
                                                           data-identifier="{$chargesDeductions['identifier']}"
                                                           readonly>
                                                {/foreach}
                                            </td>
                                            <td class="border">{$partItem.id}</td>
                                            <td class="border">{$partItem.amount}</td>
                                            <td class="border">{$partItem.invoiceProduct.product.measurementUnit.label}</td>
                                            <td class="border">
                                                {$numberNormalizer->floatNumberFormat($partItem.invoiceProduct.total_unit_price)}
                                            </td>
                                            <td class="border">
                                                <input class="form-control" readonly type="hidden"
                                                       value="{$partItem.id}"
                                                       name="exitData[{$partItem.id}][part_item_id]">
                                                <input class="form-control outBandAmount outBandAmount_{$item.id}"
                                                       data-part="{$item.id}"
                                                        {($partItem.productExitPartItem.exit_amount|default:'')?'readonly':''}
                                                       value="{$partItem.productExitPartItem.exit_amount|default:''}"
                                                       name="exitData[{$partItem.id}][exit_amount]"
                                                       >
                                            </td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                    <tfoot class="thead-dark">
                                    <tr>
                                        <th class="border" colspan="2">جمع</th>
                                        <th class="border" colspan="2"
                                            id="sumPart_{$item.id}">0
                                        </th>
                                        <th class="border">ریال</th>
                                    </tr>
                                    {foreach $decodeChargesDeductions as $chargesDeductions}
                                        <tr>
                                            <th colspan="2"
                                                class="border">{$chargesDeductions['title']} {($chargesDeductions['coefficient']-1) * 100}
                                                %
                                            </th>
                                            <th colspan="2" class="border"
                                                id="sumResult_{$chargesDeductions['identifier']}_{$item.id}">0
                                            </th>
                                            <th class="border">ریال</th>
                                        </tr>
                                    {/foreach}
                                    <tr>
                                        <th class="border" colspan="2">جمع پارت</th>
                                        <th class="border" colspan="2"
                                            id="exitSumPart_{$item.id}">0
                                        </th>
                                        <th class="border">ریال</th>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between border-top">
                        <small class="text-danger" style="font-size: 10px">توجه : در محاسبات بالا اعشار ها حذف شده
                            است</small>
                        {if !$item.productExitPart}
                            <button class="btn btn-sm btn-light-primary">ثبت خروج</button>
                        {else}
                            <div class="badge badge-light-success" style="font-size: 10px">
                                در مورخ <code>{jdate("Y/m/d | H:i" ,strtotime($item.productExitPart.created_at))}</code>
                                اعلام خروج توسط <code>{$item.expert.full_name}</code> انجام شده است .
                            </div>
                        {/if}
                    </div>
                </div>
            </form>
        </div>
    {/foreach}
</div>