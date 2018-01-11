interactive("open-gmail", "Go to gmail", "follow", $browser_object = "http://gmail.com/");
interactive("open-gmail-new", "Go to gmail", "follow-new-buffer", $browser_object = "http://gmail.com/");

define_key(content_buffer_normal_keymap, "g o g", "open-gmail");
define_key(content_buffer_normal_keymap, "g n g", "open-gmail");
