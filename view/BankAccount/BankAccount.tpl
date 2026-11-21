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
                        <h4 class="card-title">لیست {$pluralName}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndAddButton({$singleName})}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <table class="table text-center table-hover table-striped tableDataShow"
                                   style="background-color: #fff;border-radius: 5px;">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border">#</th>
                                    <th class="border">لوگو</th>
                                    <th class="border">بانک</th>
                                    <th class="border">شعبه</th>
                                    <th class="border">شماره حساب</th>
                                    <th class="border">وضعیت</th>
                                    <th class="border">عملیات</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $list as $item}
                                    {$bankListData = $bankList::query()->find($item->bank_list_id)}
                                    <tr class="{($item->bank_status)?'bg-rgba-success':'bg-rgba-danger'}">
                                        {if $item->bank_list_id > 0}
                                            <td class="border">{$item->id}</td>
                                            <td class="border">
                                                <img src="{APP_URL}/Storage/bankLogo/{$bankListData->bank_list_logo}"
                                                     alt="" width="50" height="50">
                                            </td>
                                            <td class="border">{$bankListData->bank_list_name}</td>
                                        {else}
                                            <td class="border">{$item->id}</td>
                                            <td class="border">
                                                <img src="{APP_URL}/Storage/DefaultImages/notImage.png" alt=""
                                                     width="50" height="50">
                                            </td>
                                            <td class="border">-</td>
                                        {/if}
                                        <td class="border">{$item->bank_branch_name}</td>
                                        <td class="border">{$item->bank_account_number}</td>
                                        <td class="border">
                                            {if $item->bank_status}
                                                <div class="badge badge-success">فعال</div>
                                            {else}
                                                <div class="badge badge-danger">غیرفعال</div>
                                            {/if}
                                        </td>
                                        <td class="border text-center">{$buttonHelper->actionButtons($item->id)}</td>
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


{include 'sections/footer.tpl'}
