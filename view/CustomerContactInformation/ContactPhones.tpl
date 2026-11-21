<div class="card shadow cc-initial-info" style="margin-top: 2px;height: 100%">
    <div class="card-content">
        <div class="card-header">
            <div class="divider divider-left">
                <div class="divider-text" style="font-size: 11px">اطلاعات تماس</div>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table text-center">
                    <thead class="thead-dark">
                    <tr>
                        <th class="border" width="200">عنوان</th>
                        <th class="border" width="300">شماره تماس</th>
                        <th class="border">عملیات</th>
                    </tr>
                    </thead>
                    <tbody id="phoneTableBody">
                    {if $contactPhones|default:[]}
                        {foreach $contactPhones as $key=>$item}
                            <tr class="phoneRowTr">
                                <td class="border">
                                    {$item.phoneLabelData.type}
                                </td>
                                <td class="border">
                                    {$item.phone_number}
                                </td>
                                <td class="border">
                                    <div class="dropup">
                                                    <span class="bx bx-dots-vertical-rounded font-medium-3 dropdown-toggle nav-hide-arrow cursor-pointer"
                                                          data-toggle="dropdown" aria-haspopup="true"
                                                          aria-expanded="false" role="menu">
                                                    </span>
                                        <div class="dropdown-menu" x-placement="bottom-start">
                                            <a class="dropdown-item text-danger" href="#">
                                                <i class="bx bx-trash text-danger mr-1"></i>
                                                حذف
                                            </a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="socialTrRow_{$key+1}">
                                <td class="border" colspan="3">
                                    <ul class="list-unstyled" style="margin-top: 5px;margin-bottom: 3px"
                                        id="socialRow_{$key+1}">
                                        {if $item.phoneLabelData.has_social_network}
                                            {foreach $socialNetWorksList|default:[] as $socialKey=>$row}
                                                <li class="d-inline-block mr-2 mb-1">
                                                    <fieldset>
                                                        <div class="checkbox checkbox-primary checkbox-glow">
                                                            <input type="checkbox"
                                                                   disabled="disabled"
{*                                                                   name="contactPhone[{$socialKey+1}][socialList][]"*}
                                                                   value="{$row.id}"
                                                                    {if in_array($row.id, $item->socialNetworks->pluck('id')->toArray()|default:[])}
                                                                        checked
                                                                    {/if}
                                                                   id="socialBox_{$key}_{$socialKey}">
                                                            <label for="socialBox_{$key}_{$socialKey}"><img
                                                                        src="/Storage/socialNetworkIcons/{$row.icon}"
                                                                        alt="{$row.title}"
                                                                        width="20"
                                                                        height="20"></label>
                                                        </div>
                                                    </fieldset>
                                                </li>
                                            {/foreach}
                                        {/if}
                                    </ul>
                                </td>
                            </tr>
                        {/foreach}
                    {/if}
                    </tbody>
                    <tfoot>
                    <tr>
                        <th class="border" colspan="4">
                            <button class="btn btn-xs btn-success w-100" id="phoneAppend" type="button">
                                <i class="bx bx-plus" style="font-size: 14px"></i>
                            </button>
                        </th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    {if isset($contactData)}
        <div class="card-footer">
            <button class="btn btn-sm btn-primary float-right">افزودن شماره تماس</button>
        </div>
    {/if}
</div>
