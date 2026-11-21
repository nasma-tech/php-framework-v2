{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-overlay"></div>
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">{$pluralName}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndAddButton('واریزی')}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table text-center table-hover table-striped tableDataShow" style="background-color: #fff;border-radius: 5px;">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border">لوگو</th>
                                        <th class="border">بانک</th>
                                        <th class="border">نحوه واریز</th>
                                        <th class="border">شناسه واریز/شناسه صیاد</th>
                                        <th class="border">تاریخ واریز/تاریخ چک</th>
                                        <th class="border">مبلغ واریزی (ریال)</th>
                                        <th class="border">عملیات</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $list as $item}
                                        {$chequeData = $item->chequeData}
                                        {if $item->payment_status == 0}
                                            <tr class="bg-rgba-warning" data-toggle="tooltip" data-placement="left" title=""
                                                data-original-title="در انتظار تایید">
                                                {elseif $item->payment_status == 1}
                                            <tr class="bg-rgba-success" data-toggle="tooltip" data-placement="left" title=""
                                                data-original-title="تایید شده">
                                                {elseif $item->payment_status == 2}
                                            <tr class="bg-rgba-danger" data-toggle="tooltip" data-placement="left" title=""
                                            data-original-title="عدم تایید">
                                        {/if}
                                        <td class="border">
                                            {if $item->bank_account_id}
                                                <div class="avatar">
                                                    <img src="{APP_URL}/Storage/bankLogo/{$item->bankAccountData->bankData->bank_list_logo}"
                                                         alt="{$item->bankAccountData->bankData->bank_list_name}"
                                                         height="20" width="20">
                                                </div>
                                            {else}
                                                -
                                            {/if}
                                        </td>
                                        <td class="border">
                                            {if $item->bank_account_id}
                                                {$item->bankAccountData->bankData->bank_list_name}
                                            {else}
                                                -
                                            {/if}
                                        </td>
                                        <td class="border">{$item->paymentMethodData->title}</td>
                                        <td class="border">
                                            {if $item->reference_no}
                                                {$item->reference_no}
                                            {elseif $item->cheque_management_id}
                                                {$chequeData->cheque_number}
                                            {else}
                                                -
                                            {/if}
                                        </td>
                                        <td class="border">
                                            {if $item->date_deposit}
                                                {jdate("Y/m/d",$item->date_deposit)}
                                            {else}
                                                {jdate("Y/m/d",$chequeData->cheque_deposit_date)}
                                            {/if}
                                        </td>
                                        <td class="border">
                                            {if $item->amount_paid}
                                                {$helper->floatNumberFormat($item->amount_paid)}
                                            {else}
                                                {$helper->floatNumberFormat($chequeData->cheque_amount)}
                                            {/if}
                                        </td>
                                        <td class="border">
                                            <div class="btn-group" role="group" aria-label="Basic example">
                                                <button type="button" class="btn btn-sm btn-icon btn-primary">
                                                    <i class="bx bx-history"></i>
                                                </button>
                                            </div>
                                        </td>
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
    </div>
</div>


{include 'sections/footer.tpl'}
