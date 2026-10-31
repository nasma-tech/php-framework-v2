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
                        <h4 class="card-title">افزودن {$singleName} جدید</h4>
                        {$buttonHelper->refreshAndBackButton()}
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <form action="/roles/add" method="post">
                                {$csrf->csrfTokenInput()}
                                <div class="row">
                                    <div class="col-md-4 mb-2">
                                        <div class="form-group">
                                            <div class="controls">
                                                <label for="title">نام مجوز</label>
                                                <input type="text" id="title" name="title" class="form-control"
                                                       autofocus
                                                       placeholder="نام مجوز" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <div class="form-group">
                                            <label for="status">وضعیت</label>
                                            <select class="form-control select2" name="status" id="status" required>
                                                <option value="1">فعال</option>
                                                <option value="0">غیرفعال</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="table-responsive tableFixHead">
                                            <table class="table table-hover table-striped text-center">
                                                <thead class="thead-dark">
                                                <tr>
                                                    <th class="border">آیتم</th>
                                                    <th class="border">نمایش در منو</th>
                                                    <th class="border">ساختن</th>
                                                    <th class="border">ویرایش</th>
                                                    <th class="border">نمایش</th>
                                                    <th class="border">حذف</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                {$counter = 0}
                                                {foreach $menuList::query()->where('menu_parent','=',0)->get() as $item}
                                                    <tr class="bg-secondary text-white">
                                                        <td colspan="6"
                                                            class="text-center font-size-2">{$item->menu_persian_name}</td>
                                                    </tr>
                                                    {foreach $menuList::query()->where('menu_parent','=',$item->id)->get() as $row}
                                                        <tr>
                                                            <td>{$row->menu_persian_name}</td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox" value="0"
                                                                           name="parentMenu[{$row->id}][menu]"
                                                                           id="menu_{$counter}">
                                                                    <label for="menu_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox" value="0"
                                                                           name="parentMenu[{$row->id}][create]"
                                                                           id="create_{$counter}">
                                                                    <label for="create_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           name="parentMenu[{$row->id}][edit]" value="0"
                                                                           id="edit_{$counter}">
                                                                    <label for="edit_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           name="parentMenu[{$row->id}][view]" value="0"
                                                                           id="view_{$counter}">
                                                                    <label for="view_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           name="parentMenu[{$row->id}][delete]"
                                                                           value="0"
                                                                           id="delete_{$counter}">
                                                                    <label for="delete_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <div style="display: none">{$counter++}</div>
                                                    {/foreach}
                                                {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary float-right m-1 ">
                                            ثبت {$singleName}</button>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include 'sections/footer.tpl'}