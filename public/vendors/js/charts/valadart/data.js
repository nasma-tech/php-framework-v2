/**
 * data.js
 * ---------------------------------------------------------------------------
 * Simulated "external" data sources. In a real application these would come
 * from your backend / API. The important rule enforced throughout this
 * component is:
 *
 *   Node data NEVER contains fullname / avatar / workgroup title directly.
 *   Node data ONLY contains { key, parent, userId, workGroupId }.
 *
 * Everything else is resolved at render-time via lookup.js.
 * ---------------------------------------------------------------------------
 */

const users = $.ajax({
    url: "/users/getUsersForm",
    dataType: "json",
    async: false
}).responseJSON;

const workGroups = $.ajax({
    url: "/WorkGroups/getWorkGroupsIndex",
    dataType: "json",
    async: false
}).responseJSON;

// Normalized node data array — the ONLY thing GoJS's model ever stores.
// `parent` is left out (undefined) for the root node, per go.TreeModel convention.
const initialNodeDataArray = [
    // {key: 1, userId: 1, workGroupId: 1},
    // {key: 2, parent: 1, userId: 2, workGroupId: 2},
    // {key: 3, parent: 1, userId: 3, workGroupId: 3},
    // {key: 4, parent: 2, userId: 4, workGroupId: 2},
    // {key: 5, parent: 2, userId: 5, workGroupId: 2},
    // {key: 6, parent: 3, userId: 6, workGroupId: 3},
    // {key: 7, parent: 1, userId: 7, workGroupId: 4},
    // {key: 8, parent: 7, userId: null, workGroupId: null}
];
