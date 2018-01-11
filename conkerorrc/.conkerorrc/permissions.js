//........................................
// Permissions

// Permission Manager
// http://stackoverflow.com/questions/33536342/how-to-configure-desktop-notification-in-conkeror-browser
// https://truongtx.me/2016/02/18/conkeror-working-with-web-page-permission
// https://github.com/tmtxt/conkerorrc
const permissionManager = Components.classes["@mozilla.org/permissionmanager;1"]
      .getService(Components.interfaces.nsIPermissionManager);

var permissionList = [
    {desc: "Audio Capture", value: "audio-capture"},
    {desc: "Video Capture", value: "video-capture"},
    {desc: "Geo Location", value: "collocation"},
    {desc: "Desktop Notifications", value: "desktop-notification"}
];

var readPermission = function(I) {
    return I.minibuffer.read(
        $prompt = "Select permission:",
        $completer = new all_word_completer(
            $completions = permissionList,
            $get_string = function(x) {return x.value;},
            $get_description = function(x) {return x.desc;}
        )
    );
};

var addPermission = function(I) {
    var perm = yield readPermission(I);
    var uri = make_uri(I.buffer.current_uri.prePath);
    var allow = Components.interfaces.nsIPermissionManager.ALLOW_ACTION;

    permissionManager.add(uri, perm, allow);

    I.minibuffer.message("Permission " + perm + " added");
};

var removePermission = function(I) {
    var perm = yield readPermission(I);
    var uri = make_uri(I.buffer.current_uri.prePath);
    var deny = Components.interfaces.nsIPermissionManager.DENY_ACTION;

    permissionManager.add(uri, perm, allow);

    I.minibuffer.message("Permission " + perm + " removed");
};

interactive("add-permission", "Add specific permission for current uri", addPermission);
interactive("remove-permission", "Remove specific permission for current uri", removePermission);
