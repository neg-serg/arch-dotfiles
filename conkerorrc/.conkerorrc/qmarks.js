interactive("open-gmail", "Go to gmail", "follow", $browser_object = "http://gmail.com/");
interactive("open-gmail-new", "Go to gmail in the new buffer", "follow-new-buffer", $browser_object = "http://gmail.com/");
interactive("open-hackernews", "Go to hackernews", "follow", $browser_object = "https://news.ycombinator.com/");
interactive("open-hackernews-new", "Go to hackernews in the new buffer", "follow", $browser_object = "https://news.ycombinator.com/");

define_key(content_buffer_normal_keymap, "g o g", "open-gmail");
define_key(content_buffer_normal_keymap, "g n g", "open-gmail-new");
define_key(content_buffer_normal_keymap, "g o h", "open-hackernews");
define_key(content_buffer_normal_keymap, "g n h", "open-hackernews-new");
