<style>

    /* =========================================
       Iranian National Car Plate
       Responsive + Editable
    ========================================= */

    .ir-plate-wrapper {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px 10px;
        box-sizing: border-box;
    }

    /* Main Plate */

    .ir-plate {
        width: 100%;
        max-width: 520px;
        aspect-ratio: 4.65 / 1;

        display: grid;
        grid-template-columns: 9% 68% 23%;

        background: #fff;
        border: 3px solid #111;
        border-radius: 4px;
        overflow: hidden;

        box-sizing: border-box;
        direction: ltr;

        box-shadow: 0 3px 7px rgba(0, 0, 0, .15),
        inset 0 0 3px rgba(0, 0, 0, .12);

        container-type: inline-size;
    }

    /* =========================================
       Country Section
    ========================================= */

    .ir-plate-country {
        background: #063d9b;

        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;

        padding: 5% 3% 7%;
        box-sizing: border-box;
    }

    .ir-plate-flag {
        width: 100%;
        aspect-ratio: 1.5 / 1;

        display: flex;
        flex-direction: column;
        overflow: hidden;

        border: 1px solid rgba(255, 255, 255, .6);
    }

    .ir-flag-green,
    .ir-flag-white,
    .ir-flag-red {
        flex: 1;
        display: block;
    }

    .ir-flag-green {
        background: #239b56;
    }

    .ir-flag-white {
        background: #fff;

        display: flex;
        justify-content: center;
        align-items: center;
    }

    .ir-flag-white i {
        width: 15%;
        height: 65%;
        background: #da251d;
        border-radius: 2px;
    }

    .ir-flag-red {
        background: #da251d;
    }

    .ir-plate-country-text {
        color: #fff;
        font-family: Arial, sans-serif;

        font-size: 3.2cqw;
        font-weight: 700;
        line-height: 1.05;

        text-align: center;
        white-space: nowrap;
    }

    /* =========================================
       Main Number Section
    ========================================= */

    .ir-plate-main {
        position: relative;

        display: flex;
        align-items: center;
        justify-content: center;

        background: #fff;
        border-right: 2px solid #111;

        overflow: hidden;
    }

    .ir-plate-number {
        width: 100%;
        height: 100%;

        display: grid;
        grid-template-columns: 23% 21% 56%;

        align-items: center;
        justify-items: center;

        direction: ltr;
        padding: 0 2%;
        box-sizing: border-box;
    }

    /* Number Inputs */

    .ir-plate-input,
    .ir-plate-select,
    .ir-plate-city-code {
        width: 100%;
        height: 100%;

        padding: 0;
        margin: 0;

        border: none !important;
        outline: none !important;
        background: transparent !important;

        box-shadow: none !important;

        color: #080808;
        font-family: B-Traffic, Tahoma, sans-serif;

        font-weight: 900;
        text-align: center;

        direction: ltr;
        appearance: none;
        -webkit-appearance: none;

        border-radius: 0 !important;
        box-sizing: border-box;
    }

    /* First Two Digits */

    .ir-plate-first {
        font-size: 12.5cqw !important;
        letter-spacing: -2px;
        line-height: 1;
    }

    /* Middle Letter */

    .ir-plate-select {
        font-size: 12.5cqw !important;
        line-height: 1;
        cursor: pointer;
        text-align: center;
        text-align-last: center;
    }

    /* Last Three Digits */

    .ir-plate-last {
        font-size: 12.5cqw !important;
        letter-spacing: -2px;
        line-height: 1;
    }

    /* Placeholder */

    .ir-plate-input::placeholder,
    .ir-plate-city-code::placeholder {
        color: #080808;
        opacity: .9;
    }

    /* Focus */

    .ir-plate-input:focus,
    .ir-plate-select:focus,
    .ir-plate-city-code:focus {
        background: rgba(0, 80, 180, .035) !important;
    }

    /* Select Options */

    .ir-plate-select option {
        font-family: B-Traffic, Tahoma, sans-serif;
        font-size: 16px;
        font-weight: 600;
        color: #111;
        background: #fff;
    }

    /* =========================================
       City Code Section
    ========================================= */

    .ir-plate-city {
        position: relative;

        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        background: #fff;
        overflow: hidden;

        font-family: B-Traffic, Tahoma, sans-serif;
    }

    .ir-plate-city-title {
        position: absolute;
        top: 3%;
        left: 0;

        width: 100%;

        color: #080808;
        text-align: center;

        font-size: 4.5cqw;
        font-weight: 900;
        line-height: 1.2;
    }

    .ir-plate-city-code {
        width: 100%;
        height: 65%;
        font-size: 9.5cqw !important;
        font-weight: 900;
        line-height: 1;
    }

    /* =========================================
       Screws
    ========================================= */

    .ir-plate-screw {
        position: absolute;

        width: 2.8%;
        aspect-ratio: 1;

        background: radial-gradient(
                circle at 35% 35%,
                #fff 0%,
                #c9c9c9 35%,
                #777 75%,
                #ddd 100%
        );

        border: 1px solid #aaa;
        border-radius: 50%;

        box-shadow: 0 0 2px rgba(0, 0, 0, .3);
        z-index: 2;

        pointer-events: none;
    }

    .ir-screw-main-left {
        left: 2%;
        top: 50%;
        transform: translateY(-50%);
    }

    .ir-screw-main-right {
        right: 2%;
        top: 50%;
        transform: translateY(-50%);
    }

    .ir-screw-city {
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }

    /* =========================================
       Responsive
    ========================================= */

    @media (max-width: 480px) {

        .ir-plate-wrapper {
            padding: 12px 0;
        }

        .ir-plate {
            border-width: 2px;
            border-radius: 6px;
        }

        .ir-plate-first,
        .ir-plate-last,
        .ir-plate-city-code {
            font-size: 10cqw;
        }

        .ir-plate-select {
            font-size: 11cqw;
        }

        .ir-plate-city-title {
            font-size: 4.5cqw !important;
        }

    }

    @media (max-width: 350px) {

        .ir-plate {
            border-width: 1.5px;
            border-radius: 5px;
        }

    }

