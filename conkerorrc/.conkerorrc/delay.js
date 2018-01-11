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
