/**
 * lookup.js
 * ---------------------------------------------------------------------------
 * Pure helper functions that resolve foreign keys (userId, workGroupId)
 * stored on node data into display values. These are used both by GoJS
 * Bindings (so the diagram re-renders automatically when a key changes)
 * and by the Select2 editors (to build the dropdown option lists).
 *
 * Swap the implementations here for real API/service calls without
 * touching the diagram, node template, or editing logic.
 * ---------------------------------------------------------------------------
 */

const Lookup = (function () {
  const PLACEHOLDER_AVATAR = APP_URL() + "/Storage/DefaultImages/default.png";

  function getUser(userId) {
    if (userId === null || userId === undefined) return null;
    return users.find((u) => u.id === userId) || null;
  }

  function getWorkGroup(workGroupId) {
    if (workGroupId === null || workGroupId === undefined) return null;
    return workGroups.find((w) => w.id === workGroupId) || null;
  }

  // --- Binding converters (signature: (value, obj) => displayValue) ---------

  function getUserFullName(userId) {
    const u = getUser(userId);
    return u ? u.fullname : "بدون کاربر";
  }

  function getUserAvatar(userId) {
    const u = getUser(userId);
    return u ? u.avatar : PLACEHOLDER_AVATAR;
  }

  function getWorkGroupTitle(workGroupId) {
    const w = getWorkGroup(workGroupId);
    return w ? w.title : "فاقد گروه بندی";
  }

  // --- Select2 option builders ----------------------------------------------

  function getUserOptions() {
    return users.map((u) => ({ id: u.id, text: u.fullname }));
  }

  function getWorkGroupOptions() {
    return workGroups.map((w) => ({ id: w.id, text: w.title }));
  }

  return {
    getUser,
    getWorkGroup,
    getUserFullName,
    getUserAvatar,
    getWorkGroupTitle,
    getUserOptions,
    getWorkGroupOptions
  };
})();
