///
/// Auto-hide Minibuffer
///

var minibuffer_autohide_timer = null;
var minibuffer_autohide_message_timeout = 3000; //milliseconds to show messages
var minibuffer_mutually_exclusive_with_mode_line = true;

// var minibuffer_autohide_with_mode_line = true;

// function hide_minibuffer (window) {
//     window.minibuffer.element.collapsed = true;
//     if (minibuffer_autohide_with_mode_line && window.mode_line)
//         window.mode_line.container.collapsed = true;
// }

// function show_minibuffer (window) {
//     window.minibuffer.element.collapsed = false;
//     if (minibuffer_autohide_with_mode_line && window.mode_line)
//         window.mode_line.container.collapsed = false;
// }

function hide_minibuffer (window) {
    window.minibuffer.element.collapsed = true;
    if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
        window.mode_line.container.collapsed = false;
}

function show_minibuffer (window) {
    window.minibuffer.element.collapsed = false;
    if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
        window.mode_line.container.collapsed = true;
}

add_hook("window_initialize_hook", hide_minibuffer);
// for_each_window(hide_minibuffer); // initialize existing windows


var old_minibuffer_restore_state = (old_minibuffer_restore_state ||
                                    minibuffer.prototype._restore_state);
minibuffer.prototype._restore_state = function () {
    if (minibuffer_autohide_timer) {
        timer_cancel(minibuffer_autohide_timer);
        minibuffer_autohide_timer = null;
    }
    if (this.current_state)
        show_minibuffer(this.window);
    else
        hide_minibuffer(this.window);
    old_minibuffer_restore_state.call(this);
};

var old_minibuffer_show = (old_minibuffer_show || minibuffer.prototype.show);
minibuffer.prototype.show = function (str, force) {
    var w = this.window;
    show_minibuffer(w);
    old_minibuffer_show.call(this, str, force);
    if (minibuffer_autohide_timer)
        timer_cancel(minibuffer_autohide_timer);
    minibuffer_autohide_timer = call_after_timeout(
        function () { hide_minibuffer(w); },
        minibuffer_autohide_message_timeout);
};

var old_minibuffer_clear = (old_minibuffer_clear || minibuffer.prototype.clear);
minibuffer.prototype.clear = function () {
    if (minibuffer_autohide_timer) {
        timer_cancel(minibuffer_autohide_timer);
        minibuffer_autohide_timer = null;
    }
    if (! this.current_state)
        hide_minibuffer(this.window);
    old_minibuffer_clear.call(this);
};
