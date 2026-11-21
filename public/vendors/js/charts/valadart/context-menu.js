/**
 * context-menu.js
 * ---------------------------------------------------------------------------
 * Right-click context menu for a node, built the same way the original Org
 * Chart sample does it (a go.Adornment "ContextMenu" made of standard
 * "ContextMenuButton" panels), just wired to our normalized model helpers
 * and Select2 editors instead of directly editing text.
 * ---------------------------------------------------------------------------
 */

function makeContextMenu() {
    const $ = go.GraphObject.make;

    return $(
        "ContextMenu",
        $(
            "ContextMenuButton",
            $(go.TextBlock, "افزودن کاربر", {
                font: "200 10 primary-font"
            }),
            {click: (e, obj) => OrgChartModel.addEmployee(obj.part.diagram, obj.part.adornedPart.data)}
        ),
        $(
            "ContextMenuButton",
            $(go.TextBlock, "ویرایش کاربر", {
                font: "200 10 primary-font"
            }),
            {click: (e, obj) => Editing.openUserEditor(e, obj.part.adornedPart)}
        ),
        $(
            "ContextMenuButton",
            $(go.TextBlock, "ویرایش گروه کاری", {
                font: "200 10 primary-font"
            }),
            {click: (e, obj) => Editing.openWorkGroupEditor(e, obj.part.adornedPart)}
        ),
        $(
            "ContextMenuButton",
            $(go.TextBlock, "حذف کاربر", {
                font: "200 10 primary-font"
            }),
            {
                click: (e, obj) => OrgChartModel.deleteEmployee(obj.part.diagram, obj.part.adornedPart.data)
            }
        )
    );
}
