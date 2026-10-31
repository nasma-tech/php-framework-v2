{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <form action="/users/edit/{$getData->id}" method="post" enctype="multipart/form-data">

                    <div class="card shadow">
                        <div class="card-header">
                            <h4 class="card-title" style="float: right">ویرایش {$singleName}</h4>
                            {$buttonHelper->refreshAndBackButton()}
                        </div>
                        <div class="card-content">
                            <div class="card-body">
                                {$csrf->csrfTokenInput()}
                                <section id="basic-tabs-components">
                                    <div class="card shadow">
                                        <div class="card-content">
                                            <div class="card-body">
                                                <ul class="nav nav-tabs" role="tablist">
                                                    <li class="nav-item current">
                                                        <a class="nav-link active" id="home-tab" data-toggle="tab"
                                                           href="#home" aria-controls="home" role="tab"
                                                           aria-selected="true">
                                                            <i class="bx bx-user align-middle"></i>
                                                            <span class="align-middle">اطلاعات پایه</span>
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" id="profile-tab" data-toggle="tab"
                                                           href="#profile" aria-controls="profile" role="tab"
                                                           aria-selected="false">
                                                            <i class="bx bxs-factory align-middle"></i>
                                                            <span class="align-middle">اطلاعات سازمانی</span>
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" id="about-tab" data-toggle="tab"
                                                           href="#about" aria-controls="about" role="tab"
                                                           aria-selected="false">
                                                            <i class="bx bx-log-in align-middle"></i>
                                                            <span class="align-middle">اطلاعات حساب کاربری</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                                <div class="tab-content">
                                                    <div class="tab-pane active" id="home" aria-labelledby="home-tab"
                                                         role="tabpanel">
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <div class="row">
                                                                    <div class="col-12 text-center border-1 personal_img p-1">
                                                                        {if !empty($getData->user_image)}
                                                                            <img src="/Storage/Users/{$getData->id}/{$getData->user_image}"
                                                                                 class="img-fluid border"
                                                                                 id="avatarImage"
                                                                                 alt="">
                                                                        {else}
                                                                            <img src="/Storage/DefaultImages/gifCamera.png"
                                                                                 class="img-fluid border"
                                                                                 id="avatarImage"
                                                                                 alt="">
                                                                        {/if}

                                                                        <div class="mt-3">
                                                                            <a class="btn btn-primary btn-sm w-100 text-white changeAvatar">
                                                                                ویرایش تصویر پرسنلی
                                                                            </a>
                                                                        </div>

                                                                        <input type="file" hidden name="user_img"
                                                                               id="avatarInput">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-9">
                                                                <div class="row">
                                                                    <div class="col-md-3 mt-1">
                                                                        <label for="first_name">نام</label>
                                                                        <input class="form-control"
                                                                               value="{$getData->first_name}"
                                                                               id="first_name"
                                                                               name="first_name" required="required">
                                                                    </div>
                                                                    <div class="col-md-3 mt-1">
                                                                        <label for="last_name">نام خانوادگی</label>
                                                                        <input class="form-control"
                                                                               value="{$getData->last_name}"
                                                                               id="last_name"
                                                                               name="last_name" required="required">
                                                                    </div>
                                                                    <div class="col-md-3 mt-1">
                                                                        <label for="national_code">کدملی</label>
                                                                        <input class="form-control"
                                                                               value="{$getData->national_code}"
                                                                               id="national_code" name="national_code"
                                                                               required="required">
                                                                    </div>
                                                                    <div class="col-md-3 mt-1">
                                                                        <label for="mobile">شماره موبایل</label>
                                                                        <input class="form-control"
                                                                               value="{$getData->mobile}"
                                                                               id="mobile"
                                                                               name="mobile" required="required">
                                                                    </div>
                                                                    <div class="col-md-3 mt-1">
                                                                        <label for="email">ایمیل</label>
                                                                        <input class="form-control" dir="ltr"
                                                                               value="{$getData->email}"
                                                                               id="email" name="email"
                                                                               required="required">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="tab-pane" id="profile" aria-labelledby="profile-tab"
                                                         role="tabpanel">

                                                    </div>
                                                    <div class="tab-pane" id="about" aria-labelledby="about-tab"
                                                         role="tabpanel">
                                                        <div class="row">
                                                            <div class="col-md-2 mt-1">
                                                                <label for="permission_id">دسترسی</label>
                                                                <select class="form-control select2" id="permission_id"
                                                                        name="permission_id"
                                                                        required="required">
                                                                    <option selected disabled>یک مورد را انتخاب کنید
                                                                    </option>
                                                                    <option value="0" {(($getData->permission_id == 0)?'selected':'')}>سوپر ادمین</option>
                                                                    {foreach $userRole as $item}
                                                                        <option value="{$item->id}" {(($getData->permission_id == $item->id)?'selected':'')}>{$item->per_name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                            <div class="col-md-2 mt-1">
                                                                <label for="username">نام کاربری</label>
                                                                <input class="form-control"
                                                                       value="{$getData->username}" id="username"
                                                                       name="username" required="required">
                                                            </div>
                                                            <div class="col-md-2 mt-1">
                                                                <label for="password">رمزعبور</label>
                                                                <input class="form-control" id="password"
                                                                       name="password"
                                                                       required="required"
                                                                >
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                    <div class="mt-1 card shadow">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <button class="btn btn-sm btn-success float-right"
                                            type="submit">ویرایش
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
{include 'sections/footer.tpl'}

