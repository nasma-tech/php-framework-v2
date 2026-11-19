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
                                <table class="table table-hover table-striped">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border">#</th>
                                        <th class="border">برند</th>
                                        <th class="border">کد محصول</th>
                                        <th class="border">عنوان محصول</th>
                                        <th class="border">گروه محصول</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $getData as $data}
                                        <tr>
                                            <td class="border">
                                                {counter}
                                            </td>
                                            <td class="border">
                                                {$data->brand->label}
                                            </td>
                                            <td class="border">
                                                {$data->serial_number}
                                            </td>
                                            <td class="border">
                                                {$data['label']}
                                            </td>
                                            <td class="border">
                                                {$data->productGroup->label}
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
