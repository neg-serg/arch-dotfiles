require ("global-overlay-keymap.js");
define_key_alias("C-m", "return");

define_key(content_buffer_normal_keymap, "o", "find-url-from-history");
define_key(content_buffer_normal_keymap, "t", "find-url-new-buffer");
define_key(content_buffer_normal_keymap, "d", "kill-current-buffer");

undefine_key(content_buffer_normal_keymap, "g");
define_key(content_buffer_normal_keymap, "g t", "buffer-next");
define_key(content_buffer_normal_keymap, "g T", "buffer-previous");

undefine_key(content_buffer_normal_keymap, "C-n");
undefine_key(content_buffer_normal_keymap, "C-p");
define_key(content_buffer_normal_keymap, "j", "cmd_scrollLineDown");
define_key(content_buffer_normal_keymap, "k", "cmd_scrollLineUp");

define_key(default_global_keymap, "U", "revive-buffer");
