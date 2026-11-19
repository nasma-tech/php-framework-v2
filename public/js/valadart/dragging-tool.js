/**
 * dragging-tool.js
 * ---------------------------------------------------------------------------
 * Custom DraggingTool that reproduces the classic GoJS Org Chart drag & drop
 * behavior: dragging a node and dropping it on top of another node re-parents
 * it (changes ONLY the `parent` key). Everything else about the node's data
 * (userId, workGroupId) is left untouched.
 *
 * We rely on go.TreeModel#setParentKeyForNodeData, which updates the parent
 * property and keeps the tree's implicit links in sync — no manual link
 * bookkeeping required.
 * ---------------------------------------------------------------------------
 */

class OrgChartDraggingTool extends go.DraggingTool {
  constructor() {
    super();
    this._targetNode = null; // node currently highlighted as a valid drop target
  }

  doDragOver(pt, obj) {
    super.doDragOver(pt, obj);
    const draggedNode = this.currentPart;
    if (!(draggedNode instanceof go.Node)) return;
    this._highlight(this._findDropTarget(pt, draggedNode));
  }

  doDropOnto(pt, obj) {
    super.doDropOnto(pt, obj);
    const draggedNode = this.currentPart;
    const target = draggedNode instanceof go.Node ? this._findDropTarget(pt, draggedNode) : null;
    this._highlight(null);
    if (target) this._reparent(draggedNode, target);
  }

  doDeactivate() {
    this._highlight(null);
    super.doDeactivate();
  }

  // Finds the Node (if any) under `pt`, excluding the dragged node itself
  // and any of the dragged node's own descendants (can't drop a node onto
  // its own subtree).
  _findDropTarget(pt, draggedNode) {
    const diagram = this.diagram;
    const part = diagram.findPartAt(pt, true);
    if (!(part instanceof go.Node)) return null;
    if (part === draggedNode) return null;
    if (this._isDescendantOf(part, draggedNode)) return null;
    return part;
  }

  // True if `node` is draggedNode itself or a descendant of it in the tree.
  _isDescendantOf(node, draggedNode) {
    let n = node;
    while (n) {
      if (n === draggedNode) return true;
      n = n.findTreeParentNode();
    }
    return false;
  }

  _highlight(node) {
    if (this._targetNode && this._targetNode !== node) {
      this._targetNode.isHighlighted = false;
    }
    if (node) node.isHighlighted = true;
    this._targetNode = node;
  }

  _reparent(draggedNode, targetNode) {
    const diagram = this.diagram;
    diagram.startTransaction("reparentNode");
    diagram.model.setParentKeyForNodeData(draggedNode.data, targetNode.data.key);
    diagram.commitTransaction("reparentNode");
  }
}
