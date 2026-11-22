/**
 * app.js
 * ---------------------------------------------------------------------------
 * Entry point. Boots the diagram and wires up the small demo toolbar
 * (add a root employee, export/import JSON). Nothing GoJS-specific lives
 * here beyond calling into diagram-init.js / model-helpers.js.
 * ---------------------------------------------------------------------------
 */

document.addEventListener("DOMContentLoaded", () => {
    const diagram = initOrgChart("orgChartDiv", initialNodeDataArray);
    window.__orgChartDiagram = diagram; // handy for console access / debugging

    document.getElementById("btnAddRoot").addEventListener("click", () => {
        const model = diagram.model;
        diagram.startTransaction("addRoot");
        model.addNodeData({
            key: OrgChartModel.getNextKey(model),
            userId: null,
            workGroupId: null
        });
        diagram.commitTransaction("addRoot");
    });

    document.getElementById("btnExport").addEventListener("click", () => {
        document.getElementById("jsonOutput").value = OrgChartModel.toJSON(diagram);
    });

    document.getElementById("btnImport").addEventListener("click", () => {
        const json = document.getElementById("jsonOutput").value;
        try {
            diagram.model = OrgChartModel.fromJSON(json);
        } catch (err) {
            alert("Invalid JSON: " + err.message);
        }
    });

    document.getElementById("btnUndo").addEventListener("click", () => diagram.commandHandler.undo());
    document.getElementById("btnRedo").addEventListener("click", () => diagram.commandHandler.redo());
});
