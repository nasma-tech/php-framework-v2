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
                                        <th class="">عنوان</th>
                                        <th class="">کاربر</th>
                                        <th class="">زمان ثبت </th>
                                        <th class="">آخرین بروزرسانی</th>
                                        <th class="">عملیات</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $getData AS $data}
                                        <tr>
                                            <td class="border">{$data['label']}</td>
                                            <td class="border">{$data->userData->full_name}</td>
                                            <td class="border">{jdate("Y/m/d",strtotime($data['create_at']))}</td>
                                            <td class="border">{jdate("Y/m/d",strtotime($data['update_at']))}</td>
                                            <td class="border">{$buttonHelper->actionButtons($data['id'])}</td>
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
