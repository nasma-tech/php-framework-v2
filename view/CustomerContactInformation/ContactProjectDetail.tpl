{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-overlay"></div>
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title">شماره پروژه : <kbd>{$getData.project_code}</kbd> | مشتری
                            : {$getData.contactData.first_name} {$getData.contactData.last_name}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshBtn()}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-5" style="margin-top: 3px">
            <div class="col-md-6">
                <form action="/ContactProjects/edit/{$getData.id}" method="post">
                    {include 'CustomerContactInformation/ContactProject.tpl'}
                </form>
            </div>
            <div class="col-md-6 pl-0">
                <form action="/ContactProjectsFollowUp/add" method="post">
                    {$csrf->csrfTokenInput()}
                    <input type="hidden" name="contact_project_id" value="{$getData.id}" readonly="readonly">
                    {include 'CustomerContactInformation/ContactProjectFollowUp.tpl'}
                </form>
            </div>
            <div class="col-md-12">
                <div class="card shadow cc-initial-info">
                    <div class="card-content">
                        <div class="card-header">
                            <div class="divider divider-left">
                                <div class="divider-text" style="font-size: 11px">لیست پیگیری ها</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover text-center">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border">عنوان پیگیری</th>
                                        <th class="border">تاریخ ثبت</th>
                                        <th class="border">تاریخ پیگیری</th>
                                        <th class="border">کارشناس</th>
                                        <th class="border">وضعیت</th>
                                        <th class="border">وضعیت نتیجه</th>
                                        <th class="border">عملیات</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $getData.followUpData|default:[] as $item}
                                        {var_print($item.priceSuggestionData.id|default:'')}
                                        <tr>
                                            <td class="border">{$item.followUpActionTitleData.title}</td>
                                            <td class="border">{jdate("Y/m/d",strtotime($item.created_at))}</td>
                                            <td class="border">{jdate("Y/m/d",$item.next_followUp_date)}</td>
                                            <td class="border">{$item.userData.full_name}</td>
                                            <td class="border">
                                                {if $item.followUpActionData}
                                                    <div class="badge badge-pill badge-light-success">
                                                        پیگیری شده
                                                    </div>
                                                {else}
                                                    {if $item.next_followUp_date == strtotime('today')}
                                                        <div class="badge badge-pill badge-light-primary">
                                                            پیگیری های امروز
                                                        </div>
                                                    {elseif $item.next_followUp_date < strtotime('today')}
                                                        <div class="badge badge-pill badge-light-danger">
                                                            عقب افتاده
                                                        </div>
                                                    {elseif $item.next_followUp_date > strtotime('today')}
                                                        <div class="badge badge-pill badge-light-warning">
                                                            برنامه ریزی شده
                                                        </div>
                                                    {/if}
                                                {/if}
                                            </td>
                                            <td class="border">
                                                {if $item.followUpActionData}
                                                    <div class="badge badge-pill badge-light-success">
                                                        دارد
                                                    </div>
                                                {else}
                                                    <div class="badge badge-pill badge-light-warning">
                                                        ندارد
                                                    </div>
                                                {/if}
                                            </td>
                                            <td class="border">
                                                <div class="dropdown">
                                                    <span class="bx bx-dots-horizontal-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer"
                                                          data-toggle="dropdown" aria-haspopup="true"
                                                          aria-expanded="false" role="menu">
                                                    </span>
                                                    <div class="dropdown-menu">
                                                        {if !$item.followUpActionData}
                                                            <a class="dropdown-item text-primary actionMenuButton"
                                                               data-toggle="modal"
                                                               style="cursor: pointer"
                                                               data-type="add"
                                                               data-followup="{$item.id}"
                                                               data-target="#mainFollowUpAction">
                                                                <i class="bx bx-edit-alt mr-1 text-primary"></i>ثبت
                                                                نتیجه</a>
                                                        {else}
                                                            <a class="dropdown-item text-success actionMenuButton"
                                                               data-toggle="modal"
                                                               style="cursor: pointer"
                                                               data-type="show"
                                                               data-action="{$item.followUpActionData.followUp_description}"
                                                               data-date="{jdate("H:i - Y/m/d",$item.followUpActionData.action_time)}"
                                                               data-followup="{$item.id}"
                                                               data-user="{$item.followUpActionData.userData.full_name}"
                                                               data-target="#mainFollowUpAction">
                                                                <i class="bx bx-show mr-1 text-success"></i>مشاهده
                                                                نتیجه</a>
                                                        {/if}

                                                        {if $item.FollowUp_action_id == 8}
                                                            {if $item.priceSuggestionData|default:'' && !$item.priceSuggestionData.proformaInvoice}
                                                                <a class="dropdown-item text-warning"
                                                                   href="/PriceSuggestion/editPriceSuggestion/{$item.priceSuggestionData.id}"
                                                                   style="cursor: pointer">
                                                                    <i class="bx bxs-file mr-1 text-warning"></i> اصلاح
                                                                    پیشنهاد
                                                                    قیمت</a>
                                                                <a class="dropdown-item text-primary"
                                                                   href="/ProformaInvoice/createProformaInvoice/{$item.priceSuggestionData.id}"
                                                                   style="cursor: pointer">
                                                                    <i class="bx bxs-file-blank mr-1 text-primary"></i>صدور
                                                                    پیشفاکتور</a>
                                                            {elseif $item.priceSuggestionData.proformaInvoice}
                                                                <a class="dropdown-item text-warning"
                                                                   href="/ProformaInvoice/editIndex/{$item.priceSuggestionData.id}"
                                                                   style="cursor: pointer">
                                                                    <i class="bx bxs-file-blank mr-1 text-warning"></i>ویرایش
                                                                    پیشفاکتور</a>
                                                                {else}
                                                                <a class="dropdown-item text-success"
                                                                   href="/PriceSuggestion/createPriceSuggestion/{$getData.id}/{$item.id}"
                                                                   style="cursor: pointer">
                                                                    <i class="bx bxs-file mr-1 text-success"></i>پیشنهاد
                                                                    قیمت</a>
                                                            {/if}
                                                        {/if}
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

<form action="/ContactProjectsFollowUp/followUpActionSubmit" method="post">
    <input name="contact_project_id" type="hidden" value="{$getData.id}">
    <input name="contact_project_followUp_id" type="hidden">
    <div class="modal fade text-left" id="mainFollowUpAction" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel17"
         aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel17">نتیجه پیگیری</h4>
                </div>
                <div class="modal-body line-height-2">
                    <div class="row">
                        <div class="col-md-6 text-center" id="showDate"></div>
                        <div class="col-md-6 text-center" id="showUser"></div>
                        <div class="col-md-12">
                            <label for="followUp_action_description"></label>
                            <textarea class="form-control" id="followUp_action_description" name="followUp_description"
                                      rows="10"
                                      style="resize: none"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light-secondary" data-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">بستن</span>
                    </button>
                    <button type="submit" class="btn btn-primary ml-1" id="modalSubmit">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">ثبت نتیجه</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>

{include 'sections/footer.tpl'}
