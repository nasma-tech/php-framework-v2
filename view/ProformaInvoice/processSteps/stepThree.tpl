<form action="/ProformaInvoice/addProductPartForm/{$getData.id}" method="post">
    {$csrf->csrfTokenInput()}
    <div class="row">
        <div class="col-12 col-md-3">
            <label for="allocationWarehouseId">انتخاب انبار</label>
            <select class="form-control select2" name="allocation_warehouse_id" required id="allocationWarehouseId">
                <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
                {foreach $warehouses as $warehouse}
                    <option value="{$warehouse.id}">{$warehouse.ware_house_name}</option>
                {/foreach}
            </select>
        </div>
        <div class="col-md-12" id="allocationInquiryElement" style="display: none">

        </div>
        <div class="col-12 mt-1">
            <div class="table-responsive">
                <table class="table table-striped table-hover text-center">
                    <thead class="thead-dark">
                    <tr>
                        <th class="border">#</th>
                        <th class="border">نام محصول</th>
                        <th class="border">مقدار قرارداد</th>
                        <th class="border">مقدار تخصیص داده شده</th>
                        <th class="border">مقدار تخصیص</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $getData.invoiceProduct as $item}
                        {$allocationData = $getAllocationData[$item.id]|default:[]}
                        <tr>
                            <td class="border">{counter}</td>
                            <td class="border">{$item.product.serial_number} - {$item.product.label}</td>
                            <td class="border">
                                <div class="input-group">
                                    <input class="form-control" type="text" id=""
                                           readonly
                                           value="{$numberNormalizer->floatNumberFormat($allocationData.contract_amount)}">
                                    <div class="input-group-append">
                                        <span class="input-group-text">{$item.product.measurementUnit.label}</span>
                                    </div>
                                </div>
                            </td>
                            <td class="border">
                                <div class="input-group">
                                    <input class="form-control" type="text"
                                           id="allocationReservedAmountInput_{$item.id}"
                                           readonly
                                           value="{$numberNormalizer->floatNumberFormat($allocationData.reserved_amount)}">
                                    <div class="input-group-append">
                                        <span class="input-group-text">{$item.product.measurementUnit.label}</span>
                                    </div>
                                </div>
                            </td>
                            <td class="border">
                                <div class="input-group">
                                    <input class="form-control allocationEnteredAmountInput" type="text"
                                           name="allocation_data[{$item.id}][amount]"
                                           id="allocationEnteredAmountInput_{$item.id}"
                                           data-id="{$item.id}"
                                           data-product_id="{$item.product_id}"
                                           placeholder="{$numberNormalizer->floatNumberFormat($allocationData.remaining_amount)}"
                                           data-max="{$allocationData.remaining_amount}"
                                           disabled
                                           value="">
                                    <div class="input-group-append">
                                        <span class="input-group-text">{$item.product.measurementUnit.label}</span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        {foreachelse}
                        <tr>
                            <td class="border" colspan="5">محصولی یافت نشد !!!</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
                <button type="submit" class="btn btn-sm btn-success" id="submitProductPart">ثبت پارت</button>
            </div>
        </div>
        <div class="col-12">
            <div class="divider">
                <div class="divider-text">لیست پارت ها</div>
            </div>
        </div>
        <div class="col-12">
            {foreach $productPart as $productPartDatum}
                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead class="thead-dark">
                        <tr>
                            <th class="border">#</th>
                            <th class="border">نام محصول</th>
                            <th class="border">مقدار مقدار تخصیص داده شده</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $productPartDatum.productPartItems|default:[] as $key => $productPartItem}
                            <tr>
                                <td class="border">{$key + 1}</td>
                                <td class="border">{$productPartItem.invoiceProduct.product.serial_number}
                                    - {$productPartItem.invoiceProduct.product.label}</td>
                                <td class="border">
                                    <div class="input-group">
                                        <input class="form-control" type="text" name="" id=""
                                               readonly
                                               value="{$numberNormalizer->floatNumberFormat($productPartItem.amount)}">
                                        <span class="input-group-text">{$productPartItem.invoiceProduct.product.measurementUnit.label}</span>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            {/foreach}
        </div>
    </div>
</form>
