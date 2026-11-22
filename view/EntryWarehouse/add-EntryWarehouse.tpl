{include "sections/header.tpl"}
{include "sections/top-bar.tpl"}
{include "sections/side-menu.tpl"}
<div class="app-content content">
    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title" style="float: right">افزودن {$singleName} جدید</h4>
                             {$buttonHelper->refreshAndBackBtn()}
                        </div>
                        <div class="card-content">
                            <div id="DirectEntryWarehouse">
                                <div class="card-body">
                                    <form method="post" enctype="multipart/form-data" action="/EntryWarehouse/add">
                                        {$csrf->csrfTokenInput()}

                                        <div class="row mt-1">
                                            <div class="col-md-3">
                                                <label for="title">عنوان</label>
                                                <input type="text" class="form-control" name="title" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label for="warehouse_id">انتخاب انبار</label>
                                                <select class="form-control select2" name="warehouse_id"
                                                        id="warehouse_id">
                                                    <option selected disabled>لطفا یک مورد را انتخاب کنید</option>
                                                    {foreach $warehouseData as $warehouseDatum}
                                                        <option value="{$warehouseDatum['id']}"
                                                                data-selected-brand-ids='{$warehouseDatum['warehouse_brand_ids']}'>{$warehouseDatum['ware_house_name']}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label for="">تاریخ ثبت</label>
                                                <input class="form-control" type="text" name="" id="" disabled
                                                       value="{jdate("Y/m/d")}">
                                            </div>
                                            <div class="col-md-3">
                                                <label for="">تاریخ ورود</label>
                                                <input class="form-control" type="text" name="entryDateTime"
                                                       id="entryDateTime"
                                                       value="{jdate("Y/m/d")}">
                                            </div>
                                        </div>
                                        <div class="col-md-12 mt-1">
                                            <textarea class="form-control" id="wareHousePartDescription"
                                                      name="wareHousePartDescription" style="resize: none"></textarea>
                                        </div>
                                        <div class="divider">
                                            <div class="divider-text">اطلاعات محصولات</div>
                                        </div>
                                        <div class="row mt-1">
                                            <div class="col-md-12">
                                                <div class="table-responsive">
                                                    <table class="table table-hover table-striped" id="mainTable">
                                                        <thead class="thead-dark">
                                                        <tr class="text-center">
                                                            <th class="border">#</th>
                                                            <th class="border">محصول</th>
                                                            <th class="border">مقدار</th>
                                                            <th class="border">واحد</th>
                                                            <th class="border">عملیات</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                        <tfoot>
                                                        <tr>
                                                            <td colspan="5" class="border text-center">
                                                                <button type="button" class="btn p-0 m-0"
                                                                        style="font-size: 0.75rem" id="newRowButton">
                                                                    افزودن ردیف جدید<i class="bx bx-down-arrow"
                                                                                       style="vertical-align: middle"></i>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="divider">
                                            <div class="divider-text">اطلاعات ماشین</div>
                                        </div>

                                        <div class="card mb-2">
                                            <div class="card-header d-flex justify-content-between align-items-center">
                                                <button type="button" class="btn btn-sm btn-outline-primary addPlateBtn"
                                                        id="driverLicence">
                                                    <i class="bx bx-plus"></i>
                                                    افزودن پلاک
                                                </button>
                                            </div>

                                            <div class="card-body">
                                                <div class="exitData-plates-list">
                                                    <div class="border rounded p-3 mb-3 exitData-plate-row">


                                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                                            <strong>
                                                                <i class="bx bx-car"></i>
                                                                پلاک خودرو
                                                            </strong>


                                                        </div>
                                                        <div class="mt-3">
                                                            <label>نوع خودرو</label>
                                                            <input type="text"
                                                                   name="driver_plaques[0][car_type]"
                                                                   class="form-control text-center"
                                                                   placeholder="مثلاً کامیون، سواری، وانت"
                                                                   autocomplete="off">
                                                        </div>
                                                        <div class="iran-input-plate mt-2 col-md-8 " dir="ltr">

                                                            <div class="plate-country">
                                                                <div class="iran-flag"></div>
                                                                <strong>I.R.</strong>
                                                                <strong>IRAN</strong>
                                                            </div>

                                                            <div class="plate-input-numbers">

                                                                <input type="text"
                                                                       name="driver_plaques[0][first]"
                                                                       maxlength="2"
                                                                       inputmode="numeric"
                                                                       class="plate-input plate-digits"
                                                                       placeholder="۰۰"
                                                                       autocomplete="off">

                                                                <input type="text"
                                                                       name="driver_plaques[0][two]"
                                                                       maxlength="1"
                                                                       class="plate-input plate-letter"
                                                                       placeholder="و"
                                                                       autocomplete="off">

                                                                <input type="text"
                                                                       name="driver_plaques[0][three]"
                                                                       maxlength="3"
                                                                       inputmode="numeric"
                                                                       class="plate-input plate-digits"
                                                                       placeholder="۰۰۰"
                                                                       autocomplete="off">

                                                            </div>

                                                            <div class="plate-iran-code">
                                                                <span>ایران</span>

                                                                <input type="text"
                                                                       name="driver_plaques[0][four]"
                                                                       maxlength="2"
                                                                       inputmode="numeric"
                                                                       class="plate-input plate-code-input"
                                                                       placeholder="۰۰"
                                                                       autocomplete="off">
                                                            </div>

                                                        </div>



                                                    </div>
                                                </div>

                                                <div class="alert alert-secondary text-center mb-0 exitData-plates-empty">
                                                    <i class="bx bx-info-circle"></i>
                                                    هنوز پلاکی اضافه نشده است.
                                                </div>
                                            </div>
                                        </div>

                                        <div class="divider">
                                            <div class="divider-text">مستندات</div>
                                        </div>

                                        <div class="card mb-2">
                                            <div class="card-header d-flex justify-content-between align-items-center">
                                                <button type="button" class="btn btn-sm btn-outline-primary addFileBtn">
                                                    <i class="bx bx-plus"></i>
                                                    افزودن فایل
                                                </button>
                                            </div>

                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover mb-0 exitData-files-table">
                                                        <thead class="thead-dark">
                                                        <tr class="text-center">
                                                            <th class="border">نام فایل <span class="text-danger">*</span></th>
                                                            <th class="border">توضیحات</th>
                                                            <th class="border">فایل <span class="text-danger">*</span></th>
                                                            <th class="border">عملیات</th>
                                                        </tr>
                                                        </thead>

                                                        <tbody class="exitData-files-body">
                                                        <tr class="exitData-files-empty">
                                                            <td colspan="4" class="text-center text-muted py-4">
                                                                <i class="bx bx-file"></i>
                                                                <div>هنوز فایلی اضافه نشده است.</div>
                                                                <small>
                                                                    برای اضافه کردن فایل روی «افزودن فایل» کلیک کنید.
                                                                </small>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12 d-flex flex-sm-row flex-column justify-content-end mt-1">
                                            <button type="submit"
                                                    class="btn btn-sm btn-primary glow mb-1 mb-sm-0 mr-0 mr-sm-1">
                                                ثبت
                                                اطلاعات
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{include "sections/footer.tpl"}
