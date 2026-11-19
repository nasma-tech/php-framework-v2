
const Editing = (function () {
    const SELECT_ID = "orgchart-swal-select";

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

                $select.append(
                    new Option("— Unassigned —", "", false, currentValue == null)
                );

                options.forEach((opt) => {
                    $select.append(
                        new Option(opt.text, opt.id, false, String(opt.id) === String(currentValue))
                    );
                });

                $select.select2({
                    width: "100%",
                    placeholder: "Search...",
                    dropdownParent: $(Swal.getPopup())
                });
            },

            preConfirm: () => {
                const raw = $(`#${SELECT_ID}`).val();
                return raw === "" || raw === null ? null : Number(raw);
            },

            willClose: () => {
                const $select = $(`#${SELECT_ID}`);

                if ($select.data("select2")) {
                    $select.select2("close");
                    $select.select2("destroy");
                }

                if (document.activeElement) {
                    document.activeElement.blur();
                }
            }
        }).then((result) => {
            if (result.isConfirmed) {
                onChange(result.value);
            }
        });
    }

    function openUserEditor(e, node) {
        _openEditor(
            node,
            Lookup.getUserOptions(),
            node.data.userId,
            (value) => {
                const diagram = node.diagram;

                diagram.startTransaction("edit user");
                diagram.model.setDataProperty(node.data, "userId", value);
                diagram.commitTransaction("edit user");
            },
            "انتخاب کاربر"
        );
    }

    function openWorkGroupEditor(e, node) {
        _openEditor(
            node,
            Lookup.getWorkGroupOptions(),
            node.data.workGroupId,
            (value) => {
                const diagram = node.diagram;

                diagram.startTransaction("edit work group");
                diagram.model.setDataProperty(node.data, "workGroupId", value);
                diagram.commitTransaction("edit work group");
            },
            "انتخاب گروه کاری"
        );
    }

    return {
        openUserEditor,
        openWorkGroupEditor
    };
})();
