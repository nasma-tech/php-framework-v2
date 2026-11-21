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
                                <table class="table text-center table-striped table-hover tableDataShow"
                                       style="background-color: #fff;border-radius: 5px;">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border">شناسه</th>
                                        <th class="border">کد مشتری</th>
                                        <th class="border">نوع مشتری</th>
                                        <th class="border">مخاطب</th>
                                        <th class="border">استان</th>
                                        <th class="border">شهر</th>
                                        <th class="border">گروه مخاطب</th>
                                        <th class="border">نحوه آشنایی</th>
                                        <th class="border">عملیات</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $list as $item}
                                        <tr>
                                            <td class="border text-center">{$item.id}</td>
                                            <td class="border text-center">
                                                <kbd class="cc-code-badge">{$item.contact_code}</kbd>
                                            </td>
                                            <td class="border">
                                                {if $item->contact_type == 1}
                                                    حقیقی
                                                {else}
                                                    حقوقی
                                                {/if}
                                            </td>
                                            <td class="border">
                                                {$item->first_name|default:''} {$item->last_name|default:''}
                                            </td>
                                            <td class="border">
                                                {$item->stateDate->title|default:'-'}
                                            </td>
                                            <td class="border">
                                                {$item->cityDate->title|default:'-'}
                                            </td>
                                            <td class="border">
                                                {$item->contactGroupData->title|default:'-'}
                                            </td>
                                            <td class="border">
                                                {$item->contactAcquisitionSource->title|default:'-'}
                                            </td>
                                            <td class="border">
                                                <div class="dropup">
                                                    <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer"
                                                          data-toggle="dropdown" aria-haspopup="true"
                                                          aria-expanded="false" role="menu">
                                                    </span>
                                                    <div class="dropdown-menu" x-placement="bottom-start">
                                                        <a class="dropdown-item text-primary"
                                                           href="/CustomerContactInformation/contactDetail/{$item->id}">
                                                            <i class="bx bxs-chip mr-1 text-primary"></i> پیگیری
                                                        </a>
                                                        <a class="dropdown-item text-danger" href="#">
                                                            <i class="bx bx-trash text-danger mr-1"></i>
                                                            حذف
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
</div>


{include 'sections/footer.tpl'}
