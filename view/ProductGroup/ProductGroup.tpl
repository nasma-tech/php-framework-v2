{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>
                        <div class="heading-elements">
                        {$buttonHelper->refreshAndAddButton($singleName)}
                        </div>
                    </div>
                    <hr>
                    <div class="card-content">
                        <div class="card-body">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th class="border">عنوان</th>
                                            <th class="border">کاربر</th>
                                            <th class="border">زمان ثبت</th>
                                            <th class="border">عملیات</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $getData AS $data}
                                            <tr>
                                                <td class="border">{$data['label']}</td>
                                                <td class="border">{$data->users->full_name}</td>
                                                <td class="border">{jdate("Y/m/d",strtotime($data['created_at']))}</td>
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
</div>


{include 'sections/footer.tpl'}