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
                            {$buttonHelper->refreshBtn()}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <table class="table tableDataShow"
                                   style="background-color: #fff;border-radius: 5px;">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border">#</th>
                                    <th class="border">کد</th>
                                    <th class="border">محل صدور</th>
                                </tr>
                                </thead>
                                <tbody>
                                    {foreach $getData as $item}
                                        <tr>
                                            <td class="border">{counter}</td>
                                            <td class="border">{$item['code']}</td>
                                            <td class="border">{$item['title']}</td>
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
