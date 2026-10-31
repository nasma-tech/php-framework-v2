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
                            <form action="/roles/edit/{$getData->id}" method="post">
                                {$csrf->csrfTokenInput()}

                                <div class="row">
                                    <div class="col-md-4 mb-2">
                                        <div class="form-group">
                                            <div class="controls">
                                                <label for="title">نام مجوز</label>
                                                <input type="text" name="title" id="title" value="{$getData->title}"
                                                       class="form-control" autofocus placeholder="نام مجوز" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <div class="form-group">
                                            <label for="status">وضعیت</label>
                                            <select class="form-control select2" name="status" id="status" required>
                                                <option value="1" {(($getData->per_status == "1")?'selected':'')}>
                                                    فعال
                                                </option>
                                                <option value="0" {(($getData->per_status == "0")?'selected':'')}>
                                                    غیرفعال
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="table-responsive tableFixHead">
                                            <table class="table text-center">
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
                                                {$data = json_decode($getData->access_json,true)}
                                                {foreach $menuList::query()->where('menu_parent','=',0)->get() as $item}
                                                    <tr class="bg-danger text-white">
                                                        <td colspan="6"
                                                            class="text-center font-size-2">{$item->menu_persian_name}</td>
                                                    </tr>
                                                    {foreach $menuList::query()->where('menu_parent','=',$item->id)->get() as $row}
                                                        <tr>
                                                            <td>{$row->menu_persian_name}</td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           value="{(isset($data[$row->id]['menu']))?1:0}"
                                                                           name="parentMenu[{$row->id}][menu]"
                                                                           id="menu_{$counter}" {(isset($data[$row->id]['menu']))?'checked':''}>
                                                                    <label for="menu_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           value="{(isset($data[$row->id]['create']))?1:0}"
                                                                           name="parentMenu[{$row->id}][create]"
                                                                           id="create_{$counter}" {(isset($data[$row->id]['create']))?'checked':''}>
                                                                    <label for="create_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           name="parentMenu[{$row->id}][edit]"
                                                                           value="{(isset($data[$row->id]['edit']))?1:0}"
                                                                           id="edit_{$counter}" {(isset($data[$row->id]['edit']))?'checked':''}>
                                                                    <label for="edit_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           name="parentMenu[{$row->id}][view]"
                                                                           value="{(isset($data[$row->id]['view']))?1:0}"
                                                                           id="view_{$counter}" {(isset($data[$row->id]['view']))?'checked':''}>
                                                                    <label for="view_{$counter}"></label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="checkbox checkbox-primary checkbox-glow">
                                                                    <input type="checkbox"
                                                                           name="parentMenu[{$row->id}][delete]"
                                                                           value="{(isset($data[$row->id]['delete']))?1:0}"
                                                                           id="delete_{$counter}" {(isset($data[$row->id]['delete']))?'checked':''}>
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
                                </div>
                                <div class="col-md-12 mt-2">
                                    <button type="submit" class="btn btn-success glow float-right">
                                        ویرایش {$singleName}</button>
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