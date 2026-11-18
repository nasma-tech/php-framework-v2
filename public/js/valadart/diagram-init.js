/**
 * diagram-init.js
 * ---------------------------------------------------------------------------
 * Orchestrates everything into a working go.Diagram: layout, link style,
 * node template, custom dragging tool, undo manager, and initial model.
 * This is intentionally the only place that touches `go.Diagram` directly —
 * every other file deals with a narrower concern (data, lookups, template,
 * editing, dragging, serialization).
 * ---------------------------------------------------------------------------
 */

function initOrgChart(divId, nodeDataArray) {
  const $ = go.GraphObject.make;

  const diagram = $(go.Diagram, divId, {
    initialAutoScale: go.Diagram.Uniform,
    contentAlignment: go.Spot.Center,
    "undoManager.isEnabled": true,
    "animationManager.isEnabled": true,
    "toolManager.hoverDelay": 150,
    "commandHandler.deletesTree": true,
    draggingTool: new OrgChartDraggingTool(),
    "draggingTool.dragsTree": true,
    layout: $(go.TreeLayout, {
      angle: 90,
      layerSpacing: 45,
      nodeSpacing: 20,
      alignment: go.TreeLayout.AlignmentCenterChildren,
      compaction: go.TreeLayout.CompactionNone
    })
  });

  diagram.nodeTemplate = makeNodeTemplate();

  diagram.linkTemplate = $(
    go.Link,
    {
      routing: go.Link.Orthogonal,
      corner: 8,
      selectable: false,
      layerName: "Background"
    },
    $(go.Shape, { stroke: "#9ca3af", strokeWidth: 1.5 })
  );

  diagram.model = OrgChartModel.createModel(nodeDataArray);

  return diagram;
}
