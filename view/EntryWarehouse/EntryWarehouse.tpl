{include "sections/header.tpl"}
{include "sections/top-bar.tpl"}
{include "sections/side-menu.tpl"}
<div class="app-content content">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">لیست {$pluralName}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndAddButton($singleName)}
                            {$csrf->csrfTokenInput()}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <table class="table table-hover table-striped text-center responsive" id="mainTable"
                                   style="background-color: #fff;border-radius: 5px;">
                                <thead class="thead-dark">
                                <tr class="text-center">
                                    <th>موضوع</th>
                                    <th>انبار</th>
                                    <th>تاریخ ورود</th>
                                    <th>توضیحات</th>
                                    <th>پلاک</th>
                                    <th>مسندات</th>
                                    <th>کاربر</th>
                                    <th>عملیات</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $getData as $data}
                                    <tr>
                                        <td class="border">{$data->title}</td>
                                        <td class="border">{$data->warehouseData->ware_house_name}</td>
                                        <td class="border">{date("Y/m/d",strtotime($data['entry_datetime']))}</td>
                                        <td class="border">
                                            <button type="button" class="btn btn-sm btn-primary description"
                                                    data-text='{$data["description"]}'><i class="bx bx-note"></i>
                                            </button>
                                        </td>
                                        <td class="border">
                                            <button type="button" class="btn btn-sm btn-warning plates"
                                                    data-text='{$data["driver_plaques"]}'><i class="bx bx-car"></i>
                                            </button>
                                        </td>
                                        <td class="border">
                                            <button type="button" class="btn btn-sm btn-warning file"
                                                    data-id="{$data['id']}"
                                                    data-text='{$data["documents"]}'><i class="bx bx-file"></i>
                                            </button>
                                        </td>
                                        <td class="border">{$data->userData->full_name}</td>
                                        </td>
                                        <td class="border">
                                            <a class="btn btn-sm btn-primary"
                                               href="/EntryWarehouse/viewIndex/{$data['id']}"><i
                                                        class="bx bx-show"></i></a>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    .iran-plate-swal {
        width: 850px !important;
        max-width: 95% !important;
        border-radius: 20px !important;
        padding: 30px !important;
        font-family: inherit;
    }

    .iran-plate-swal .swal2-title {
        font-size: 22px;
        color: #172554;
        margin-bottom: 35px;
    }

    .iran-plate-container {
        width: 100%;
    }

    .iran-plate {
        width: 100%;
        height: 155px;
        display: flex;
        align-items: stretch;
        background: #fff;
        border: 5px solid #222;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0, 0, 0, .2);
        box-sizing: border-box;
    }

    .plate-country {
        width: 105px;
        min-width: 105px;
        background: #0755bd;
        color: white;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 5px;
        border-right: 2px solid #222;
        font-family: Arial, sans-serif;
        font-size: 17px;
    }

    .iran-flag {
        width: 65px;
        height: 40px;
        border-radius: 3px;
        background: linear-gradient(
                to bottom,
                #239f40 0%,
                #239f40 33.33%,
                white 33.33%,
                white 66.66%,
                #da0000 66.66%,
                #da0000 100%
        );
        margin-bottom: 5px;
    }

    .plate-numbers {
        flex: 1;
        min-width: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        direction: ltr;
        background: #fff;
        padding: 0 10px;
    }

    .plate-section {
        flex: 1;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: Arial, sans-serif;
        font-size: 48px;
        font-weight: 800;
        color: #111;
        white-space: nowrap;
    }

    .plate-letter {
        flex: 0.8;
        font-family: inherit;
        border-left: 1px solid #bbb;
        border-right: 1px solid #bbb;
    }

    .plate-code {
        width: 100px;
        min-width: 100px;
        border-left: 2px solid #aaa;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 3px;
        color: #111;
    }

    .plate-code strong {
        font-family: Arial, sans-serif;
        font-size: 35px;
    }

    .plate-code span {
        font-size: 19px;
        font-weight: bold;
    }

    .iran-emblem {
        font-size: 25px;
        line-height: 1;
    }

    .plate-details {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
        gap: 10px;
        background: #f1f5ff;
        padding: 20px 10px;
        border-radius: 15px;
        margin-top: 25px;
    }

    .plate-detail {
        flex: 1;
        min-width: 75px;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 10px;
        border-left: 1px solid #d5dced;
    }

    .plate-detail:last-child {
        border-left: none;
    }

    .plate-detail span {
        font-size: 13px;
        color: #64748b;
    }

    .plate-detail strong {
        font-size: 19px;
        color: #172554;
    }

    .iran-plate-confirm {
        background: #155eef !important;
        color: #fff !important;
        border: none !important;
        border-radius: 10px !important;
        padding: 13px 50px !important;
        font-size: 16px !important;
        font-weight: bold !important;
        cursor: pointer;
        margin-top: 15px !important;
    }

    @media (max-width: 550px) {
        .iran-plate-swal {
            padding: 15px !important;
        }

        .iran-plate {
            height: 105px;
            border-width: 3px;
        }

        .plate-country {
            width: 60px;
            min-width: 60px;
            font-size: 11px;
        }

        .iran-flag {
            width: 38px;
            height: 24px;
        }

        .plate-code {
            width: 58px;
            min-width: 58px;
        }

        .plate-code strong {
            font-size: 23px;
        }

        .plate-code span {
            font-size: 13px;
        }

        .iran-emblem {
            font-size: 17px;
        }

        .plate-section {
            font-size: 25px;
        }

        .plate-numbers {
            padding: 0 3px;
        }

        .plate-details {
            gap: 15px 5px;
        }

        .plate-detail {
            min-width: 65px;
        }
    }
</style>
{include "sections/footer.tpl"}