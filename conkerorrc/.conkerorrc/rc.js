// the default page for new buffers.
homepage = "about:blank";

require("new-tabs.js");
require("favicon");
// require("tab-bar.js");

require("github");
require("gmail");
require("reddit");
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
session_auto_save_auto_load = "prompt";

url_remoting_fn = load_url_in_new_buffer;
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND;

xkcd_add_title = true;
read_buffer_show_icons = true;
view_source_use_external_editor = true;  // view source in your editor.

//set the temp dir location.  the idea is this can be on /tmpfs in ram.
//This will not take effect until after the first restart.
user_pref("browser.cache.disk.parent_directory","/tmp/sketch/conkeror");

// set_user_agent("Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.6.17-1.fc14 Firefox/3.6.17");
// don't set the user agent, let conk add Firefox to the string itself
session_pref("general.useragent.compatMode.firefox",true);

////enable if full screen video stops working
//session_pref("full-screen-api.enabled", true);

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

// // Webjump oneliners
// define_webjump("codesearch", "http://codesearch.debian.net/search?q=%s");
// define_webjump("leo", "http://dict.leo.org/?lp=ende&lang=de&searchLoc=0&cmpType=relaxed&relink=on&sectHdr=off&spellToler=std&search=%s");
// define_webjump("identica", "http://identi.ca/%s");
// define_webjump("imdb", "http://imdb.com/find?q=%s");
// define_webjump("kol", "http://kol.coldfront.net/thekolwiki/index.php/%s");
// define_webjump("oh", "https://www.openhub.net/p?query=%s");
// define_webjump("ixquick", "http://ixquick.com/do/metasearch.pl?query=%s");
// define_webjump("trans", "http://translate.google.com/translate_t#auto|en|%s");
// define_webjump("twitter", "https://twitter.com/%s");
// define_webjump("urban", "http://www.urbandictionary.com/define.php?term=%s");
// define_webjump("wolframalpha", "http://www.wolframalpha.com/input/?i=%s");
// define_webjump("youtube", "http://www.youtube.com/results?search_query=%s&search=Search");

// // CVE
// define_webjump("cve", "https://cve.mitre.org/cgi-bin/cvename.cgi?name=%s");

// Additional key bindings
define_key(content_buffer_normal_keymap, "t", "find-url-new-buffer");
define_key(content_buffer_normal_keymap, "d", "delete-window");
