/**
 * (C) Copyright 2010 John J. Foerch
 *
 * Use, modification, and distribution are subject to the terms specified in the
 * COPYING file.
**/

function focus_follows_mouse_mouseover (event) {
    var n = event.target;
    if (n instanceof Ci.nsIDOMHTMLInputElement) {
        set_focus_no_scroll(this.ownerDocument.defaultView, n);
        return;
    }
    do {
        if (n instanceof Ci.nsIDOMHTMLAnchorElement) {
            set_focus_no_scroll(this.ownerDocument.defaultView, n);
            break;
        }
    } while ((n = n.parentNode));
}

define_buffer_mode("focus_follows_mouse_mode",
    function enable (buffer) {
        buffer.browser.addEventListener("mouseover",
                                        focus_follows_mouse_mouseover,
                                        true);
    },
    function disable (buffer) {
        buffer.browser.removeEventListener("mouseover",
                                           focus_follows_mouse_mouseover,
                                           true);
    },
    $display_name = "FFM",
    $doc = "Focus hyperlinks and input elements on mouseover.");


define_global_mode("global_focus_follows_mouse_mode",
    function enable () {
        for_each_buffer(function (buffer) {
            focus_follows_mouse_mode(buffer, true);
        });
        add_hook("create_buffer_hook", focus_follows_mouse_mode);
    },
    function disable () {
        for_each_buffer(function (buffer) {
            focus_follows_mouse_mode(buffer, false);
        });
        remove_hook("create_buffer_hook", focus_follows_mouse_mode);
    });


provide("focus-follows-mouse");
