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
                            {$buttonHelper->refreshAndBackButton()}

                        </div>
                    </div>

                    <div class="card-content">
                        <div class="card-body">
                            <form method="POST" action="/salesTeam/addSalesTeamSetting/{$salesTeamId}">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead class="thead-dark">

                                        <tr>
                                            <th class="border text-center" rowspan="2">کاربر</th>
                                            <th class="border text-center" colspan="4">دسترسی ها</th>
                                        </tr>
                                        <tr class="text-center">

                                            <th class="border">ثبت بالاتر از قیمت</th>
                                            <th class="border">پایین تر از قیمت</th>
                                            <th class="border">درصد تخفیف</th>
                                            <th class="border">بستن فروش</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $Users As $key => $user}
                                            {$data = $getData->where('member_id',$user['id'])->first()}
                                            <tr class="text-center">
                                                <td class="border">{$user['full_name']}</td>
                                                <td class="border">
                                                    <div class="checkbox checkbox-success">
                                                        <input type="checkbox" id="overPrice[{$user['id']}]" name="{$user['id']}[overPrice]" value="True" {if isset($data->overPrice) && $data->overPrice}checked{/if}>
                                                        <label for="overPrice[{$user['id']}]"></label>
                                                    </div>
                                                </td>
                                                <td class="border">
                                                    <div class="checkbox checkbox-success">
                                                        <input type="checkbox" id="underPrice[{$user['id']}]" name="{$user['id']}[underPrice]" value="True" {if isset($data->underPrice) && $data->underPrice}checked{/if}>
                                                        <label for="underPrisce[{$user['id']}]"></label>
                                                    </div>
                                                </td>
                                                <td class="border">
                                                    <div class="checkbox checkbox-success">
                                                        <input type="checkbox" id="discountPercent[{$user['id']}]" name="{$user['id']}[discountPercent]" value="True" {if isset($data->discountPercent) && $data->discountPercent}checked{/if}>
                                                        <label for="discountPercent[{$user['id']}]"></label>
                                                    </div>
                                                </td>
                                                <td class="border">
                                                    <div class="checkbox checkbox-success">
                                                        <input type="checkbox" id="seleClose{$user['id']}" name="{$user['id']}[seleClose]" value="True" {if isset($data->sellClose) && $data->sellClose}checked{/if}>                                                        <label for="seleClose{$user['id']}"></label>
                                                    </div>
                                                </td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-12 text-right">
                                <button class="btn btn-sm btn-primary">ثبت</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include 'sections/footer.tpl'}