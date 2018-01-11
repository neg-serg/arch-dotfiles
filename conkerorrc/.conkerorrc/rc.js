// the default page for new buffers.
homepage = "localhost:31831";

require("favicon");
require("session.js");
require("clicks-in-new-buffer.js");
require("block-content-focus-change.js");
require("content-policy.js");

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

session_pref("spellchecker.dictionary","en-CA");
session_pref("xpinstall.whitelist.required",false);
user_pref("devtools.debugger.remote-enabled",true);
// user_pref("media.autoplay.enabled",false); // setting this breaks many videos

session_auto_save_auto_load = "prompt";
session_save_buffer_access_order = true;
session_auto_save_auto_load_fn = session_auto_save_load_window_current;
session_pref("xpinstall.whitelist.required", false);
minibuffer_auto_complete_default = true;

url_remoting_fn = load_url_in_new_buffer;
url_completion_use_history = true;
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND;

xkcd_add_title = true;
read_buffer_show_icons = true;
view_source_use_external_editor = true;  // view source in your editor.

// enable if full screen video stops working
session_pref("full-screen-api.enabled", true);

// browser_prevent_automatic_form_focus_mode(true);
google_search_bind_number_shortcuts();

session_pref("font.minimum-size.zh-CN", 18);
