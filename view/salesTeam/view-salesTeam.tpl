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
                            {$buttonHelper->refreshAndAddButton($singleName)}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <table class="table table-hover table-striped tableDataShow dataTable">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border">#</th>
                                    <th class="border">عنوان</th>
                                    <th class="border">عملیات</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $list as $index => $item}
                                    <tr>
                                        <td class="border">
                                            {$index +1}
                                        </td>
                                        <td class="border">
                                            {$item->team_title}
                                        </td>
                                        <td class="border">
                                            <div>
                                                <a href="viewIndex/{$item->id}" class="badge badge-info badge-icon text-white" style="margin-right: 2px" data-toggle="tooltip" data-placement="top" title="" data-original-title="مشاهده">
                                                    <i class="bx bx-show-alt" style="font-size: 14px"></i>
                                                </a>
                                                <a href="editIndex/{$item->id}" class="badge badge-warning badge-icon text-white" data-toggle="tooltip" data-placement="top" title="" data-original-title="ویرایش" style="margin-right: 2px;">
                                                    <i class="bx bxs-edit-alt" style="font-size: 14px"></i>
                                                </a>
                                                <a href="permissions/{$item->id}" class="badge badge-permissions badge-icon text-white" style="margin-right: 2px" data-toggle="tooltip" data-placement="top" title="" data-original-title="دسترسی ها">
                                                    <i class="bx bx-key" style="font-size: 14px"></i>
                                                </a>
                                                <a href="#" rel="deleteIndex/delete/{$item->id}" data-id="{$item->id}" class="badge badge-danger badge-icon deleteButtonMain" data-toggle="tooltip" data-placement="top" title="" data-original-title="حذف" style="margin-right: 2px" aria-describedby="tooltip508339">
                                                    <i class="bx bxs-trash-alt" style="font-size: 14px"></i>
                                                </a>
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


{include 'sections/footer.tpl'}
