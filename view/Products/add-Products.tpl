{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>

                        </div>
                    </div>
                </div>
            </div>
            <form id="mainForm" enctype="multipart/form-data" method="post" action="/Products/add">
                {$csrf->csrfTokenInput()}
                <div class="card shadow mt-1">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 mt-1">
                                <label for="parent_id">محصول پایه</label>
                                <select class="form-control select2" name="parent_id" id="parent_id" required>
                                    <option value="" selected>محصول پایه</option>
                                    {foreach $parentProducts as $parentProduct}
                                        <option value="{$parentProduct->id}"
                                                data-unit-label="{$parentProduct->measurementUnit->label}">{$parentProduct->serial_number}
                                            - {$parentProduct->label}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-3 mt-1" id="parent_unit_ratio_element" style="display: none">
                                <label for="parent_unit_ratio">نرخ تبدیل</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" name="parent_unit_ratio"
                                           id="parent_unit_ratio">
                                    <div class="input-group-append">
                                        <span class="input-group-text" id="parent_unit_ratio_label">-</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="label">عنوان</label>
                                <input class="form-control" type="text" name="label" id="label" required>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="serial_number">کد محصول</label>
                                <input class="form-control" type="text" name="serial_number" id="serial_number"
                                       required>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="group_id">گروه محصول</label>
                                <select class="form-control select2" name="group_id" id="group_id" REQUIRED>
                                    <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
                                    {foreach $productGroups as $productGroup}
                                        <option value="{$productGroup->id}">{$productGroup->label}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="brand_id">برند</label>
                                <select class="form-control select2" name="brand_id" id="brand_id" required>
                                    <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
                                    {foreach $brands as $brand}
                                        <option value="{$brand->id}">{$brand->label}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="quality_level_id">سطح کیفی</label>
                                <select class="form-control select2" name="quality_level_id" id="quality_level_id"
                                        required>
                                    <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
                                    {foreach $productQualities as $productQualitiy}
                                        <option value="{$productQualitiy->id}">{$productQualitiy->label}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="grade_id">گرید</label>
                                <select class="form-control select2" name="grade_id" id="grade_id" required>
                                    <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
                                    {foreach $productGrades as $productGrade}
                                        <option value="{$productGrade->id}">{$productGrade->label}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="measurement_unit_id">واحد</label>
                                <select class="form-control select2" name="measurement_unit_id"
                                        id="measurement_unit_id" required>
                                    <option disabled selected>لطفا یک مورد را انتخاب کنید</option>
                                    {foreach $measurement_unit as $unit}
                                        <option value="{$unit->id}">{$unit->label}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3 mt-1">
                                <label for="cost_price">بهای تمام شده</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" name="cost_price" id="cost_price" required>
                                    <div class="input-group-append">
                                        <span class="input-group-text">ریال</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="sale_price">قیمت فروش</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" name="sale_price" id="sale_price" required>
                                    <div class="input-group-append">
                                        <span class="input-group-text">ریال</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mt-1">
                                <label for="customer_price">قیمت مصرف کننده</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" name="customer_price" id="customer_price"
                                           required>
                                    <div class="input-group-append">
                                        <span class="input-group-text">ریال</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mt-1">
                                <label for="description">توضیحات</label>
                                <textarea class="form-control" name="description" id="description" rows="8"
                                          style="resize: none"></textarea>
                            </div>
                            <div class="col-md-6 mt-1">
                                <label for="complete_description">توضیحات تکمیلی</label>
                                <textarea class="form-control" name="complete_description" id="complete_description"
                                          rows="8" style="resize: none"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mt-1">
                    <div class="card-body">
                        <label class="form-label">گالری تصاویر محصول</label>

                        <input
                                type="file"
                                hidden="hidden"
                                id="imageInput"
                                name="images[]"
                                class="form-control mb-3"
                                accept="image/*"
                                multiple
                        >

                        <section id="imageGallery" class="splide">
                            <div class="splide__track">
                                <ul class="splide__list"></ul>
                            </div>
                        </section>

                        <div class="d-flex justify-content-end align-items-center gap-2 mt-2">
                            <button type="button" id="addImageButton" class="btn btn-sm btn-secondary">افزودن عکس <i
                                        class="bx bx-plus"></i></button>
                            <button type="button" id="removeCurrentImage" class="btn btn-danger btn-sm mx-1">
                                حذف عکس انتخاب‌شده
                            </button>

                            <button type="submit" class="btn btn-primary btn-sm">
                                ثبت {$singleName}
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
{include 'sections/footer.tpl'}