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
                            <table class="table text-center tableDataShow">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border">#</th>
                                    <th class="border">نام و نام خانوادگی</th>
                                    <th class="border">نام کاربری</th>
                                    <th class="border">دسترسی</th>
                                    <th class="border">شماره تماس</th>
                                    <th class="border">عملیات</th>
                                </tr>
                                </thead>
                                <tbody id="userBodyTable">
                                {foreach $list as $item}
                                    <tr>
                                        <td class="border">{$item->id}</td>
                                        <td class="border">{$item->full_name}</td>
                                        <td class="border">{$item->username}</td>
                                        <td class="border">{((isset($item->roleData->title)) ? $item->roleData->title : 'نامشخص')}</td>
                                        <td class="border">--------</td>
                                        <td class="border">{$buttonHelper->actionButtons($item->id)}</td>
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