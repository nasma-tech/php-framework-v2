<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-success mx-auto my-75">
                                <i class="bx bx-wallet font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50">مبلغ نهایی پیشفاکتور</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{$numberNormalizer->floatNumberFormat($getData.invoiceDetail.invoice_sum_total)}
                                <span>ریال</span></h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 pl-md-0">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-primary mx-auto my-75">
                                <i class="bx bx-basket font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50">تعداد ردیف محصولات</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{$getData.invoice_product_count}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                {assign var="remainingDays" value=ceil(($getData.day_validity_timestamp - time()) / 86400)}
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-danger mx-auto my-75">
                                <i class="bx bx-timer font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50">مانده تا پایان اعتبار</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{$remainingDays}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 pl-md-0">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-warning mx-auto my-75">
                                <i class="bx bx-edit-alt font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50">تعداد ویرایش</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{$getData.invoice_log_count|default:0}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="card shadow" style="margin-top: 3px">
                    <div class="card-content">
                        {foreach $invoiceLog|default:[] as $item}
                            {assign var="decodeProformaInvoiceDetails" value=json_decode($item.ProformaInvoiceDetails,true)}
                            <input readonly
                                   type="hidden"
                                   class="editTotalPriceChart"
                                   data-date="{jdate("Y/m/d",strtotime($item['created_at']))}"
                                   value="{$decodeProformaInvoiceDetails[0]['invoice_sum_total']|default:0}">
                        {/foreach}
                        <div class="card-body" id="proformaRevisionChart"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 pl-md-0">
        <div class="card shadow" style="margin-top: 3px">
            <div class="card-content">
                <div class="card-body">
                    <ul class="widget-timeline mb-0" style="height: 665px;overflow-y: auto">
                        {foreach $invoiceLog as $item}
                            <li class="timeline-items timeline-icon-primary active">
                                <div class="timeline-time">{jdate("H:i Y/m/d",strtotime($item.created_at))}</div>
                                <h6 class="timeline-title">ویرایش  | <code>{$userHelper->getUserFullName($item.user_id)}</code></h6>
                                <p class="timeline-text">2 ساعت پیش</p>
                                <div class="timeline-content">
                                    <img src="{$userHelper->getUserImage($item.user_id)}" alt="document" height="23" width="19" class="mr-50">
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

