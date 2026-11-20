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
                            <a href="addGroupIndex" class="badge badge-primary text-white">
                                <i class="bx bx-plus"></i>
                                افزودن گروه
                            </a>
                        </div>
                    </div>

                    <div class="card-content">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead class="thead-dark">
                                    <tr class="text-center">
                                        <th>نام گروه</th>
                                        <th>تاریخ ثبت</th>
                                        <th>کاربر</th>
                                        <th>عملیات</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    {foreach $list AS $data}
                                        <tr class="text-center">
                                            <td>{$data['label']}</td>
                                            <td>{jdate("Y/m/d",strtotime($data['created_at']))}</td>
                                            <td>{$data->users->full_name}</td>
                                            <td>
                                                <button class="btn btn-sm btn-warning viewDetail"
                                                        data-id="{$data['id']}"
                                                        data-label="{$data['label']}">
                                                    <i class="bx bx-show-alt"></i>
                                                </button>

                                                <a class="btn btn-sm btn-primary"
                                                   href="/salesTeam/editGroup/{$data['id']}">
                                                    <i class="bx bx-edit-alt text-white"></i>
                                                </a>

                                                <button class="btn btn-sm btn-danger deleteGroup"
                                                        data-id="{$data['id']}">
                                                    <i class="bx bx-trash-alt"></i>
                                                </button>
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


<div class="modal fade" id="groupDetailModal" tabindex="-1" role="dialog"
     aria-labelledby="groupDetailModalLabel" aria-hidden="true">

    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="groupDetailModalLabel">
                    اطلاعات گروه
                </h5>

                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <div id="groupDetailContent">
                    <div class="text-center">
                        در حال دریافت اطلاعات...
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                    بستن
                </button>
            </div>

        </div>
    </div>
</div>

{include 'sections/footer.tpl'}