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

                    <div class="card-body">
                        <ul class="nav nav-pills nav-justified" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="person-tab-justified"
                                   data-toggle="pill" href="#person-justified"
                                   role="tab" aria-controls="person-justified" aria-selected="true">
                                    حقیقی
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="legal-tab-justified"
                                   data-toggle="pill" href="#legal-justified"
                                   role="tab" aria-controls="legal-justified" aria-selected="false">
                                    حقوقی
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="person-justified"
                             role="tabpanel" aria-labelledby="person-tab-justified">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead class="thead-dark">
                                        <tr class="text-center">
                                            <th class="border">اسم کامل</th>
                                            <th class="border">جنسبت</th>
                                            <th class="border">تاریخ تولد</th>
                                            <th class="border">کد ملی</th>
                                            <th class="border">مستندات</th>
                                            <th class="border">گروه بازاریابان</th>
                                            <th class="border">استان</th>
                                            <th class="border">کارشناسان</th>
                                            <th class="border">استان</th>
                                            <th class="border">شهر</th>
                                            <th class="border">درصد کمیسون</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $getData->where('marketer_type',"person") as $data}
                                            <tr class="text-center">
                                                <td class="border">{$data['marketer_full_name']}</td>
                                                <td class="border">
                                                    {if ($data['marketer_gender'] == "Mr")}
                                                        آقا
                                                    {else}
                                                        خانم
                                                    {/if}
                                                </td>
                                                <td class="border">{jdate("Y/m/d",$data['birth_date'])}</td>
                                                <td class="border">{$data['marketer_national_code']}</td>
                                                <td class="border text-center">
                                                    <button class="btn btn-sm btn-primary showDocument"
                                                            data-front_national_card_image="{$data['front_national_card_image']}"
                                                            data-back_national_card_image="{$data['back_national_card_image']}"
                                                            data-contract_image="{$data['contract_image']}"><i
                                                                class="bx bx-file"></i>
                                                    </button>
                                                </td>
                                                <td class="border">{$data->groupData->title}</td>
                                                <td class="border">{$data->expertData->full_name}</td>
                                                <td class="border">{$data->userData->full_name}</td>
                                                <td class="border">{$data->citiesData->states->title}</td>
                                                <td class="border">{$data->citiesData->title}</td>
                                                <td class="border">%{$data->commissionPercentage}</td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="legal-justified"
                             role="tabpanel" aria-labelledby="legal-tab-justified">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead class="thead-dark">
                                        <tr class="text-center">
                                            <th class="border">نام شرکت</th>
                                            <th class="border">شناسه ملی</th>
                                            <th class="border">تاریخ ثبت</th>
                                            <th class="border">نام مدیرعامل</th>
                                            <th class="border">نام رابط</th>
                                            <th class="border">گروه بازاریابان</th>
                                            <th class="border">استان</th>
                                            <th class="border">کارشناسان</th>
                                            <th class="border">استان</th>
                                            <th class="border">شهر</th>
                                            <th class="border">درصد کمیسون</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $getData->where('marketer_type',legal) as $data}
                                            <tr>
                                                <td class="border">{$data['company_name']}</td>
                                                <td class="border">{$data['company_national_code']}</td>
                                                <td class="border">{jdate("Y/m/d",$data['registration_date'])}</td>
                                                <td class="border">{$data['ceo_full_name']}</td>
                                                <td class="border">{$data['connector_full_name']}</td>
                                                <td class="border">{$data->groupData->title}</td>
                                                <td class="border">{$data->expertData->full_name}</td>
                                                <td class="border">{$data->userData->full_name}</td>
                                                <td class="border">{$data->citiesData->states->title}</td>
                                                <td class="border">{$data->citiesData->title}</td>
                                                <td class="border">%{$data->commissionPercentage}</td>

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
</div>


{include 'sections/footer.tpl'}