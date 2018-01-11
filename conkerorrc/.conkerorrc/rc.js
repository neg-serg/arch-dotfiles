homepage = "localhost:31831"; // the default page for new buffers.

require("favicon");
require("session.js");
require("clicks-in-new-buffer.js");
require("content-policy.js");
// require("block-content-focus-change.js");

default_minibuffer_auto_complete_delay = 100;
window_extra_argument_max_delay = 10;

// session / user preferences
// browser.download.manager.closeWhenDone applies to built-in d/l window
//session_pref("browser.download.manager.closeWhenDone",true);
// line below causes YouTube audio to continue after leaving page
session_pref("general.useragent.compatMode.firefox",true);
session_pref("layout.spellcheckDefault",1);

//session_pref("network.proxy.http","127.0.0.1");
//session_pref("network.proxy.http_port",8118);
//session_pref('network.proxy.ssl', "127.0.0.1");
//session_pref('network.proxy.ssl_port',8118);
//session_pref("network.proxy.type",1);

user_pref('webgl.prefer-native-gl',            true);
user_pref('layers.acceleration.force-enabled', true);
user_pref('webgl.force-enabled',               true);
user_pref('webgl.msaa-force',                  true);
user_pref('gfx.filter.nearest.force-enabled',  true);
user_pref('stagefright.force-enabled',         true); // H264
user_pref('layers.acceleration.draw-fps',      false);

user_pref("extensions.checkCompatibility",     false);
user_pref("xpinstall.whitelist.required",      false);
user_pref("xpinstall.signatures.required",     false);
user_pref("devtools.debugger.remote-enabled",  false);
// user_pref("media.autoplay.enabled",false); // setting this breaks many videos
// enable if full screen video stops working
session_pref("full-screen-api.enabled", true);
session_pref("font.minimum-size.zh-CN", 18);

session_auto_save_auto_load_fn = session_auto_save_load_window_current;
session_auto_save_auto_load = "prompt";
session_save_buffer_access_order = true;
minibuffer_auto_complete_default = true;

url_remoting_fn = load_url_in_new_buffer;
url_completion_use_history = true;
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND;

xkcd_add_title = true;
read_buffer_show_icons = true;
view_source_use_external_editor = true;  // view source in your editor.

function my_zoom_set (buffer) { browser_zoom_set(buffer, false, 110); }
add_hook('create_buffer_late_hook', my_zoom_set);

external_content_handlers.set("application/pdf", "zathura");

require("ublt-buffer");
// require("ublt-launchers");
require("ublt-appearance");
// require("ublt-capture");
// require("ublt-download");
