{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>
                    {$buttonHelper->refreshAndBackBtn()}
                </div>
                <div class="card-body">
                    <form action="/users/add" method="post" enctype="multipart/form-data">
                        {$csrf->csrfTokenInput()}

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body">
                                            <!-- Nav tabs -->
                                            <ul class="nav nav-tabs nav-fill" id="myTab" role="tablist">
                                                <li class="nav-item current">
                                                    <a class="nav-link active" id="home-tab-fill" data-toggle="tab"
                                                       href="#home-fill" role="tab" aria-controls="home-fill"
                                                       aria-selected="true">
                                                        اطلاعات پایه
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="contact-tab-fill" data-toggle="tab"
                                                       href="#contact-fill" role="tab" aria-controls="contact-fill"
                                                       aria-selected="false">
                                                        اطلاعات تماس
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="profile-tab-fill" data-toggle="tab"
                                                       href="#profile-fill" role="tab" aria-controls="profile-fill"
                                                       aria-selected="false">
                                                        اطلاعات افراد تحت تکفل
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="messages-tab-fill" data-toggle="tab"
                                                       href="#messages-fill" role="tab" aria-controls="messages-fill"
                                                       aria-selected="false">
                                                        اطلاعات حساب بانکی
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="settings-tab-fill" data-toggle="tab"
                                                       href="#settings-fill" role="tab" aria-controls="settings-fill"
                                                       aria-selected="false">
                                                        اطلاعات حساب کاربری
                                                    </a>
                                                </li>
                                            </ul>

                                            <!-- Tab panes -->
                                            <div class="tab-content pt-1">
                                                <div class="tab-pane active" id="home-fill" role="tabpanel"
                                                     aria-labelledby="home-tab-fill">
                                                    <div class="divider">
                                                        <div class="divider-text">اطلاعات هویتی</div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 text-center border-1 personal_img">
                                                            <img src="/Storage/DefaultImages/gifCamera.png"
                                                                 class="img-fluid border mt-1"
                                                                 id="avatarImage"
                                                                 name="avatarImage"
                                                                 alt="">

                                                            <div class="my-2">
                                                                <a class="btn btn-primary btn-sm w-100 text-white changeAvatar">
                                                                    افزودن تصویر پرسنلی
                                                                </a>
                                                            </div>

                                                            <input type="file" hidden name="avatar" id="avatarInput">
                                                        </div>
                                                        <div class="col-md-9">
                                                            <div class="row">
                                                                <div class="col-md-3">
                                                                    <label for="userIdentify_is_iranian">ملیت</label>
                                                                    <select class="form-control select2"
                                                                            name="userIdentify[is_iranian]"
                                                                            id="userIdentify_is_iranian" required>
                                                                        <option selected disabled>لطفا یک مورد را انتخاب
                                                                            کنید
                                                                        </option>
                                                                        <option value="1">ایرانی</option>
                                                                        <option value="0">خارجی</option>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label for="userData_gender">جنسیت</label>
                                                                    <select class="form-control select2"
                                                                            name="userData[gender]" id="userData_gender"
                                                                            required>
                                                                        <option selected disabled>لطفا یک مورد را انتخاب
                                                                            کنید
                                                                        </option>
                                                                        <option value="Mr">آقا</option>
                                                                        <option value="Mrs">خانم</option>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label for="userData_first_name">نام</label>
                                                                    <input class="form-control" type="text"
                                                                           name="userData[first_name]"
                                                                           id="userData_first_name" required>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label for="userData_last_name">نام خانوادگی</label>
                                                                    <input class="form-control" type="text"
                                                                           name="userData[last_name]"
                                                                           id="userData_last_name" required>
                                                                </div>

                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_national_id">کد ملی</label>
                                                                    <input class="form-control" type="text"
                                                                           name="userIdentify[national_id]"
                                                                           id="userIdentify_national_id" required>
                                                                </div>

                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_issuing_place_id">محل
                                                                        صدور</label>
                                                                    <select class="form-control"
                                                                            name="userIdentify[issuing_place_id]"
                                                                            id="userIdentify_issuing_place_id" disabled
                                                                            required>
                                                                        <option selected disabled>لطفا یک مورد را انتخاب
                                                                            کنید
                                                                        </option>

                                                                    </select>
                                                                </div>

                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_passport_number">شماره
                                                                        شناسنامه</label>
                                                                    <input class="form-control" type="text"
                                                                           name="userIdentify[passport_number]"
                                                                           id="userIdentify_passport_number" required>
                                                                </div>

                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_father_name">نام
                                                                        پدر</label>
                                                                    <input class="form-control" type="text"
                                                                           name="userIdentify[father_name]"
                                                                           id="userIdentify_father_name" required>
                                                                </div>

                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_birth_date">تاریخ
                                                                        تولد</label>
                                                                    <input class="form-control" type="text"
                                                                           name="userIdentify[birth_date]"
                                                                           id="userIdentify_birth_date" readonly
                                                                           required>
                                                                </div>

                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_birth_place">محل
                                                                        تولد</label>
                                                                    <input class="form-control" type="text"
                                                                           name="userIdentify[birth_place]"
                                                                           id="userIdentify_birth_place" required>
                                                                </div>

                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_military_status_type_id">وضعیت
                                                                        نظام وظیفه</label>
                                                                    <select class="form-control select2"
                                                                            name="userIdentify[military_status_type_id]"
                                                                            id="userIdentify_military_status_type_id"
                                                                            required>
                                                                        <option selected disabled>لطفا یک مورد را انتخاب
                                                                            کنید
                                                                        </option>
                                                                        {foreach $maritalStatusTypes as $maritalStatusType}
                                                                            <option value="{$maritalStatusType->id}">{$maritalStatusType->title}</option>
                                                                        {/foreach}

                                                                    </select>
                                                                </div>
                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_blood_type_id">گروه
                                                                        خونی</label>
                                                                    <select class="form-control select2"
                                                                            name="userIdentify[blood_type_id]"
                                                                            id="userIdentify_blood_type_id"
                                                                            required>
                                                                        <option selected disabled>لطفا یک مورد را انتخاب
                                                                            کنید
                                                                        </option>
                                                                        {foreach $bloodTypes as $bloodType}
                                                                            <option value="{$bloodType->id}">{$bloodType->title}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-3 mt-1">
                                                                    <label for="userIdentify_marital_status_type_id">وضعیت
                                                                        تاهل</label>
                                                                    <select class="form-control select2"
                                                                            name="userIdentify[marital_status_type_id]"
                                                                            id="userIdentify_marital_status_type_id"
                                                                            required>
                                                                        <option selected disabled>لطفا یک مورد را انتخاب
                                                                            کنید
                                                                        </option>
                                                                        {foreach $maritalStatusTypes as $maritalStatusType}
                                                                            <option value="{$maritalStatusType->id}">{$maritalStatusType->title}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane" id="contact-fill" role="tabpanel"
                                                     aria-labelledby="contact-tab-fill">
                                                    <div class="divider">
                                                        <div class="divider-text">راه های ارتباطی</div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="table-responsive">
                                                                <table class="table table-hover table-striped text-center">
                                                                    <thead class="thead-dark">
                                                                    <tr>
                                                                        <th class="border">#</th>
                                                                        <th class="border">نوع</th>
                                                                        <th class="border">مقدار</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    {foreach $userContactTypes as $userContactType}
                                                                        <tr>
                                                                            <td class="border">{counter}</td>
                                                                            <td class="border">{$userContactType->title}</td>
                                                                            <td class="border">
                                                                                <input class="form-control userContactTypeValue" type="text"
                                                                                       required
                                                                                       name="userContacts[{$userContactType->id}]"
                                                                                       id="userContacts_{$userContactType->id}"
                                                                                       data-validation-pattern='{$userContactType->validation_pattern}'
                                                                                >
                                                                            </td>
                                                                        </tr>
                                                                    {/foreach}
                                                                    </tbody>
                                                                    <tfoot>
                                                                    <tr>
                                                                        <td class="border" colspan="3">
                                                                            <button type="button"
                                                                                    class="btn btn-sm p-0">
                                                                                افزودن ردیف جدید<i
                                                                                        class="bx bx-down-arrow"></i>
                                                                            </button>
                                                                        </td>
                                                                    </tr>
                                                                    </tfoot>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="divider">
                                                        <div class="divider-text">محل سکونت</div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="table-responsive">
                                                                <table class="table table-striped table-hover text-center"
                                                                       id="addressTable">
                                                                    <thead class="thead-dark">
                                                                    <tr>
                                                                        <th class="border">#</th>
                                                                        <th class="border">آدرس</th>
                                                                        <th class="border">عملیات</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>

                                                                    </tbody>
                                                                    <tfoot>
                                                                    <tr>
                                                                        <td class="border" colspan="4">
                                                                            <button type="button"
                                                                                    class="btn btn-sm p-0"
                                                                                    id="newAddressBtn">
                                                                                افزودن ردیف جدید<i
                                                                                        class="bx bx-down-arrow"></i>
                                                                            </button>
                                                                        </td>
                                                                    </tr>
                                                                    </tfoot>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="tab-pane" id="profile-fill" role="tabpanel"
                                                     aria-labelledby="profile-tab-fill">
                                                    <p>
                                                        لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با
                                                        استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله
                                                        در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد
                                                        نیاز و کاربردهای متنوع
                                                    </p>
                                                </div>
                                                <div class="tab-pane" id="messages-fill" role="tabpanel"
                                                     aria-labelledby="messages-tab-fill">
                                                    <p>
                                                        لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با
                                                        استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه
                                                    </p>
                                                </div>
                                                <div class="tab-pane" id="settings-fill" role="tabpanel"
                                                     aria-labelledby="settings-tab-fill">
                                                    <p>
                                                        لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با
                                                        استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله
                                                        در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد
                                                        نیاز و کاربردهای متنوع
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {*                    <div class="row">*}
                        {*                        <!-- Profile -->*}


                        {*                        <!-- Form -->*}
                        {*                        <div class="col-md-9">*}
                        {*                            <div class="row">*}

                        {*                                <div class="col-md-3 mt-2">*}
                        {*                                    <label>شماره موبایل</label>*}
                        {*                                    <input class="form-control" id="user_mobile" name="user_mobile" required>*}
                        {*                                </div>*}

                        {*                                <div class="col-md-3 mt-2">*}
                        {*                                    <label>ایمیل</label>*}
                        {*                                    <input class="form-control" dir="ltr" id="user_email" name="user_email" type="email"*}
                        {*                                           required>*}
                        {*                                </div>*}

                        {*                                <div class="col-md-3 mt-2">*}
                        {*                                    <label>نام کاربری</label>*}
                        {*                                    <input class="form-control" id="user_name" name="user_name" required>*}
                        {*                                </div>*}

                        {*                                <div class="col-md-3 mt-2">*}
                        {*                                    <label>رمزعبور</label>*}
                        {*                                    <input type="password" class="form-control" id="user_password" name="user_password"*}
                        {*                                           required>*}
                        {*                                </div>*}

                        {*                                <div class="col-md-3 mt-2">*}
                        {*                                    <label>دسترسی</label>*}
                        {*                                    <select class="form-control select2" id="permission_id" name="permission_id"*}
                        {*                                            required>*}
                        {*                                        <option selected disabled>یک مورد را انتخاب کنید</option>*}
                        {*                                        {foreach $userRole as $item}*}
                        {*                                            <option value="{$item->id}">{$item->per_name}</option>*}
                        {*                                        {/foreach}*}
                        {*                                    </select>*}
                        {*                                </div>*}

                        {*                                <div class="col-md-12 mt-4">*}
                        {*                                    <button class="btn btn-primary float-right">*}
                        {*                                        ثبت*}
                        {*                                    </button>*}
                        {*                                </div>*}

                        {*                            </div>*}
                        {*                        </div>*}
                        {*                    </div>*}
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
{include 'sections/footer.tpl'}
