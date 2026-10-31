{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}
<div class="app-content content">
    <div class="content-overlay"></div>
    <div class="content-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-4" style="margin-top: 3px">
                    <div class="card shadow h-100">
                        <div class="card-header mx-auto pt-3">
                            <div class="avatar bg-rgba-primary p-50">
                                <img class="img-fluid" src="{$userHelper->getUserImage()}"
                                     alt="img placeholder" height="134" width="134">
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="card-body text-center">
                                <h4>{$user->full_name}</h4>
                                <p>{((isset($smarty.session.roleTitle)) ? $smarty.session.roleTitle : '')}</p>
                                <div class="d-flex justify-content-around mb-1">
                                    <div class="card-icons d-flex flex-column">
                                        <i class="bx bx-camera font-medium-5 font-weight-bold"></i>
                                        <p>0</p>
                                    </div>
                                    <div class="card-icons d-flex flex-column">
                                        <i class="bx bx-heart font-medium-5 font-weight-bold"></i>
                                        <p>0</p>
                                    </div>
                                    <div class="card-icons d-flex flex-column">
                                        <i class="bx bx-user font-medium-5 font-weight-bold"></i>
                                        <p>0</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 pl-md-0" style="margin-top: 3px">
                    <div class="card shadow h-100">
                        <div class="card-body">
                            <div class="tab-content text-justify" id="nav-tabContent">
                                <div class="tab-pane line-height-2 show active" id="list-Cartable" role="tabpanel"
                                     aria-labelledby="list-Cartable-list">
                                    <section id="table-cartable">
                                        <ul class="nav nav-tabs" role="tablist">
                                            {foreach $tabData as $tabItem}
                                                <li class="nav-item">
                                                    <a class="nav-link active" id="{$tabItem['englishTitle']}-tab"
                                                       data-toggle="tab"
                                                       href="#{$tabItem['englishTitle']}"
                                                       aria-controls="{$tabItem['englishTitle']}" role="tab"
                                                       aria-selected="true">
                                                        <i class="bx {$tabItem['tabIcon']} align-middle"></i>
                                                        <span class="badge badge-pill badge-danger badge-up countCartable">{count($tabItem['data'])}</span>
                                                        <span class="align-middle">{$tabItem['persianTitle']}</span>
                                                    </a>
                                                </li>
                                            {/foreach}
                                        </ul>
                                        <div class="tab-content">
                                            {foreach $tabData as $tabItem}
                                                <div class="tab-pane {(($tabItem['isActive']) ? 'active' : '')}"
                                                     id="{$tabItem['englishTitle']}"
                                                     aria-labelledby="{$tabItem['englishTitle']}-tab"
                                                     role="tabpanel">
                                                    <div class="table-responsive">
                                                        <table class="table table-striped">
                                                            <thead class="thead-dark">
                                                            <tr>
                                                                {foreach $tabItem['tabHeaders'] as $tabHeader}
                                                                    <th class="text-center border font-small-3">{$tabHeader}</th>
                                                                {/foreach}
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            {foreach $tabItem['data'] as $cartableItem}
                                                                <tr class="text-center {$labelColorData[$cartableItem['statusData']['code']]}">
                                                                    <td class="border">{$cartableItem['cartableData']['persianTitle']}</td>
                                                                    <td class="border">{$cartableItem['statusData']['title']}</td>
                                                                    <td class="border">{$cartableItem['requesterData']['userFullName']}</td>
                                                                    <td class="border">{$cartableItem['senderData']['userFullName']}</td>
                                                                    <td class="border">{$cartableItem['dateSend']}</td>
                                                                    <td class="border">{$cartableItem['timeSend']}</td>
                                                                    <td class="border">
                                                                        <a class="btn btn-icon rounded-circle btn-primary"
                                                                           href="{$cartableItem['viewAddress']}">
                                                                            <i class="bx bx-show"></i>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            {/foreach}
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{include 'sections/footer.tpl'}