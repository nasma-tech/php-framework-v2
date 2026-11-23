<div class="card shadow">
    <div class="card-content">
        <div class="card-header">
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
            <button class="hidden" id="btnExport">Export JSON</button>
            <button class="hidden" id="btnImport">Import JSON</button>
        </div>
        <div class="card-body">
            <div class="row">
                <div id="orgChartDiv" dir="ltr"></div>
            </div>
            <input name="jsonOutput" type="hidden" id="jsonOutput" value=''>
        </div>
    </div>
</div>