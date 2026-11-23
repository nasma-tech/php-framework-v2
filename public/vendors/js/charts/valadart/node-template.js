/**
 * node-template.js
 * ---------------------------------------------------------------------------
 * Builds the GoJS Node template. Visually this mirrors the classic Org Chart
 * sample (rounded card, avatar, name, title/department, expander button,
 * "+" add-child button) — the only functional difference is that every
 * displayed value is produced by a Binding + converter function pointing at
 * Lookup, rather than being stored on the node data itself. That means
 * updating node.userId or node.workGroupId automatically refreshes the
 * rendered avatar/name/work-group text with zero manual re-render code.
 * ---------------------------------------------------------------------------
 */

// Deterministic accent color per work group, purely cosmetic (keeps the
// "colored card" look of the original sample without storing any extra
// data on the node itself).
function colorPalette() {
    let output = []

    function getRandomPastelHex() {
        const r = Math.floor(Math.random() * 128 + 127);
        const g = Math.floor(Math.random() * 128 + 127);
        const b = Math.floor(Math.random() * 128 + 127);

        return (
            "#" +
            [r, g, b]
                .map(x => x.toString(16).padStart(2, "0"))
                .join("")
        );
    }

    for (let i = 0; i < workGroups.length; i++) {
        output.push(getRandomPastelHex())
    }

    return output
}

const palette = colorPalette();

function colorForWorkGroup(workGroupId) {
    if (workGroupId === null || workGroupId === undefined) return "#d1d5db";
    return palette[workGroupId % palette.length];
}

function makeNodeTemplate() {
    const $ = go.GraphObject.make;

    return $(
        go.Node,
        "Vertical",
        {
            locationSpot: go.Spot.Top,
            selectionObjectName: "BODY",
            contextMenu: makeContextMenu()
        },

        // --- Card body ----------------------------------------------------------
        $(
            go.Panel,
            "Auto",
            {name: "BODY"},
            new go.Binding("stroke", "isHighlighted", (h) => (h ? "#2f2f2f" : "transparent")).ofObject(),

            $(go.Shape, "RoundedRectangle", {
                fill: "white",
                stroke: "#d1d5db",
                strokeWidth: 1,
                parameter1: 2,
                portId: "",
                shadowVisible: true,
            }),

            $(
                go.Panel,
                "Vertical",
                // Thin colored accent strip along the top of the card
                $(go.Shape, "RoundedRectangle", {
                        height: 4,
                        stretch: go.GraphObject.Horizontal,
                        strokeWidth: 0,
                        parameter1: 2
                    },
                    new go.Binding("fill", "workGroupId", colorForWorkGroup)),
                $(
                    go.Panel,
                    "Table",
                    {margin: new go.Margin(12, 14, 12, 14), defaultAlignment: go.Spot.Right},
                    $(go.RowColumnDefinition, {column: 0, width: 44}),


                    // Avatar
                    $(
                        go.Panel,
                        "Auto",
                        {row: 0, column: 0, rowSpan: 2, margin: new go.Margin(0, 10, 0, 0)},
                        // $(go.Shape, "Circle", {width: 40, height: 40, strokeWidth: 0, fill: "#e5e7eb"}),
                        $(
                            go.Picture,
                            {width: 36, height: 36, imageStretch: go.GraphObject.UniformToFill},
                            new go.Binding("source", "userId", Lookup.getUserAvatar)
                        )
                    ),

                    // Full name — click opens the "user" editor modal
                    $(
                        go.TextBlock,
                        {
                            row: 0,
                            column: 1,
                            font: "bold 12 primary-font",
                            stroke: "#111827",
                            cursor: "pointer",
                            toolTip: $(go.Adornment, "Auto",
                                $(go.Shape, {fill: "#111827"}),
                                $(go.TextBlock, "برای تغییر کاربر کلیک کنید", {
                                    margin: 4, stroke: "white", font: "300 9 primary-font"
                                })
                            ),
                            click: (e, obj) => Editing.openUserEditor(e, obj.part)
                        },
                        new go.Binding("text", "userId", Lookup.getUserFullName)
                    ),

                    // Work group badge — click opens the "work group" editor modal
                    $(
                        go.Panel,
                        "Auto",
                        {
                            row: 1,
                            column: 1,
                            alignment: go.Spot.Right,
                            cursor: "pointer",
                            toolTip: $(
                                go.Adornment,
                                "Auto",
                                $(go.Shape, {fill: "#111827"}),
                                $(go.TextBlock, "برای تغییر گروه کاری کلیک کنید", {
                                    margin: 4,
                                    stroke: "white",
                                    font: "300 9 primary-font"
                                })
                            ),
                            click: (e, obj) => Editing.openWorkGroupEditor(e, obj.part)
                        },

                        // Badge Background
                        $(
                            go.Shape,
                            "RoundedRectangle",
                            {
                                // fill: "#EEF4FF",
                                // stroke: "#C7D2FE",
                                strokeWidth: 1,
                                parameter1: 4
                            },
                            new go.Binding(
                                "fill",
                                "workGroupId",
                                colorForWorkGroup
                            ),
                            new go.Binding(
                                "stroke",
                                "workGroupId",
                                colorForWorkGroup
                            ),
                        ),

                        // Badge Text
                        $(
                            go.TextBlock,
                            {
                                margin: new go.Margin(1, 4, 1, 4),
                                font: "bold 8px primary-font",
                                stroke: "#656565"
                            },
                            new go.Binding("text", "workGroupId", Lookup.getWorkGroupTitle)
                        )
                    )
                )
            )
        ),

        // --- Expand/collapse + add-child controls -------------------------------
        $(
            go.Panel,
            "Horizontal",
            {margin: new go.Margin(4, 0, 0, 0)},
            $("TreeExpanderButton"),
            $(
                "Button",
                {
                    "ButtonBorder.figure": "Circle",
                    click: (e, obj) => OrgChartModel.addEmployee(obj.diagram, obj.part.data)
                },
                $(go.TextBlock, "+", {font: "bold 10px primary-font", margin: 1})
            )
        )
    );
}
