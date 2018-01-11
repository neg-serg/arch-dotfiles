
function standards_info_widget (window) {
    this.class_name = "standards-info-widget";
    text_widget.call(this, window);
    // any time you switch buffers, update
    this.add_hook("select_buffer_hook", method_caller(this, this.update));
    // any time a buffer finishes loading, check
    this.add_hook("buffer_loaded_hook",
                  method_caller(this, this.set_flag));
    // any time a content buffer changes location, reset
    this.add_hook("content_buffer_location_change_hook",
                  method_caller(this, this.clear_flag));
}
standards_info_widget.prototype = {
    constructor: standards_info_widget,
    __proto__: text_widget.prototype,
    update: function () {
        var buffer = this.window.buffers.current;
        var str = 'unknown';
        if (! ('standards_info_flag' in buffer))
            buffer.standards_info_flag = buffer.loading; //XXX: content-buffer specific
        if (buffer.standards_info_flag == true) {
            if (buffer.document.compatMode &&
                buffer.document.compatMode == 'BackCompat')
            {
                str = 'quirks';
            } else
                str = 'standards';
        }
        this.view.text = str;
    },
    clear_flag: function (buffer) {
        buffer.standards_info_flag = false;
        if (buffer.window.buffers.current == buffer)
            this.update();
    },
    set_flag: function (buffer) {
        buffer.standards_info_flag = true;
        if (buffer.window.buffers.current == buffer)
            this.update();
    }
};

add_hook("mode_line_hook", mode_line_adder(standards_info_widget));