</style>
{foreach $exitProductData|default:[] as $item}
    {if $item.addressAnnouncement}
        <form action="/CargoExit/add" method="post" enctype="multipart/form-data">
            {$csrf->csrfTokenInput()}
            <input type="hidden" name="address_announcement_id" value="{$item.addressAnnouncement.id}">
            <input type="hidden" name="invoiceCargoExit" value="{$getData.id}">
            <div class="card shadow border">
                <div class="card-content">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="divider divider_center">
                                    <div class="divider-text" style="font-size: 12px"> پارت -
                                        P {$item.productParts.id}</div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped text-center">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th class="border">محصول</th>
                                            <th class="border">مقدار</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $item.productExitPartItems as $product}
                                            <tr>
                                                <td class="border">{$product.productPartItem.invoiceProduct.product.label}
                                                    - {$product.productPartItem.invoiceProduct.product.serial_number}</td>
                                                <td class="border">{$product.exit_amount}</td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="col-md-12 exit_main_info" id="exit_main_info_{$item.id}"></div>
                        </div>
                    </div>
                    {if !$item.addressAnnouncement.cargoExit}
                        <div class="card-footer d-flex justify-content-between border-top">
                            <button class="btn btn-sm btn-light-secondary exitPartInfoAppendButton" type="button"
                                    data-part="{$item.id}">افزودن اطلاعات راننده
                            </button>
                            <button class="btn btn-sm btn-light-primary" type="submit">ثبت خروج</button>
                        </div>
                    {/if}
                </div>
            </div>
        </form>
    {/if}
    {if $item.addressAnnouncement.cargoExit|default:''}
        {foreach $item.addressAnnouncement.cargoExit.cargoExitInfo as $row}
            <div class="exit_main_info">
                <div class="card shadow border" style="margin-top: 3px">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="card-title">اطلاعات راننده</h6>
                        <i class="bx bx-trash text-danger font-medium-3 cursor-pointer removeRowButton" data-cargoexitcarinfo="{$row.id}"></i>
                    </div>
                    <div class="card-content border-top">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3 mt-2">
                                    <label>نام و نام خانوادگی راننده</label>
                                    <input class="form-control" readonly value="{$row.driver_full_name}">
                                </div>
                                <div class="col-md-3 mt-2">
                                    <label>شماره تماس راننده</label>
                                    <input class="form-control" readonly value="{$row.driver_phone}">
                                </div>
                                <div class="col-md-3 mt-2">
                                    <label>کدملی راننده</label>
                                    <input class="form-control" readonly value="{$row.driver_national_id}">
                                </div>
                                <div class="col-md-3 mt-2">
                                    <label>بارنامه</label>
                                    <div class="avatar mr-1 avatar-xl">
                                        <img class="showCargoExitCarInfo" src="/Storage/cargoExit/{$row.cargo_exit_id}/{$row.cargo_file}"  alt="">
                                    </div>
                                </div>
                                <div class="col-md-4 mt-2"></div>
                                <div class="col-md-4 mt-2">
                                    <div class="ir-plate-wrapper">
                                        <div class="ir-plate">
                                            <div class="ir-plate-country">
                                                <div class="ir-plate-flag">
                                                    <span class="ir-flag-green"></span>
                                                    <span class="ir-flag-white">
                                                    <i></i>
                                                </span>
                                                    <span class="ir-flag-red"></span>
                                                </div>
                                                <div class="ir-plate-country-text">
                                                    I.R.<br>
                                                    IRAN
                                                </div>
                                            </div>
                                            <div class="ir-plate-main">
                                                <div class="ir-plate-number">
                                                    <input
                                                            readonly
                                                            type="text"
                                                            class="ir-plate-input ir-plate-first"
                                                            maxlength="2"
                                                            inputmode="numeric"
                                                            placeholder="--"
                                                            autocomplete="off"
                                                            name=""
                                                            aria-label="دو رقم اول پلاک"
                                                            value="{$row.two_left_digit_plate}"
                                                    >

                                                    <!-- حرف پلاک -->
                                                    <input
                                                            readonly
                                                            type="text"
                                                            class="ir-plate-select"
                                                            maxlength="3"
                                                            inputmode="numeric"
                                                            placeholder="-"
                                                            autocomplete="off"
                                                            value="{$row.license_plate_letter}"
                                                    >

                                                    <!-- سه رقم آخر -->
                                                    <input
                                                            readonly
                                                            type="text"
                                                            class="ir-plate-input ir-plate-last"
                                                            maxlength="3"
                                                            inputmode="numeric"
                                                            placeholder="---"
                                                            autocomplete="off"
                                                            value="{$row.three_digit_plate}"
                                                    >

                                                </div>

                                                <span class="ir-plate-screw ir-screw-main-left"></span>
                                                <span class="ir-plate-screw ir-screw-main-right"></span>

                                            </div>

                                            <!-- کد شهر -->
                                            <div class="ir-plate-city">
                                                <div class="ir-plate-city-title">
                                                    ایران
                                                </div>
                                                <input
                                                        readonly
                                                        type="text"
                                                        class="ir-plate-city-code"
                                                        maxlength="2"
                                                        inputmode="numeric"
                                                        placeholder="--"
                                                        autocomplete="off"
                                                        name="plate]"
                                                        aria-label="کد شهر"
                                                        value="{$row.two_right_digit_plate}"
                                                >
                                                <span class="ir-plate-screw ir-screw-city"></span>
                                            </div>
                                        </div>
                                    </div>


                                </div>
                                <div class="col-md-4 mt-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
    {/if}
{/foreach}

