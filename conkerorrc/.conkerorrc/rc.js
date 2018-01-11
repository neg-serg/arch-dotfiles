// the default page for new buffers.
homepage = "localhost:31831";

require("favicon");
require("new-tabs.js");
tab_bar_show_icon = true;

require("github");
require("gmail");
require("reddit");
require("youtube");

require("page-modes/google-search-results.js");

require("session.js");
require("clicks-in-new-buffer.js");
require("block-content-focus-change.js");
require("content-policy.js");

session_auto_save_auto_load = true;
session_save_buffer_access_order = true;
session_auto_save_auto_load_fn = session_auto_save_load_window_current;

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
