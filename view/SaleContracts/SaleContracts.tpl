{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right"> لیست {$pluralName}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshBtn()}
                        </div>
                    </div>
                    <hr>
                    <div class="card-content">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped text-center">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border">#</th>
                                        <th class="border">شماره قرارداد</th>
                                        <th class="border">صدور پیشفاکتور</th>
                                        <th class="border">تاریخ قرارداد</th>
                                        <th class="border">مشتری</th>
                                        <th class="border">شرکت</th>
                                        <th class="border">برند</th>
                                        <th class="border">استان</th>
                                        <th class="border">شهر</th>
                                        <th class="border">کارشناس</th>
                                        <th class="border">تبدیل به قرارداد توسط</th>
                                        <th class="border">الحاقیه</th>
                                        <th class="border">عملیات</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $list as $item}
                                        <tr>
                                            <td class="border">{counter}</td>
                                            <td class="border">
                                                <a target="_blank" href="/ProformaInvoice/process/{$item.proforma_invoice_id}">
                                                    {$item.proformaInvoice.invoice_number}
                                                </a>
                                            </td>
                                            <td class="border">{jdate("Y/m/d",strtotime($item.proformaInvoice.created_at))}</td>
                                            <td class="border">{jdate("Y/m/d",$item.convert_to_contract)}</td>
                                            <td class="border">{$item.proformaInvoice.contact.first_name} {$item.proformaInvoice.contact.last_name}</td>
                                            <td class="border">{$item.proformaInvoice.company.company_name|default:' - '}</td>
                                            <td class="border">{$item.proformaInvoice.brand.label|default:' - '}</td>
                                            <td class="border">{$item.proformaInvoice.state.title|default:' - '}</td>
                                            <td class="border">{$item.proformaInvoice.city.title|default:' - '}</td>
                                            <td class="border">{$item.proformaInvoice.expert.full_name|default:' - '}</td>
                                            <td class="border">{$item.expert.full_name|default:' - '}</td>
                                            <td class="border">
                                                {if $item.addendum_count > 0}
                                                    <div class="badge badge-light-success w-100">دارد</div>
                                                {else}
                                                    <div class="badge badge-light-warning w-100">ندارد</div>
                                                {/if}
                                            </td>
                                            <td class="border">
                                                <div class="dropup">
                                                        <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer"
                                                              data-toggle="dropdown" aria-haspopup="true"
                                                              aria-expanded="false" role="menu">
                                                            </span>
                                                    <div class="dropdown-menu" x-placement="bottom-start"
                                                         style="position: absolute; transform: translate3d(53px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                        <a class="dropdown-item"
                                                           target="_blank"
                                                           href="/ProformaInvoice/editIndex/{$item.proforma_invoice_id}"><i
                                                                    class="bx bxs-file-plus mr-1"></i>الحاقیه</a>
                                                        <a class="dropdown-item"
                                                           target="_blank"
                                                           href="/SaleContracts/saleContractDetail/{$item.id}"><i
                                                                    class="bx bxs-file-plus mr-1"></i>اطلاعات بیشتر</a>
                                                        <a class="dropdown-item"
                                                           target="_blank"
                                                           href="/ProformaInvoice/process/{$item.proforma_invoice_id}"><i
                                                                    class="bx bx-git-branch mr-1"></i>فرایند</a>
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