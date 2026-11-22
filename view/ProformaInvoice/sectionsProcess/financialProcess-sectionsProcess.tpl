<div class="row">
    <div class="col-md-12">
        <div class="card shadow" style="margin-top: 3px">
            <div class="card-body">
                <ul class="nav nav-tabs nav-justified" id="myTab2" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="totalPrice-tab-justified" data-toggle="tab"
                           href="#totalPrice-just" role="tab" aria-controls="totalPrice-just" aria-selected="false">
                            مبلغ کل
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="tab-pane active " id="totalPrice-just" role="tabpanel" aria-labelledby="totalPrice-tab-justified">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-3 pl-md-0">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-success mx-auto my-75">
                                <i class="bx bx-wallet font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50">مبلغ کل</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['invoice_sum_total'])}
                                <span>ریال</span>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 pl-md-0">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-primary mx-auto my-75">
                                <i class="bx bx-check font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50"> واریزی تایید شده</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['approvedPayment'])}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 pl-md-0">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-danger mx-auto my-75">
                                <i class="bx bx-timer font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50">واریزی درانتظار تایید</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['preparingPayment'])}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 pl-md-0">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-danger mx-auto my-75">
                                <i class="bx bx-x font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50">واریزی تایید نشده</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['canceledPayment'])}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 pl-md-0 pr-md-0">
                <div class="card shadow text-center" style="margin-top: 3px">
                    <div class="card-content">
                        <div class="card-body py-1">
                            <div class="badge-circle badge-circle-lg badge-circle-light-warning mx-auto my-75">
                                <i class="bx bx-money font-medium-5"></i>
                            </div>
                            <div class="text-muted line-ellipsis line-height-2 mb-50"> مانده مبلغ</div>
                            <h3 class="line-height-1 mb-50 primary-font font-size-base">{number_format($paymentData['invoice_sum_total'] - $paymentData['approvedPayment'])}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="divider">
        <div class="divider-text">اطلاعات اولیه</div>
    </div>
    <div class="card mt-2 shadow" style="margin-top: 3px">
        <div class="card-body">
            <div class="row">
                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                            <tr class="text-center">
                                <th class="border">نحوه پرداخت</th>
                                <th class="border">بانک</th>
                                <th class="border">شناسه واریز</th>
                                <th class="border">شماره چک</th>
                                <th class="border">تاریخ واریز</th>
                                <th class="border">مبلغ پرداختی</th>
                                <th class="border">توضیحات</th>
                                <th class="border">وضعیت پرداخت</th>
                                <th class="border">کاربر ثبت‌کننده</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $invoicePaymentDetail as $data}
                                <tr class="text-center">
                                    <td>{$data.payment.paymentMethodData.title|default:'-'}</td>
                                    <td>{$data.payment.bankAccountData.bank_branch_name|default:'-'}</td>
                                    <td>{$data.payment.reference_no|default:'-'}</td>
                                    <td>{$data.payment.chequeData.cheque_number|default:'-'}</td>
                                    <td>{jdate("Y/m/d",$data.payment.date_deposit)|default:'-'}</td>
                                    <td>{number_format($data.payment.amount_paid)|default:'-'}</td>
                                    <td>
                                        <button class="btn btn-sm btn-primary viewDescription"
                                                data-text="{$data.payment.payment_description|default:'-'}">
                                            <i class="bx bx-note"></i>
                                        </button>
                                    </td>
                                    <td>
                                        {if $data.status === 0}
                                            <div class="btn btn-sm btn-warning w-100 text-white">
                                                درانتظار تایید
                                            </div>
                                        {elseif $data.status === 1}
                                            <div class="btn btn-sm btn-success w-100 text-white">
                                                تایید شده
                                            </div>
                                        {elseif $data.status === 2}
                                            <div class="btn btn-sm btn-danger w-100 text-white">
                                                عدم تایید
                                            </div>
                                        {else}
                                            <div class="btn btn-sm btn-warning w-100 text-white">
                                                برسی مجدد
                                            </div>
                                        {/if}
                                    </td>
                                    <td>{$data.payment.userData.full_name|default:'-'}</td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>