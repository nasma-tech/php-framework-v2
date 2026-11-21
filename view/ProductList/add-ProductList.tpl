{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>

                    </div>
                </div>
            </div>
        </div>
        <form id="mainForm" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-8">
                    <div class="tab-content" style="background-color: #f2f4f459 !important;">
                        <div class="card shadow" style="margin-top: 3px">
                            <div class="card-content">
                                <div class="card-body">
                                    <div class="divider divider-left">
                                        <div class="divider-text">مشخصات محصول</div>
                                    </div>
                                    <div class="row" style="direction: rtl;">
                                        <div class="col-md-8">
                                            <div class="mt-2 row">
                                                <div class="col-md-6">
                                                    <label for="brand_id">برند</label>
                                                    <select class="form-control select2" name="brand_id" id="brand_id" required>
                                                        <option value="" selected disabled>
                                                            انتخاب برند
                                                        </option>

                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="title">عنوان</label>
                                                    <input class="form-control" id="title" name="title" required autocomplete="off" readonly>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <label for="description">توضیحات</label>
                                                <textarea class="form-control" id="description" name="description" required style="height:485px;resize:none"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="mt-2">
                                                <label for="group_id">گروه محصول</label>
                                                <select class="form-control select2" name="group_id" id="group_id" required>

                                                </select>
                                            </div>
                                            <div class="mt-3">
                                                <label for="category_id">دسته بندی</label>
                                                <select class="form-control select2" name="category_id" id="category_id" required>

                                                </select>
                                            </div>
                                            <div class="mt-3">
                                                <label for="grade_id">گرید</label>
                                                <select class="form-control select2" name="grade_id" id="grade_id" required>

                                                </select>
                                            </div>
                                            <div class="mt-3">
                                                <label for="quality_id">سطح کیفی</label>
                                                <select class="form-control select2" name="quality_id" id="quality_id" required>

                                                </select>
                                            </div>
                                            <div class="mt-3">
                                                <div class="row">
                                                    <div class="col-12" id="unitSelectWrapper">
                                                        <label for="unit_id">واحد فروش</label>
                                                        <select class="form-control select2" name="unit_id" id="unit_id" required>

                                                        </select>
                                                    </div>
                                                    <div class="col-12" id="unitAmountWrapper" style="display: none;">
                                                        <label for="unit_amount">
                                                            تعداد در هر
                                                            <span id="sub_unit_name"></span>
                                                        </label>
                                                        <input type="number" class="form-control text-center" id="unit_amount" name="unit_amount" min="1" step="1">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <div class="d-flex justify-content-between align-items-center mb-1">
                                                    <label for="product_id" class="mb-0">کد محصول</label>
                                                    <div class="form-check form-switch mb-0">
                                                        <input class="form-check-input" type="checkbox" id="manual_product_id" name="manual_product_id" value="1">
                                                        <label class="form-check-label" for="manual_product_id">کد محصول دلخواه</label>
                                                    </div>
                                                </div>
                                                <input type="text" class="form-control text-center" id="product_id" name="product_id"
                                                       required readonly style="font-family:monospace;letter-spacing:2px">
                                                <small id="product_id_help" class="text-muted">
                                                    کد محصول به صورت خودکار ایجاد میشود.
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 pl-md-0 pl-lg-0">
                    <div class="card shadow" style="margin-top:3px;height:742px;overflow-y:auto">
                        <div class="card-content h-100">
                            <div class="card-body d-flex flex-column h-100">
                                <div class="divider divider-left">
                                    <div class="divider-text">تنظیمات</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mt-2">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <label for="is_active" class="mb-0">وضعیت محصول</label>
                                                <div class="form-check form-switch mb-0">
                                                    <input class="form-check-input" type="checkbox" id="is_active" name="is_active" value="1" checked>
                                                    <label class="form-check-label" for="is_active">فعال</label>
                                                </div>
                                            </div>
                                            <small class="text-muted">
                                                محصولات غیرفعال در فروش قابل انتخاب نیستند.
                                            </small>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-auto pt-3">
                                    <button type="button" class="btn btn-primary glow w-100 addFormAjax">ثبت {$singleName}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>
</div>
{include 'sections/footer.tpl'}