// the default page for new buffers.
homepage = "localhost:31831";

require("new-tabs.js");
require("favicon");

require("github");
require("gmail");
require("reddit");
require("youtube");
require("page-modes/google-search-results.js");

require("session.js");
require("clicks-in-new-buffer.js");
require("block-content-focus-change.js");
require("favicon");
require("content-policy.js");

// save a keystroke when selecting a dom node by number.
//hints_auto_exit_delay = 300;
//hints_ambiguous_auto_exit_delay = 500;
hint_digits="12345";
hints_minibuffer_annotation_mode(true);

// Some settings
session_auto_save_auto_load = true;
session_save_buffer_access_order = true;

url_remoting_fn = load_url_in_new_buffer;
url_completion_use_history = true;
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND;

xkcd_add_title = true;
read_buffer_show_icons = true;
view_source_use_external_editor = true;  // view source in your editor.

//set the temp dir location.  the idea is this can be on /tmpfs in ram.
//This will not take effect until after the first restart.
user_pref("browser.cache.disk.parent_directory","/tmp/sketch/conkeror");

// don't set the user agent, let conk add Firefox to the string itself
session_pref("general.useragent.compatMode.firefox",true);

//enable if full screen video stops working
session_pref("full-screen-api.enabled", true);

add_hook("mode_line_hook", mode_line_adder(buffer_icon_widget), true);
add_hook("mode_line_hook", mode_line_adder(loading_count_widget), true);

// fix crisp edges
register_user_stylesheet(make_css_data_uri(["* { image-rendering: -moz-crisp-edges; }"]));
read_buffer_show_icons = true;

// Delayed session load
/*
    From http://retroj.net/git/conkerorrc/content-delay.js

    This script is a hack that provides delayed loading for content buffers.
    The initial url of a buffer will not be loaded until that buffer is
    switched to.  Precaution is taken that the buffer's display_uri_string
    returns the delayed url, not about:blank, so things like tabs and sessions
    will still work properly.
*/
function content_delay (spec) {
    this.delayed_load = spec;
}

function content_delay_init (b) {
    if (b != b.window.buffers.current &&
        b instanceof content_buffer)
    {
        b.load = content_delay;
        b.__defineGetter__("display_uri_string",
            function () {
                if (this.delayed_load) {
                    if (this.delayed_load instanceof load_spec)
                        return load_spec_uri_string(this.delayed_load);
                    return this.delayed_load;
                }
                if (this._display_uri)
                    return this._display_uri;
                if (this.current_uri)
                    return this.current_uri.spec;
                return "";
            });
    }
}

function content_delay_do_initial_load (b) {
    if (b.hasOwnProperty("load")) {
        delete b.load;
        if (b.hasOwnProperty("delayed_load")) {
            b.load(b.delayed_load);
            delete b.delayed_load;
        }
    }
}

add_hook("create_buffer_early_hook", content_delay_init);
add_hook("select_buffer_hook", content_delay_do_initial_load);

//browser_prevent_automatic_form_focus_mode(true);
google_search_bind_number_shortcuts();

webjumps.g = webjumps.google;
webjumps.w = webjumps.wikipedia;

define_webjump("gi", "http://www.google.com/images?q=%s&safe=off", $alternative = "http://www.google.com/imghp?as_q=&safe=off");

// Webjump oneliners
define_webjump("codesearch", "http://codesearch.debian.net/search?q=%s");
define_webjump("leo", "http://dict.leo.org/?lp=ende&lang=de&searchLoc=0&cmpType=relaxed&relink=on&sectHdr=off&spellToler=std&search=%s");
define_webjump("identica", "http://identi.ca/%s");
define_webjump("imdb", "http://imdb.com/find?q=%s");
define_webjump("kol", "http://kol.coldfront.net/thekolwiki/index.php/%s");
define_webjump("oh", "https://www.openhub.net/p?query=%s");
define_webjump("ixquick", "http://ixquick.com/do/metasearch.pl?query=%s");
define_webjump("trans", "http://translate.google.com/translate_t#auto|en|%s");
define_webjump("tw", "https://twitter.com/%s");
define_webjump("urban", "http://www.urbandictionary.com/define.php?term=%s");
define_webjump("wo", "http://www.wolframalpha.com/input/?i=%s");

// CVE
define_webjump("cve", "https://cve.mitre.org/cgi-bin/cvename.cgi?name=%s");
// Additional key bindings
define_key(content_buffer_normal_keymap, "t", "find-url-new-buffer");
define_key(content_buffer_normal_keymap, "d", "kill-current-buffer");

define_key(content_buffer_normal_keymap, "gt", "buffer-next");
define_key(content_buffer_normal_keymap, "gT", "buffer-previous");

define_key(default_global_keymap, "u", "restore-killed-buffer-url");
define_key(default_global_keymap, "U", "revive-buffer");

var kill_buffer_original = kill_buffer_original || kill_buffer;
var killed_buffer_urls = [];
var killed_buffer_histories = [];

//  remember_killed_buffer
kill_buffer = function (buffer, force) {
    var hist = buffer.web_navigation.sessionHistory;

    if (buffer.display_uri_string && hist) {
        killed_buffer_histories.push(hist);
        killed_buffer_urls.push(buffer.display_uri_string);
    }

    kill_buffer_original(buffer,force);
};

interactive("revive-buffer",
    "Loads url from a previously killed buffer",
    function restore_killed_buffer (I) {
        if (killed_buffer_urls.length !== 0) {
            var url = yield I.minibuffer.read(
                $prompt = "Restore killed url:",
                $completer = new all_word_completer($completions = killed_buffer_urls),
                $default_completion = killed_buffer_urls[killed_buffer_urls.length - 1],
                $auto_complete = "url",
                $auto_complete_initial = true,
                $auto_complete_delay = 0,
                $require_match = true);

            var window = I.window;
            var creator = buffer_creator(content_buffer);
            var idx = killed_buffer_urls.indexOf(url);

            // Create the buffer
            var buf = creator(window, null);

            // Recover the history
            buf.web_navigation.sessionHistory = killed_buffer_histories[idx];

            // This line may seem redundant, but it's necessary.
            var original_index = buf.web_navigation.sessionHistory.index;
            buf.web_navigation.gotoIndex(original_index);

            // Focus the new tab
            window.buffers.current = buf;

            // Remove revived from cemitery
            killed_buffer_urls.splice(idx,1);
            killed_buffer_histories.splice(idx,1);
        } else {
            I.window.minibuffer.message("No killed buffer urls");
        }
    });

//////////////////////////////////////////
// BIG HINT NUMBERS
hint_background_color = '#2b768d';
active_hint_background_color = '#005faf';
register_user_stylesheet(
    "data:text/css," +
        escape(
            "@namespace url(\"http://www.w3.org/1999/xhtml\");\n" +
            "span.__conkeror_hint {\n"+
            "  font-size: 12pt !important;\n"+
            "  font-family: Iosevka Term Heavy !important;\n"+
            "  line-height: 12pt !important;\n"+
            "}"));

register_user_stylesheet(
    "data:text/css," +
        escape (
            "span.__conkeror_hint {" +
                " border: 1px solid #222233 !important;" +
                " color: #ffffff !important;" +
                " background-color: #222288 !important;" +
                "}"));

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

//...................................
// Downloads
//...................................

// where to open download windows
download_buffer_automatic_open_target=OPEN_NEW_BUFFER_BACKGROUND;
url_remoting_fn=load_url_in_new_buffer;

// set cwd for downloads
cwd=get_home_directory();
cwd.append("dw");
