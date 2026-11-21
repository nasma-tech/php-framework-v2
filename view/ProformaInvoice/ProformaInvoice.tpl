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
                            {$buttonHelper->refreshbtn()}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <div class="table-responsive table-responsive-lg table-responsive-sm table-responsive-xl">
                                <table class="table
{*                                tableDataShow *}
                                text-center"
                                       style="background-color: #fff;border-radius: 5px;">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th class="border">#</th>
                                        <th class="border">شماره پیشفاکتور</th>
                                        <th class="border">تاریخ صدور</th>
                                        <th class="border">ساعت صدور</th>
                                        <th class="border">بروزرسانی</th>
                                        <th class="border">ساعت بروزرسانی</th>
                                        <th class="border">مشتری</th>
                                        <th class="border">شرکت</th>
                                        <th class="border">برند</th>
                                        <th class="border">استان</th>
                                        <th class="border">شهر</th>
                                        <th class="border">کارشناس</th>
                                        <th class="border">پیش پرداخت</th>
                                        <th class="border">قرارداد</th>
                                        <th class="border">بازاریاب</th>
                                        <th class="border">عملیات</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $list as $item}
                                            <tr>
                                                <td class="border">{counter}</td>
                                                <td class="border">{$item.invoice_number}</td>
                                                <td class="border">{jdate("Y/m/d",strtotime($item.created_at))}</td>
                                                <td class="border">{jdate("H:i",strtotime($item.created_at))}</td>
                                                <td class="border">{($item.updated_at != $item.created_at)?jdate("Y/m/d",strtotime($item.updated_at)):' - '}</td>
                                                <td class="border">{jdate("H:i",strtotime($item.updated_at))}</td>
                                                <td class="border">{$item.contact.first_name} {$item.contact.last_name}</td>
                                                <td class="border">{$item.company.company_name|default:'-'}</td>
                                                <td class="border">{$item.brand.label}</td>
                                                <td class="border">{$item.state.title}</td>
                                                <td class="border">{$item.city.title}</td>
                                                <td class="border">{$item.expert.full_name}</td>
                                                <td class="border">
                                                    <div class="badge badge-light-warning w-100">ندارد</div>
                                                </td>
                                                <td class="border">
                                                    <div class="badge badge-light-warning w-100">ندارد</div>
                                                </td>
                                                <td class="border">
                                                    -
                                                </td>
                                                <td class="border">
                                                    <div class="dropup">
                                                        <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="menu">
                                                            </span>
                                                        <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(53px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                            <a class="dropdown-item" href="/ProformaInvoice/editIndex/{$item.id}"><i class="bx bx-edit-alt mr-1"></i>ویرایش</a>
                                                            <a class="dropdown-item" href="/ProformaInvoice/process/{$item.id}"><i class="bx bx-git-branch mr-1"></i>فرایند</a>
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