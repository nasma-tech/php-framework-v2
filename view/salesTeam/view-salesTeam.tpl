{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        <div class="card shadow">
            <div class="card-content">
                <div class="card-header">
                    <h4 class="card-title" style="float: right">مشاهده {$singleName}</h4>
                    {$helper->refreshAndBackBtn()}
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
                    <input name="jsonOutput" type="hidden" id="jsonOutput" value='{$getData->nodes_data_json}'>
                </div>
            </div>
        </div>
    </div>
</div>

{include 'sections/footer.tpl'}