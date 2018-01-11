// MPV (via scottj), play URL in mpv
var mpv_default_command = "mpv";
var mpv_last_command = mpv_last_command || mpv_default_command;
interactive("mpv","Play url in mpv",
            function (I) {
                var cwd = I.local.cwd;
                var element = yield read_browser_object(I);
                var spec = load_spec(element);
                var uri = load_spec_uri_string(spec);

                var panel = create_info_panel(
                    I.window,
                    "download-panel",
                    [["downloading",
                      element_get_operation_label(element,"Running on","URI"),
                      load_spec_uri_string(spec)],
                     ["mime-type","Mime type:",load_spec_mime_type(spec)]]);

                try {
                    var cmd = yield I.minibuffer.read_shell_command(
                        $cwd = cwd,
                        $initial_value = mpv_last_command);
                    mpv_last_command = cmd;
                } finally {
                    panel.destroy();
                }

                shell_command_with_argument_blind(cmd+" {}",uri,$cwd = cwd);
            },
            $browser_object = browser_object_links);

