require ("global-overlay-keymap.js");
define_key_alias("C-m", "return");

define_key(content_buffer_normal_keymap, "t", "find-url-new-buffer");
define_key(content_buffer_normal_keymap, "d", "kill-current-buffer");

undefine_key(content_buffer_normal_keymap, "g");
define_key(content_buffer_normal_keymap, "g-t", "buffer-next");
define_key(content_buffer_normal_keymap, "g-T", "buffer-previous");

define_key(default_global_keymap, "U", "revive-buffer");
