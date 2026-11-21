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
                            <table class="table text-center tableDataShow"
                                   style="background-color: #fff;border-radius: 5px;">
                                <thead class="thead-dark">
                                <tr>
                                    <th class="border">#</th>
                                    <th class="border">شناسه</th>
                                    <th class="border">عنوان</th>
                                    <th class="border">ضریب</th>
                                    <th class="border">عملیات</th>
                                </tr>
                                </thead>
                                <tbody>
                                    {foreach $list as $item}
                                        <tr>
                                            <td class="border">{counter}</td>
                                            <td class="border">{$item.identifier}</td>
                                            <td class="border">{$item.title}</td>
                                            <td class="border">{$item.coefficient}</td>
                                            <td class="border">
                                                <div class="dropdown">
                                                    <span class="bx bx-dots-horizontal-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="menu">
                                                </span>
                                                    <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(86px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                        <a class="dropdown-item rounded text-warning" href="/ChargesDeductions/editIndex/{$item.id}">
                                                            <i class="bx bx-edit-alt text-warning mr-1"></i> ویرایش
                                                        </a>
                                                        <a class="dropdown-item rounded text-danger" href="#">
                                                            <i class="bx bx-trash text-danger mr-1"></i> حذف
                                                        </a>
                                                    </div>
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
