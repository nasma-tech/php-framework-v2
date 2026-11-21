{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        {$flashMessageHelper->formCallBack()}
        <form method="post" id="mainForm" action="/salesTeam/edit/{$getData['id']}">
            <div class="card shadow">
                <div class="card-content">
                    <div class="card-header">
                        <h4 class="card-title" style="float: right">ویرایش {$singleName}</h4>
                        {$buttonHelper->refreshAndBackBtn()}
                        <button class="btn btn-xs btn-primary float-right" type="button" style="margin-right: 0.35rem"
                                id="btnAddRoot"><i
                                    class="bx bx-plus" style="font-size: 0.9rem"></i>افزودن Root جدید
                        </button>
                        <button class="btn btn-xs btn-danger float-right" type="button" style="margin-right: 0.35rem"
                                id="btnUndo"><i
                                    class="bx bx-undo" style="font-size: 0.9rem"></i>Undo
                        </button>
                        <button class="btn btn-xs btn-success float-right" type="button" style="margin-right: 0.35rem"
                                id="btnRedo"><i
                                    class="bx bx-redo" style="font-size: 0.9rem"></i>Redo
                        </button>
                        <button type="button" class="hidden" id="btnExport">Export JSON</button>
                        <button type="button" class="hidden" id="btnImport">Import JSON</button>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                <label>عنوان تیم</label>
                                <input class="form-control" id="team_title" name="team_title" value="{$getData->team_title}">
                            </div>
                        </div>
                        <hr>
                        <div id="orgChartDiv" dir="ltr"></div>
                    </div>
                </div>
            </div>
            <div class="card shadow mt-1">
                <div class="card-content">
                    <div class="card-body">
                        {$csrf->csrfTokenInput()}
                        <input name="jsonOutput" type="hidden" id="jsonOutput" value='{$getData->nodes_data_json}'>
                        <button class="btn btn-sm btn-warning editFormAjax" data-id="{$getData->id}">ویرایش تیم</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

{include 'sections/footer.tpl'}