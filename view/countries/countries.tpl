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
                            <table class="table tableDataShow"
                                   style="background-color: #fff;border-radius: 5px;">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border">#</th>
                                    <th class="border">نام کشور</th>
                                    <th class="border">پیش شماره</th>
                                    <th class="border">عملیات</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $countries as $item}
                                    <tr>
                                        <td class="border">{$item->id}</td>
                                        <td class="border">
                                            {$item->persian_title}
                                        </td>
                                        <td class="border" dir="ltr">{$item->persian_title}</td>
                                        <td class="border text-center" dir="ltr">{$buttonHelper->actionButtons($item->id)}</td>
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
