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
                            <div class="table-responsive">
                                <table class="table tableDataShow text-center"
                                       style="background-color: #fff;border-radius: 5px;">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border">عنوان</th>
                                        <th class="border">لوگو</th>
                                        <th class="border">کاربر</th>
                                        <th class="border">تاریخ ثبت</th>
                                        <th class="border">عملیات</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $getData AS $data}
                                        <tr>
                                            <td class="border">{$data['label']}</td>
                                            <td class="border text-center align-middle">
                                                {if !empty($data['logo_address'])}
                                                    <div class="avatar  avatar-xl"><img src="/Storage/brands/{$data['logo_address']}" alt="{$data['label']}"></div>
                                                {else}
                                                    <span class="text-muted">بدون لوگو</span>
                                                {/if}
                                            </td>
                                            <td class="border">{$data->users->full_name}</td>
                                            <td class="border">{jdate("Y/m/d",strtotime($data['created_at']))}</td>
                                            <td class="border text-center">{$buttonHelper->actionButtons($data['id'])}</td>
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
