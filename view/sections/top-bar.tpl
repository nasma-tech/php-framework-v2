<body
        class="vertical-layout vertical-menu-modern boxicon-layout no-card-shadow 2-columns  navbar-sticky fixed-footer"
        data-open="click" data-menu="vertical-menu-modern" data-col="2-columns" data-layout="semi-dark-layout">

<nav class="header-navbar main-header-navbar navbar-expand-lg navbar navbar-with-menu fixed-top ">
    <div class="navbar-wrapper">
        <div class="navbar-container content">
            <div class="navbar-collapse" id="navbar-mobile">
                <div class="mr-auto float-left bookmark-wrapper d-flex align-items-center">
                    <ul class="nav navbar-nav">
                        <li class="nav-item mobile-menu d-xl-none mr-auto"><a
                                    class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i
                                        class="ficon bx bx-menu"></i></a>
                        </li>
                    </ul>
                </div>
                <ul class="nav navbar-nav float-right">
                    <li class="dropdown dropdown-notification nav-item">
                        <a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i
                                    class="ficon bx bx-check-shield bell-notify"></i>
                            <span class="badge badge-pill badge-danger badge-up reminderNotificationAlarm">0</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-media">
                            <li class="dropdown-menu-header">
                                <div class="dropdown-header px-1 py-75 d-flex justify-content-between">
                                    <span class="notification-title"><b class="reminderNotificationAlarm"></b> اعلان جدید</span>
                                </div>
                            </li>
                            <li class="scrollable-container media-list ps" id="reminderListShow"
                                style="height: 400px;overflow-y: auto"></li>
                            <li class="dropdown-menu-footer">
                                <a class="dropdown-item p-50 text-primary justify-content-center">خواندن همه اعلان
                                    ها</a>
                            </li>
                        </ul>
                    </li>

                    <li class="dropdown dropdown-notification nav-item">
                        <a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i
                                    class="ficon bx bx-bell bell-notify"></i>
                            <span class="badge badge-pill badge-primary badge-up showNotificationCount">0</span></a>
                        <ul class="dropdown-menu dropdown-menu-media">
                            {*                            <li class="scrollable-container media-list ps">*}
                            {*                                <div class="d-flex justify-content-between cursor-pointer border">*}
                            {*                                    <div class="media d-flex align-items-center py-0">*}
                            {*                                        <div class="media-left pr-0"><img class="mr-1"*}
                            {*                                                                          src="/public/images/icon/pdf.png"*}
                            {*                                                                          alt="avatar" height="39" width="39"></div>*}
                            {*                                        <div class="media-body">*}
                            {*                                            <h6 class="media-heading"><span*}
                            {*                                                        class="text-bold-500">به روز رسانی آماده است</span></h6><small*}
                            {*                                                    class="notification-text">لورم ایپسوم متن ساختگی با تولید*}
                            {*                                                سادگی</small>*}
                            {*                                        </div>*}
                            {*                                        <div class="media-right pl-0">*}
                            {*                                            <div class="row border-left text-center">*}
                            {*                                                <div class="col-12 px-50 py-50 border-bottom">*}
                            {*                                                    <h6 class="media-heading text-bold-500 mb-0">به‌روزرسانی</h6>*}
                            {*                                                </div>*}
                            {*                                                <div class="col-12 px-50 py-50">*}
                            {*                                                    <h6 class="media-heading mb-0">بستن</h6>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                    </div>*}
                            {*                                </div>*}
                            {*                                <hr>*}
                            {*                                <div class="ps__rail-x" style="left: 0; bottom: 0;">*}
                            {*                                    <div class="ps__thumb-x" tabindex="0" style="left: 0; width: 0;"></div>*}
                            {*                                </div>*}
                            {*                                <div class="ps__rail-y" style="top: 0; left: -6px;">*}
                            {*                                    <div class="ps__thumb-y" tabindex="0" style="top: 0; height: 0;"></div>*}
                            {*                                </div>*}
                            {*                            </li>*}
                            <li class="dropdown-menu-footer"><a
                                        class="dropdown-item p-50 text-primary justify-content-center"
                                        href="javascript:void(0)">خواندن همه اعلان ها</a></li>
                        </ul>
                    </li>
                    <li class="dropdown dropdown-user nav-item">
                        <a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                            <div class="user-nav d-sm-flex d-none">
                                <span class="user-name">{((isset($smarty.session.userFullName)) ? $smarty.session.userFullName : '')}</span>
                                <span class="user-status text-muted">{((isset($smarty.session.roleTitle)) ? $smarty.session.roleTitle : '')}</span>
                            </div>
                            <span>
                                <img class="round"
                                     id="userImageRound"
                                     src="{((isset($smarty.session.userId)) ? $userHelper->getUserImage($smarty.session.userId) : '')}"
                                     alt="avatar"
                                     height="40"
                                     width="40">
                            </span>
                        </a>
                        <div class="dropdown-menu pb-0">
                            <a class="dropdown-item" href="/Profile">
                                <i class="bx bx-user mr-50"></i>مشاهده پروفایل</a>
                            <div class="dropdown-divider mb-0"></div>
                            <a class="dropdown-item" href="/logout"><i
                                        class="bx bx-power-off mr-50"></i> خروج</a>
                            <input type="hidden" value="{APP_URL}" id="APP_URL">
                            <input type="hidden"
                                   value="{((isset($smarty.session.userInfo['internalNumber'])) ? $smarty.session.userInfo['internalNumber'] : '')}"
                                   id="localTelephoneUser">
                            <input type="hidden"
                                   value="{((isset($smarty.session.permission)) ? $smarty.session.permission : '')}"
                                   id="roleTitleUserLogin">
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<input type="hidden" id="userLogInId" value="{((isset($smarty.session.userId)) ? $smarty.session.userId : '')}">


