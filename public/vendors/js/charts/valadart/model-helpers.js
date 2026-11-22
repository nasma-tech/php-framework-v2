/**
 * model-helpers.js
 * ---------------------------------------------------------------------------
 * Everything related to the GoJS Model itself: creating it, adding/removing
 * employees, and JSON import/export. Kept separate from diagram/rendering
 * concerns so it can be unit-tested independently of GoJS's visual layer.
 *
 * We use go.TreeModel (rather than GraphLinksModel) because our data model
 * is exactly what TreeModel expects: each node references its parent via a
 * single key property. This gives us tree-shaped links, TreeLayout support,
 * and the `setParentKeyForNodeData` API used by the drag & drop tool — for
 * free, with no separate link array to keep in sync.
 * ---------------------------------------------------------------------------
 */

const OrgChartModel = (function () {
  function createModel(nodeDataArray) {
    const model = new go.TreeModel(nodeDataArray);
    model.nodeKeyProperty = "key";
    model.nodeParentKeyProperty = "parent";
    return model;
  }

  function getNextKey(model) {
    let max = 0;
    model.nodeDataArray.forEach((d) => {
      if (typeof d.key === "number" && d.key > max) max = d.key;
    });
    return max + 1;
  }

  // Adds a brand-new, unassigned employee node under parentData.
  // Matches the required shape exactly: { key, parent, userId: null, workGroupId: null }
  function addEmployee(diagram, parentData) {
    const model = diagram.model;
    let newData;
    diagram.startTransaction("addEmployee");
    newData = {
      key: getNextKey(model),
      parent: parentData.key,
      userId: null,
      workGroupId: null
    };
    model.addNodeData(newData);
    diagram.commitTransaction("addEmployee");
    return newData;
  }

  // Deletes nodeData AND its entire subtree in one undoable step.
  // We deliberately go through diagram.commandHandler.deleteSelection()
  // instead of calling model.removeNodeData directly: removeNodeData only
  // removes the single node, leaving orphaned children whose `parent` key
  // no longer resolves (they then get scattered by layout). CommandHandler,
  // with `deletesTree: true` (set in diagram-init.js), correctly walks and
  // removes the whole tree branch for us.
  function deleteEmployee(diagram, nodeData) {
    const node = diagram.findPartForData(nodeData);
    if (!node) return; // nothing to do if it's not in the diagram
    diagram.select(node);
    diagram.commandHandler.deleteSelection();
  }

  function toJSON(diagram) {
    return diagram.model.toJson();
  }

  function fromJSON(json) {
    return go.Model.fromJson(json);
  }

  return { createModel, getNextKey, addEmployee, deleteEmployee, toJSON, fromJSON };
})();
