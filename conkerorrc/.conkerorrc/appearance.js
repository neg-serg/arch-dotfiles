// fix crisp edges
register_user_stylesheet(make_css_data_uri(["* { image-rendering: -moz-crisp-edges; }"]));
read_buffer_show_icons = true;

hint_background_color = '#2b768d';
active_hint_background_color = '#005faf';

register_user_stylesheet(
    "data:text/css," +
        escape(
            "@namespace url(\"http://www.w3.org/1999/xhtml\");\n" +
            "span.__conkeror_hint {\n"+
            "  font-size: 12pt !important;\n"+
            "  font-family: Iosevka Term Heavy !important;\n"+
            "  line-height: 12pt !important;\n"+
            "}"));

register_user_stylesheet(
    "data:text/css," +
        escape (
            "span.__conkeror_hint {" +
                " border: 1px solid #222233 !important;" +
                " color: #ffffff !important;" +
                " background-color: #222288 !important;" +
            "}"));

// minibuffer colours
register_user_stylesheet(
    "data:text/css," +
    escape (
        "@namespace XUL_NS;\n" +
            " #minibuffer, .mode-line {" +
            " background-color:black;" +
            " color:white;" +
            "-moz-appearance:none;" +
            " border-top: 0px;}"));
