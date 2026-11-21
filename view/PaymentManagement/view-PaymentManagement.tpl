{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        <div class="container">
            {$helper->formCallBack()}
            <div class="row">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4 class="card-title" style="float: right">مشاهده واریزی</h4>
                            {$buttonHelper->refreshAndBackButton()}
                        </div>
                    </div>
                </div>
            </div>

            {$helper->csrfTokenInput()}
            <div class="row mt-1" id="mainRowPayment">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h6>{$getData->paymentMethodData->title}</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                {if $getData->chequeData}

                                {else}
                                    <div class="col-md-3">
                                        <label for="">شماره حساب</label>
                                        <select class="form-control" name="" id=""></select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="">شماره پیگیری</label>
                                        <input class="form-control" type="text" name="" id="">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="">تاریخ واریز</label>
                                        <input class="form-control" type="text" name="" id="">
                                    </div>
                                    <div class="col-md-3">
                                        <label for=""></label>
                                        <input class="form-control" type="text" name="" id="">
                                    </div>
                                    {*                                <div class="col-md-6 col-12 bg-rgba-success rounded">*}
                                    {*                                    <div class="row">*}
                                    {*                                        <img class="round"*}
                                    {*                                             id="userImageRound"*}
                                    {*                                             src="{((isset($smarty.session.userId)) ? $helper->checkUserImage($smarty.session.userId) : '')}"*}
                                    {*                                             alt="avatar"*}
                                    {*                                             height="40"*}
                                    {*                                             width="40">*}
                                    {*                                        <p>در انتظار تایید</p>*}
                                    {*                                    </div>*}
                                    {*                                </div>*}
                                {/if}
                            </div>
                        </div>
                    </div>

                    <div class="card shadow mt-1">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="card collapse-header">
                                                    <div id="headingCollapse1" class="card-header">
                                                        <div class="row border">

                                                            <div class="col-12 p-1 col-sm-3 text-center">
                                                                <img src="{$helper->checkUserImage($helper->getUserFullName($getCartableCirculationLog['lastLog']['userId']))}"
                                                                     class="rounded" alt="group image"
                                                                     height="120" width="120">
                                                            </div>
                                                            <div class="col-12 pt-1 px-0 col-sm-6">
                                                                <div class="row">
                                                                    <div class="col-12 text-center text-sm-left">
                                                                        <h6 class="media-heading mb-0 primary-font">{$helper->getUserFullName($getCartableCirculationLog['lastLog']['userId'])}
                                                                            <div class="badge badge-light-{$statusDictionary[$getCartableCirculationLog['lastLog']['confirmation']]['bs-color']}">
                                                                                {$statusDictionary[$getCartableCirculationLog['lastLog']['confirmation']]['label']}
                                                                            </div>
                                                                        </h6>
                                                                        <small class="text-muted align-top line-height-2">{$helper->getUserPermissionName($getCartableCirculationLog['lastLog']['permissionId'])}</small>
                                                                    </div>
                                                                    <div class="col-12 text-center text-sm-left">
                                                                        <div class="mb-1 mt-50 line-height-2">
                                                                            <small>آخرین بازدید: -</small>
                                                                        </div>
                                                                        {if $getCartableCirculationLog['lastLog']['userId'] == $smarty.session.userId}
                                                                            <button class="btn btn-icon btn-light-success mb-1"
                                                                                    data-toggle="tooltip"
                                                                                    data-placement="bottom"
                                                                                    title=""
                                                                                    data-original-title="تایید نهایی">
                                                                                <i class="cursor-pointer bx bx-check m-0"></i>
                                                                            </button>
                                                                            <button class="btn btn-icon btn-light-danger mb-1"
                                                                                    data-toggle="tooltip"
                                                                                    data-placement="bottom"
                                                                                    title=""
                                                                                    data-original-title="عدم تایید">
                                                                                <i class="cursor-pointer bx bx-x m-0"></i>
                                                                            </button>
                                                                        {/if}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-12 col-sm-3 mt-1">
                                                                <h6 class="text-center">مشخصات کارتابل</h6>
                                                                <p>عنوان کارتابل: مدیریت واریزی</p>
                                                                <p>تاریخ ایجاد: <span dir="ltr">{jdate("Y/m/d H:i")}</span></p>
                                                                <span>وضعیت: </span>
                                                                <div class="badge badge-light-warning">در گردش</div>
                                                            </div>

                                                            <div class="col-12 pb-1 text-center">
                                                                <section id="collapsible">
                                                                    <div class="collapsible">
                                                                        <button type="button"
                                                                                class="btn btn-sm p-0"
                                                                                data-toggle="collapse"
                                                                                role="button"
                                                                                data-target="#collapse1"
                                                                                aria-expanded="true"
                                                                                aria-controls="collapse1">مشاهده
                                                                            جزئیات<i class="bx bx-down-arrow"></i>
                                                                        </button>
                                                                    </div>
                                                                </section>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="collapse1" role="tabpanel"
                                                         aria-labelledby="headingCollapse1"
                                                         class="collapse border"
                                                         style="overflow-y: auto;max-height: 60vh">
                                                        <div class="card-content p-1">
                                                            <!-- timeline widget start -->
                                                            <ul class="widget-timeline">
                                                                <div class="col-12">
                                                                    {foreach $getCartableCirculationLog['circle'] as $timestamp => $items}
                                                                        {foreach $items as $item}
                                                                            <li class="timeline-items timeline-icon-{$statusDictionary[$item['confirmation']]['bs-color']} active">
                                                                                <div class="timeline-time" dir="ltr">
                                                                                    {jdate("Y/m/d H:i:s" , $timestamp)}
                                                                                </div>
                                                                                {*                                                                            <h6 class="timeline-title"></h6>*}
                                                                                <p class="timeline-text">
                                                                                    {$statusDictionary[$item['confirmation']]['label']}
                                                                                    توسط {$helper->getUserFullName($item['userId'])}
                                                                                </p>
                                                                                <div class="timeline-content mb-1">
                                                                                    <img src="{$helper->checkUserImage($item['userId'])}"
                                                                                         alt="userImage" height="36"
                                                                                         width="36"
                                                                                         class="mr-50 rounded-circle">
                                                                                    توضیحات: {$item['description']}
                                                                                </div>
                                                                            </li>
                                                                        {/foreach}
                                                                    {/foreach}
                                                                </div>
                                                                {*                                                                <li class="timeline-items timeline-icon-success active">*}
                                                                {*                                                                    <div class="timeline-time">سه شنبه 8:17*}
                                                                {*                                                                        ب.ظ*}
                                                                {*                                                                    </div>*}
                                                                {*                                                                    <h6 class="timeline-title">امیلیا کلارک</h6>*}
                                                                {*                                                                    <p class="timeline-text">در <a*}
                                                                {*                                                                                href="JavaScript:void(0);">لورم*}
                                                                {*                                                                            ایپسوم متن</a>*}
                                                                {*                                                                    </p>*}
                                                                {*                                                                    <div class="timeline-content">*}
                                                                {*                                                                        لورم ایپسوم متن ساختگی با تولید سادگی*}
                                                                {*                                                                        نامفهوم از*}
                                                                {*                                                                    </div>*}
                                                                {*                                                                </li>*}
                                                                {*                                                                <li class="timeline-items timeline-icon-primary active">*}
                                                                {*                                                                    <div class="timeline-time">5 روز پیش</div>*}
                                                                {*                                                                    <h6 class="timeline-title">لورم ایپسوم متن*}
                                                                {*                                                                        ساختگی با تولید</h6>*}
                                                                {*                                                                    <p class="timeline-text">در <a*}
                                                                {*                                                                                href="JavaScript:void(0);">نام*}
                                                                {*                                                                            پروژه</a></p>*}
                                                                {*                                                                    <div class="timeline-content">*}
                                                                {*                                                                        <img src="../../assets/images/icon/sketch.png"*}
                                                                {*                                                                             alt="document" height="36"*}
                                                                {*                                                                             width="27" class="mr-50">پوشه*}
                                                                {*                                                                        اطلاعات*}
                                                                {*                                                                    </div>*}
                                                                {*                                                                </li>*}
                                                                {*                                                                <li class="timeline-items timeline-icon-danger active">*}
                                                                {*                                                                    <div class="timeline-time">7 ساعت پیش</div>*}
                                                                {*                                                                    <h6 class="timeline-title">لورم ایپسوم متن*}
                                                                {*                                                                        ساختگی</h6>*}
                                                                {*                                                                    <p class="timeline-text">در <a*}
                                                                {*                                                                                href="JavaScript:void(0);">نام*}
                                                                {*                                                                            پروژه</a></p>*}
                                                                {*                                                                    <div class="timeline-content">*}
                                                                {*                                                                        <img src="../../assets/images/icon/pdf.png"*}
                                                                {*                                                                             alt="document" height="36"*}
                                                                {*                                                                             width="27" class="mr-50">Received.pdf*}
                                                                {*                                                                    </div>*}
                                                                {*                                                                </li>*}
                                                                {*                                                                <li class="timeline-items timeline-icon-info active">*}
                                                                {*                                                                    <div class="timeline-time">5 ساعت پیش</div>*}
                                                                {*                                                                    <h6 class="timeline-title">لورم ایپسوم متن*}
                                                                {*                                                                        ساختگی با تولید سادگی</h6>*}
                                                                {*                                                                    <p class="timeline-text">در <a*}
                                                                {*                                                                                href="JavaScript:void(0);">لورم*}
                                                                {*                                                                            ایپسوم متن</a>*}
                                                                {*                                                                    </p>*}
                                                                {*                                                                    <div class="timeline-content">*}
                                                                {*                                                                        لورم ایپسوم متن ساختگی با تولید سادگی*}
                                                                {*                                                                        نامفهوم از صنعت چاپ و با استفاده از*}
                                                                {*                                                                        طراحان گرافیک است. چاپگرها و متون بلکه*}
                                                                {*                                                                        روزنامه و مجله در ستون و سطرآنچنان*}
                                                                {*                                                                    </div>*}
                                                                {*                                                                </li>*}
                                                                {*                                                                <li class="timeline-items timeline-icon-warning">*}
                                                                {*                                                                    <div class="timeline-time">2 دقیقه پیش</div>*}
                                                                {*                                                                    <h6 class="timeline-title">لورم ایپسوم*}
                                                                {*                                                                        متن </h6>*}
                                                                {*                                                                    <p class="timeline-text">در <a*}
                                                                {*                                                                                href="JavaScript:void(0);">پسندیده*}
                                                                {*                                                                            شده</a></p>*}
                                                                {*                                                                    <div class="timeline-content">*}
                                                                {*                                                                        لورم ایپسوم متن*}
                                                                {*                                                                    </div>*}
                                                                {*                                                                </li>*}
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
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