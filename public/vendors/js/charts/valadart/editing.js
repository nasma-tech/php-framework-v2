/**
 * editing.js
 * ---------------------------------------------------------------------------
 * Replaces GoJS's default in-place TextBlock editor with a searchable
 * Select2 dropdown shown inside a SweetAlert2 modal. Clicking the "user" or
 * "work group" field on a node (or picking it from the context menu) opens
 * a centered modal with a Select2 <select>; confirming commits the new id
 * to the model inside a proper GoJS transaction (so Undo/Redo keeps
 * working), and the modal closes.
 *
 * Because the node template's text is bound to userId/workGroupId via
 * Bindings, committing the new id is the ONLY step needed — the diagram
 * re-renders the name/avatar/work-group text automatically.
 * ---------------------------------------------------------------------------
 */

const Editing = (function () {
    const SELECT_ID = "orgchart-swal-select";

    // Shows a SweetAlert2 modal containing a searchable Select2 populated
    // with `options`, pre-selecting `currentValue`. If the user confirms,
    // `onChange(newId)` is called with the picked value (or null if cleared).
    function _openEditor(node, options, currentValue, onChange, title) {
        Swal.fire({
            title: title,
            html: `<select id="${SELECT_ID}" style="width:100%"></select>`,
            showCancelButton: true,
            confirmButtonText: "ذخیره",
            cancelButtonText: "انصراف",
            focusConfirm: false,
            didOpen: () => {
                const $select = $(`#${SELECT_ID}`);

                // Blank first option so the field can be cleared back to "Unassigned"
                $select.append(new Option("— Unassigned —", "", false, currentValue == null));
                options.forEach((opt) => {
                    $select.append(new Option(opt.text, opt.id, false, opt.id === currentValue));
                });

                // dropdownParent is required so Select2's dropdown renders inside
                // (and stacks correctly above) the SweetAlert2 modal.
                $select.select2({
                    width: "100%",
                    placeholder: "Search...",
                    dropdownParent: $(Swal.getPopup())
                });
                // $select.select2("open");
            },
            preConfirm: () => {
                const raw = $(`#${SELECT_ID}`).val();
                return raw === "" || raw === null ? null : Number(raw);
            },
            willClose: () => {
                const $select = $(`#${SELECT_ID}`);
                if ($select.data("select2")) $select.select2("destroy");
            }
        }).then((result) => {
            if (result.isConfirmed) {
                onChange(result.value);
            }
        });
    }

    function openUserEditor(e, node) {
        _openEditor(node, Lookup.getUserOptions(), node.data.userId, (value) => {
            const diagram = node.diagram;
            diagram.startTransaction("edit user");
            diagram.model.setDataProperty(node.data, "userId", value);
            diagram.commitTransaction("edit user");
        }, "انتخاب کاربر");
    }

    function openWorkGroupEditor(e, node) {
        _openEditor(node, Lookup.getWorkGroupOptions(), node.data.workGroupId, (value) => {
            const diagram = node.diagram;
            diagram.startTransaction("edit work group");
            diagram.model.setDataProperty(node.data, "workGroupId", value);
            diagram.commitTransaction("edit work group");
        }, "انتخاب گروه کاری");
    }

    return {openUserEditor, openWorkGroupEditor};
})();
