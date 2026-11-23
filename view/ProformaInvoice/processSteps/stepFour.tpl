<div class="row">
    {foreach $productPart as $item}
        <div class="col-md-12">
            <div class="card shadow border" style="margin-top: 6px">
                <div class="card-content">
                    <div class="card-body">
                        <div class="table-responsive">
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
                                        <td class="border">{$partItem.id}</td>
                                        <td class="border">{$partItem.amount}</td>
                                        <td class="border">{$partItem.invoiceProduct.product.measurementUnit.label}</td>
                                        <td class="border">
                                            {$numberNormalizer->floatNumberFormat($partItem.invoiceProduct.total_unit_price)}
                                        </td>
                                        <td class="border">
                                            <input class="form-control outBandAmount">
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                                <tfoot class="thead-dark">
                                    <tr>
                                        <th class="border" colspan="3">جمع</th>
                                        <th class="border" colspan="2">0</th>
                                    </tr>
                                    {assign var="decode" value=json_decode($item.proformaInvoice.invoiceDetail.charges_deductions,true)}
                                    {foreach $decode as $chargesDeductions}
                                        <tr>
                                            <th colspan="3" class="border">{$chargesDeductions['title']} {($chargesDeductions['coefficient']-1) * 100} %</th>
                                            <th colspan="2" class="border">0</th>
                                        </tr>
                                    {/foreach}
                                    <tr>
                                        <th class="border" colspan="3">جمع پارت</th>
                                        <th class="border" colspan="2">0</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between">
                    <span></span>
                    <button class="btn btn-sm btn-light-primary">ثبت خروج</button>
                </div>
            </div>
        </div>
    {/foreach}
</div>