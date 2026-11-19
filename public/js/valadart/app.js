/**
 * app.js
 * ---------------------------------------------------------------------------
 * Entry point. Boots the diagram and wires up the small demo toolbar
 * (add a root employee, export/import JSON). Nothing GoJS-specific lives
 * here beyond calling into diagram-init.js / model-helpers.js.
 * ---------------------------------------------------------------------------
 */


document.addEventListener("DOMContentLoaded", () => {
    let oldData = [];

    try {
        oldData = JSON.parse($("#jsonOutput").val());
    } catch (e) {}

    const diagram = initOrgChart("orgChartDiv", oldData);
    window.__orgChartDiagram = diagram;

    const jsonOutput = document.getElementById("jsonOutput");
    const jsonOutputView = document.getElementById("jsonOutputView");

    function updateJsonOutput() {
        const json = diagram.model.toJson();

        if (jsonOutput) {
            jsonOutput.value = json;
        }

        if (jsonOutputView) {
            jsonOutputView.value = json;
        }
    }

    diagram.addModelChangedListener((e) => {
        if (e.isTransactionFinished) {
            updateJsonOutput();
        }
    });

    updateJsonOutput();

    document.getElementById("btnAddRoot")?.addEventListener("click", () => {
        const model = diagram.model;

        diagram.startTransaction("addRoot");

        model.addNodeData({
            key: OrgChartModel.getNextKey(model),
            userId: null,
            workGroupId: null
        });

        diagram.commitTransaction("addRoot");
    });

    document.getElementById("btnExport")?.addEventListener("click", updateJsonOutput);

    document.getElementById("btnImport")?.addEventListener("click", () => {
        try {
            diagram.model = OrgChartModel.fromJSON(jsonOutput.value);
            updateJsonOutput();
        } catch (err) {
            alert("Invalid JSON: " + err.message);
        }
    });

    document.getElementById("btnUndo")?.addEventListener("click", () => {
        diagram.commandHandler.undo();
    });

    document.getElementById("btnRedo")?.addEventListener("click", () => {
        diagram.commandHandler.redo();
    });
});


