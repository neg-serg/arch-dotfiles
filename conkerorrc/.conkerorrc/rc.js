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
session_auto_save_auto_load_fn = session_auto_save_load_window_current;

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
