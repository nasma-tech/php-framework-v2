<div class="card shadow active stepsCard" style="margin-top: 3px" data-step="1" id="step_1">
    <div class="card-content">
        <div class="card-body">
            <div class="divider divider-left">
                <div class="divider-text" style="font-size: 12px">اطلاعات اولیه</div>
            </div>
            <div class="row">
                <div style="display: none">
                    <input name="contact_id" readonly type="hidden" value="{$priceSuggestionData.contact_id|default:$getData.contact_id}">
                    <input name="price_suggestion_id" readonly type="hidden" value="{$priceSuggestionData.id|default:$getData.price_suggestion_id}">
                    <input name="contact_project_followup_id" readonly type="hidden" value="{$priceSuggestionData.followUpData.id|default:$getData.contact_project_followup_id}">
                </div>
                <div class="col-md-2 mt-2">
                    <label for="">انتخاب تیم</label>
                    <select class="form-control select2" id="sale_team_id" name="sale_team_id">
                        <option selected disabled>یک تیم را انتخاب کنید</option>
                        {foreach $salesTeam|default:[] as $item}
                            <option value="{$item.id}" {($getData.sale_team_id|default:null == $item.id)?'selected':''}>{$item.team_title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-3 mt-2">
                    <label for="">مشتری</label>
                    <input class="form-control" required readonly
                           value="{$priceSuggestionData.contactData.first_name|default:$getData.contact.first_name} {$priceSuggestionData.contactData.last_name|default:$getData.contact.last_name}">
                </div>
                <div class="col-md-3 mt-2">
                    <label>شرکت مشتری</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <button class="btn btn-sm btn-primary" id="quickAddCustomerCompanyButton" type="button"
                                    data-toggle="tooltip" data-placement="top" title=""
                                    data-original-title="افزودن شرکت"><i class="bx bx-plus"></i></button>
                        </div>
                        <input type="text" class="form-control" id="customer_company_title" readonly
                               placeholder="انتخاب نشده است">
                        <div class="input-group-append">
                            <button class="btn btn-sm btn-primary" id="searchCustomerCompanyButton" type="button"
                                    data-toggle="tooltip" data-placement="top" title="" data-original-title="جستجو"><i
                                        class="bx bx-search"></i></button>
                        </div>
                    </div>
                    <input readonly="readonly" id="customer_company_id" name="customer_company_id" type="hidden">
                </div>
                <div class="col-md-2 mt-2">
                    <label for="">تاریخ صدور</label>
                    <input class="form-control text-center" value="{jdate("Y/m/d")}" readonly="readonly">
                </div>
                <div class="col-md-2 mt-2">
                    <label for="">اعتبار</label>
                    <select class="form-control select2" id="day_validity" name="day_validity">
                        {for $i=1 to 30}
                            <option value="{$i}">{$i}</option>
                        {/for}
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>