<div class="row">
    <div class="col-md-12">
        <div class="card shadow">
            <div class="card-content">
                <div class="card-body">
                    <a class="badge badge-primary text-white mb-1"
                       style="float: left;margin-right: 5px;cursor: pointer"
                       data-toggle="modal" data-target="#newProjectModal">
                        پروژه جدید
                    </a>
                    <div class="table-responsive">
                        <table class="table dataTable text-center">
                            <thead class="thead-dark">
                            <tr>
                                <th class="border">#</th>
                                <th class="border">کد پروژه</th>
                                <th class="border">نحوه پرداخت</th>
                                <th class="border">نوع خرید</th>
                                <th class="border">نوع صنعت</th>
                                <th class="border">کارشناس</th>
                                <th class="border">عملیات</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $contactData.projectData|default:[] as $item}
                                <tr>
                                    <td class="border">{counter}</td>
                                    <td class="border">
                                        <kbd>{$item.project_code}</kbd>
                                    </td>
                                    <td class="border">{(($item.payment_type == 1)?'نقد':'اقساط')}</td>
                                    <td class="border">{(($item.payment_type == 1)?'نو':'کارکرده')}</td>
                                    <td class="border">{$item.industryTypeData.title}</td>
                                    <td class="border">{$item.expertData.first_name|default:$item.userData.first_name} {$item.expertData.last_name|default:$item.userData.last_name}</td>
                                    <td class="border">
                                        <div class="dropup">
                                                    <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer"
                                                          data-toggle="dropdown" aria-haspopup="true"
                                                          aria-expanded="false" role="menu">
                                                    </span>
                                            <div class="dropdown-menu" x-placement="bottom-start">
                                                <a class="dropdown-item text-primary" href="/ContactProjects/ContactProjectDetail/{$item.id}" target="_blank">
                                                    <i class="bx bx-circle text-primary mr-1"></i>
                                                    پیگیری
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
<form action="/ContactProjects/add" method="post">
    <input type="hidden" name="contact_id" value="{$contactData->id}">
    <div class="modal fade text-left w-100" id="newProjectModal" tabindex="-1" role="dialog"
         aria-labelledby="projectLabel"
         aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="projectLabel">تعریف پروژه جدید</h4>
                </div>
                <div class="modal-body line-height-2" style="height: 600px">
                    {include 'CustomerContactInformation/ContactProject.tpl'}
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-light-secondary" data-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">بستن</span>
                    </button>
                    <button type="submit" class="btn btn-sm btn-primary">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">ثبت پروژه جدید</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>
