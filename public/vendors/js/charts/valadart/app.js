/**
 * app.js
 * ---------------------------------------------------------------------------
 * Entry point. Boots the diagram and wires up the small demo toolbar
 * (add a root employee, export/import JSON). Nothing GoJS-specific lives
 * here beyond calling into diagram-init.js / model-helpers.js.
 * ---------------------------------------------------------------------------
 */

document.addEventListener("DOMContentLoaded", () => {
    const chartElement = document.getElementById("orgChartDiv");

    if (!chartElement) return;

    const diagram = initOrgChart("orgChartDiv", initialNodeDataArray);

    window.__orgChartDiagram = diagram;

    const btnAddRoot = document.getElementById("btnAddRoot");
    const btnExport = document.getElementById("btnExport");
    const btnImport = document.getElementById("btnImport");
    const btnUndo = document.getElementById("btnUndo");
    const btnRedo = document.getElementById("btnRedo");

    btnAddRoot?.addEventListener("click", () => {
        const model = diagram.model;
        diagram.startTransaction("addRoot");

        model.addNodeData({
            key: OrgChartModel.getNextKey(model),
            userId: null,
            workGroupId: null
        });

        diagram.commitTransaction("addRoot");
    });

    btnExport?.addEventListener("click", () => {
        document.getElementById("jsonOutput").value = OrgChartModel.toJSON(diagram);
    });

    btnImport?.addEventListener("click", () => {
        const json = document.getElementById("jsonOutput").value;

        try {
            diagram.model = OrgChartModel.fromJSON(json);
        } catch (err) {
            alert("Invalid JSON: " + err.message);
        }
    });

    btnUndo?.addEventListener("click", () => diagram.commandHandler.undo());
    btnRedo?.addEventListener("click", () => diagram.commandHandler.redo());
});
