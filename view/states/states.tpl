{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-overlay"></div>
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">لیست {$pluralName}</h4>
                        <div class="heading-elements">
                            {$buttonHelper->refreshAndAddButton({$singleName})}
                        </div>
                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <table class="table"
                                   id="table" style="background-color: #fff;border-radius: 5px;">
                                <thead class="thead-dark">
                                <tr>
                                    <th>#</th>
                                    <th>استان</th>
                                    <th>کشور</th>
                                    <th>پیش شماره</th>
                                    <th>عملیات</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $states as $item}
                                    <tr>
                                        <td></td>
                                        <td>{$item->title}
                                        </td>
                                        <td>{$country::query()->find($item->country_id)->persian_title}</td>
                                        <td>{$item->area_code}</td>
                                        <td>
                                            {$buttonHelper->actionButtons($item->id)}
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>

                            <div class="pagination-wrapper text-center mt-4">
                                <ul class="pagination justify-content-center flex-wrap">
                                    {* دکمه «اولین صفحه» *}
                                    {if $states->currentPage() > 1}
                                        <li class="page-item" style="font-size: 15px !important;">
                                            <a class="page-link" href="?page=1" aria-label="First">
                                                <i class="bx bx-fast-forward"></i>
                                            </a>
                                        </li>
                                    {else}
                                        <li class="page-item disabled" style="font-size: 15px !important;">
                                            <span class="page-link"><i class="bx bx-fast-forward"></i></span>
                                        </li>
                                    {/if}

                                    {* دکمه قبلی *}
                                    {if $states->onFirstPage() == false}
                                        <li class="page-item" style="font-size: 15px !important;">
                                            <a class="page-link" href="?page={$states->currentPage() - 1}"
                                               aria-label="Previous">
                                                <i class="bx bx-skip-next"></i>
                                            </a>
                                        </li>
                                    {else}
                                        <li class="page-item disabled" style="font-size: 15px !important;">
                                            <span class="page-link"><i class="bx bx-skip-next"></i></span>
                                        </li>
                                    {/if}

                                    {* شماره صفحات با خلاصه‌سازی *}
                                    {assign var="start" value=max(1, $states->currentPage()-2)}
                                    {assign var="end" value=min($states->lastPage(), $states->currentPage()+2)}

                                    {if $start > 1}
                                        <li class="page-item" style="font-size: 15px !important;"><a class="page-link"
                                                                                                     href="?page=1">1</a>
                                        </li>
                                        {if $start > 2}
                                            <li class="page-item disabled" style="font-size: 15px !important;"><span
                                                        class="page-link">...</span></li>
                                        {/if}
                                    {/if}

                                    {section name=i start=$start loop=$end+1}
                                        {if $smarty.section.i.index == $states->currentPage()}
                                            <li class="page-item active" style="font-size: 15px !important;"><span
                                                        class="page-link">{$smarty.section.i.index}</span></li>
                                        {else}
                                            <li class="page-item" style="font-size: 15px !important;"><a
                                                        class="page-link"
                                                        href="?page={$smarty.section.i.index}">{$smarty.section.i.index}</a>
                                            </li>
                                        {/if}
                                    {/section}

                                    {if $end < $states->lastPage()}
                                        {if $end < $states->lastPage()-1}
                                            <li class="page-item disabled" style="font-size: 15px !important;"><span
                                                        class="page-link">...</span></li>
                                        {/if}
                                        <li class="page-item" style="font-size: 15px !important;"><a class="page-link"
                                                                                                     href="?page={$states->lastPage()}">{$states->lastPage()}</a>
                                        </li>
                                    {/if}

                                    {* دکمه بعدی *}
                                    {if $states->hasMorePages()}
                                        <li class="page-item" style="font-size: 15px !important;">
                                            <a class="page-link" href="?page={$states->currentPage() + 1}"
                                               aria-label="Next">
                                                <i class="bx bx-skip-previous"></i>
                                            </a>
                                        </li>
                                    {else}
                                        <li class="page-item disabled" style="font-size: 15px !important;">
                                            <span class="page-link"><i class="bx bx-skip-previous"></i></span>
                                        </li>
                                    {/if}

                                    {* دکمه آخرین صفحه *}
                                    {if $states->currentPage() < $states->lastPage()}
                                        <li class="page-item" style="font-size: 15px !important;">
                                            <a class="page-link" href="?page={$states->lastPage()}" aria-label="Last">
                                                <i class="bx bx-rewind"></i>
                                            </a>
                                        </li>
                                    {else}
                                        <li class="page-item disabled" style="font-size: 15px !important;">
                                            <span class="page-link"><i class="bx bx bx-rewind"></i></span>
                                        </li>
                                    {/if}
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}
